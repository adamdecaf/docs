## ACH Operations

While Paygate is featured as a RESTful API for transferring money over the Automated Clearing House (ACH) network paygate also functions as an ACH file shipping, merging and routing optimization service. This means that Financial Institutions (FI) can leverage paygate to reduce cost and increase efficiency of their ACH network.

### Transfer Submission

Paygate will periodically enqueue transfers for submission to the larger ACH network. Paygate does so by merging transfers into larger ACH files to be sent to another FI according to payment window cutoff times (e.g. 5pm in New York) or file based limitations. Typically this periodic operation occurs every 10 minutes, but can be configured with `ACH_FILE_TRANSFER_INTERVAL=5m` (for 5 minutes).

ACH files that are merged do not modify any specific transfers, but are primarily done so to reduce cost charged by the Federal Reserve for ACH payments.

### OFAC Checks

As required by United States law and NACHA guidelines all transfers are checked against the Office of Foreign Asset Control (OFAC) lists for sanctioned individuals and entities to combat fraud, terrorism and unlawful monetary transfers outside of the United States. Paygate defers to Moov's [Customers](https://github.com/moov-io/customers) service for performing these checks.

### Merging of ACH Files

ACH transfers are merged (grouped) according their destination routing numbers and optionally other properties (i.e. splitting credits and debits into two separate files) prior to submission.

The code paths for [merging and uploading ACH files is within `filetransfer.Controller`](../internal/filetransfer/controller.go) and there is a Prometheus metric exposed for tracking merged ACH transfers `transfers_merged_into_ach_files{destination="..", origin=".."}`.

#### Advanced Routing

The [US Federal Reserve](https://en.wikipedia.org/wiki/Federal_Reserve_Bank) has multiple locations where we can have ACH files sent to. Some Financial Institutions optimize routing of files to allow processing during the same calendar day or to benefit from physical locality. This is done in part by the ABA routing number prefix. Paygate has long term plans to perform routing optimizations like this, but currently does no such optimization.

### Uploads of Merged ACH Files

ACH files which are uploaded to another FI primarily use FTP(s) ([File Transport Protocol](https://en.wikipedia.org/wiki/File_Transfer_Protocol) with TLS) or SFTP ([SSH File Transfer Protocol](https://en.wikipedia.org/wiki/SSH_File_Transfer_Protocol)) and follow a filename pattern like: `YYYYMMDD-ABA-N.ach` (example: `20181222-301234567-1.ach`). The configuration is stored within a database that Paygate controls and can be modified with admin HTTP endpoints.

Paygate currently offers a read endpoint for the configuration related to file uploads. Call `GET /configs/uploads` against the admin server (`:9092` by default) to retrieve a JSON representation of the configuration.

Otherwise, the following SQLite and MySQL tables can be configured. Insert, update or delete rows from the following:

- `cutoff_times`: Last time of each operating day for ACH file uploads to be processed.
   - Example: cutoff: `1700` (5pm), location: `America/New_York` (IANA Time Zone database values)
- `file_transfer_configs`: Path configuration for inbound, outbound, and return directories on the FTP server.
- `ftp_configs`: FTP(s) configuration for ACH file uploads (authentication and connection parameters).
- `sftp_configs`: SFTP configuration for ACH file uploads (authentication and connection parameters).

There is a Prometheus metric exposed for tracking ACH file uploads `ach_files_uploaded{destination="..", origin=".."}` and `missing_ach_file_upload_configs{routing_number="..."}` which counts how often configurations aren't found for given routing numbers. These need to be addressed by a human operator (insert the proper configurations) so files can be uploaded to a Financial Institution.

#### File-based Upload Configuration

Paygate supports reading a config file (via `CONFIG_FILE=/conf/config.yml`) for ACH file uploads to their remote ODFI server. The structure follows the admin HTTP endpoints, but is configured in YAML.

- [Example upload configuration file](https://github.com/moov-io/paygate/blob/master/testdata/configs/routing-good.yaml)

#### Filename templates

Paygate supports templated naming of ACH files prior to their upload. This is helpful for ODFI's which require specific naming of uploaded files. Templates use Go's [`text/template` syntax](https://golang.org/pkg/text/template/) and are validated when paygate starts or changed via admin endpoints.

Example:

```
{{ date "20060102" }}-{{ .RoutingNumber }}-{{ .N }}.ach{{ if .GPG }}.gpg{{ end }}
```

The following struct is passed to templates giving them data to build a filename from:

```Go
type filenameData struct {
	RoutingNumber string
	TransferType  string

	// N is the sequence number for this file
	N string

	// GPG is true if the file has been encrypted with GPG
	GPG bool
}
```

Also, several functions are available (in addition to Go's standard template functions)

- `date`: Takes a Go [`Time` format](https://golang.org/pkg/time/#Time.Format) and returns the formatted string
- `env` Takes an environment variable name and returns the value from `os.Getenv`.

Note: By default filenames have sequence numbers which are incremented by paygate and are assumed to be in a specific format. It is currently (as of 2019-10-14) undefined behavior what happens to incremented sequence numbers when filenames are in a different format. Please open issue if you run into problems here.

#### IP Whitelisting

When paygate uploads an ACH file to the ODFI server it can verify the remote server's hostname resolves to a whitelisted IP or CIDR range. This supports certain network controls to prevent DNS poisoning or misconfigured routing.

Setting `file_transfer_configs.allowed_ips` can be done with values like: `35.211.43.9` (specific IP address), `10.4.0.0/16` (CIDR range), `10.1.0.12,10.3.0.0/16` (Multiple values)

#### Force Merge and Upload of ACH files

Paygate supports admin endpoints for manually initiating the processing of inbound and outbound files. These are designed to push files sooner than the typical interval (default 10 minutes), which is helpful in debugging, testing, or local development.

There's an endpoint for initiating both inbound and outbound processing: `POST :9092/files/flush`.

There are endpoints for just inbound or outbound file processing:

- `POST /files/flush/incoming`
- `POST /files/flush/outgoing`

Note: The query parameter `?wait` can be added onto any endpoint to hold the HTTP response until file operations are done. This has the potential of returning a timeout however, and the file operations will continue.

Note: These endpoints currently return no information in the HTTP response and instead inspect paygate's logs for details.

#### SFTP Host and Client Key Verification

Paygate can verify the remote SFTP server's host key prior to uploading files and it can have a client key provided. Both methods assist in authenticating paygate and the remote server prior to any file uploads.

**Public Key** (SSH Authorized key format)

```
Column: file_transfer_configs.host_public_key

Format: ssh-rsa AAAAB...wwW95ttP3pdwb7Z computer-hostname
```

**Private Key** (PKCS#8)

```
Column: file_transfer_configs.client_private_key

Format:
-----BEGIN RSA PRIVATE KEY-----
...
33QwOLPLAkEA0NNUb+z4ebVVHyvSwF5jhfJxigim+s49KuzJ1+A2RaSApGyBZiwS
...
-----END RSA PRIVATE KEY-----
```

Note: Public and Private keys can be encoded with base64 from the following formats or kept as-is. We expect Go's `base64.StdEncoding` encoding (not base64 URL encoding).

### Returned ACH Files

Returned ACH files are downloaded via SFTP by paygate and processed. Each file is expected to have an [Addenda99](https://godoc.org/github.com/moov-io/ach#Addenda99) ACH record containing a return code. This return code is used sometimes to update the Depository status. Transfers are always marked as `reclaimed` upon their return being processed.

`Depository` objects have their status updated to `Rejected` under a set of NACHA return codes. This is done because there's an issue with some property of the depository (routing number, account number, etc) and typically needs to be fixed by the user which created it. Retrieving the Depository details from paygate's HTTP server will return the most recent return code and an error description.

### Incoming ACH Files

Incoming ACH files are downloaded via SFTP by paygate and processed. Each file is expected to be an IAT file or be a NOC/COR file with an [Addenda98](https://godoc.org/github.com/moov-io/ach#Addenda98) ACH record containing a change code. This change code is used to indicate which `Depository` fields of the file are incorrect and need changed before uploading to the ODFI's server again.

By default Paygate does not update user-created objects from these files, but it can automatically update them by setting the `UPDATE_DEPOSITORIES_FROM_CHANGE_CODE=yes` environment variable. When these automatic updates are disabled the Depository Statuses are `Rejected` along with the `Transfer`.
