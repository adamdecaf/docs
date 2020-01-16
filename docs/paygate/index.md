[Moov's PayGate project](https://github.com/moov-io/paygate) provides an HTTP REST endpoint for submitting and receiving ACH payments and builds upon a suite of services offered by Moov, including [ACH](https://github.com/moov-io/ach), [Watchman](https://github.com/moov-io/watchman), and [FED](https://github.com/moov-io/fed). Each of these services must be running and reachable by PayGate. We provide several examples of setting up a complete installation using [Docker Compose](https://docs.docker.com/compose/), Kubernetes, or directly using the provided binaries.

### Running PayGate locally using Docker Compose (Quickest)

PayGate can be quickly ran using the provided [Docker Compose file](https://github.com/moov-io/paygate/blob/master/docker-compose.yml). Note that you may need to adjust some environment variables in this file before running it, for example the `DEFAULT_ROUTING_NUMBER` account variable.

First, [install Docker Compose](https://docs.docker.com/compose/install/) for your platform.  Then clone the repository and run `docker-compose up` within it.

```
$ git clone https://github.com/moov-io/paygate.git
$ cd paygate
$ docker-compose up -d
```

That's it! Your PayGate endpoint should be accessible at `http://localhost:8082`. You can verify paygate is running with `curl http://localhost:8082/ping` and monitor the health with `curl http://localhost:9092/live`.

### Running PayGate using Kubernetes (Advanced)

Moov uses [Kubernetes](https://kubernetes.io/) for deploying [its own infrastructure](https://github.com/moov-io/infra) on development and production machines.  The instructions on the readme are a good place to start.  Follow the instructions from the [local development](https://github.com/moov-io/infra#local-development) section on the infra readme.

### Running from source

PayGate can run directly from source using Go, but the required services need to be running as well. The default port 8082 is used unless otherwise specified as an attribute `-http.addr` and needs environment variables setup beforehand as [outlined here](https://github.com/moov-io/paygate#configuration).

```
# With Golang and git installed:
$ git clone https://github.com/moov-io/paygate.git
$ cd paygate
$ go run .
```

## Testing endpoints

In order to check that the services are running, moov provides an api tool ([`apitest`](https://github.com/moov-io/api#apitest)) for testing the endpoints [with binaries you can download](https://github.com/moov-io/api/releases). Once downloaded running `apitest -local` will create Customer, Receiver, Depository, and a Transfer against your local docker compose stack.

```
# For Linux
$ wget https://github.com/moov-io/api/releases/download/v0.10.0/apitest-linux-amd64
$ mv apitest-linux-amd64 apitest && chmod +x apitest

# For OSX
$ wget https://github.com/moov-io/api/releases/download/v0.10.0/apitest-darwin-amd64
$ mv apitest-darwin-amd64 apitest && chmod +x apitest

# For docker compose setup or the running binaries using default values.
$ ./apitest -local

# For Tilt setup using Kubernetes
$ ./apitest -dev

# For other options, run
$ ./apitest -help
```

## Configuring Data

After confirming that the services are running correctly, there are several things needed before ACH transactions can be created/processed using PayGate.  Listed below are the steps necessary:

1. [Setup a Depository](https://api.moov.io/#operation/addDepository) for the Originator (ODFI)
1. Setup a Depository for the Receiver as well (RDFI)
1. [Setup an Originator](https://api.moov.io/#operation/addOriginator)
1. [Setup a Receiver](https://api.moov.io/#operation/addReceivers)
1. Then you can [create a transaction](https://api.moov.io/#operation/addTransfer) between these two FIs

### X-User-ID

The HTTP header `X-User-ID` is required and used to isolate objects (e.g. `Depository`, `Originator`) when using paygate in a multi-tenant setup. This is useful if you're managing transfers for multiple customers/users or multiple Financial Institutions. The value for this header can be a UTF-8 string, but typically it is a random alphanumeric string.

## Setup FTP

PayGate currently requires the FTP configuration to be manually setup in the database. [See here](https://github.com/moov-io/paygate/blob/master/docs/ach.md#uploads-of-merged-ach-files) for more information.

### MySQL

MySQL is a database which applications or developers connect to over the network. This means to configure paygate's FTP and file upload configuration a developer needs to connect to the database.

```
# Connect using host, username and password for your setup
$ mysql -h localhost:3306 -u paygate

> INSERT INTO ftp_configs (routing_number, hostname, username, password) VALUES ('000000000', 'localhost:22', 'myusername', 'mypassword');

> INSERT INTO cutoff_times (routing_number, cutoff, location) VALUES ('000000000', '1700', 'America/New_York');

> INSERT INTO file_transfer_configs (routing_number, inbound_path, outbound_path, return_path) VALUES ('000000000', '/inbound', '/outbound', '/returns');
```

### SQLite

If using the Docker Compose and sqlite (`DATABASE_TYPE=sqlite`) script above, you need to mount the `/data` volume of the `paygate` section in `docker-compose.yml` file like so:
```
  paygate:
    image: moov/paygate:v0.5.0-dev
    ports:
      - "8082:8082"
      - "9092:9092"
    command: ["-http.addr", ":8082"]
    environment:
      ACCOUNTS_ENDPOINT: 'http://accounts:8085'
      ACH_ENDPOINT: 'http://ach:8080'
      FED_ENDPOINT: 'http://fed:8086'
      CUSTOMERS_ENDPOINT: 'http://customers:8087'
    volumes:
      - .:/data
    depends_on:
      - ach
      - accounts
      - fed
      - customers
      - auth
```
This will attach the `/data` volume within the image to the same directory in which the `docker-compose.yml` file resides.

To setup FTP, run the following commands on the now exposed `paygate.db` file, changing the dummy string values below:
```
# Setup credentials for sqlite3
$ sqlite3 paygate.db "INSERT INTO ftp_configs (routing_number, hostname, username, password) VALUES ('000000000', 'localhost:22', 'myusername', 'mypassword');"

# Setup cutoff times
$ sqlite3 paygate.db "INSERT INTO cutoff_times (routing_number, cutoff, location) VALUES ('000000000', '1700', 'America/New_York');"

# Setup ftp directories
$ sqlite3 paygate.db "INSERT INTO file_transfer_configs (routing_number, inbound_path, outbound_path, return_path) VALUES ('000000000', '/inbound', '/outbound', '/returns');"
```
The command may need to be ran with elevated privileges, using `sudo` or another method. The database will also need to be writable.

## Verify FTP configuration

Paygaet's admin HTTP interface offers endpoints to check these values were setup (default on port `:9092`).

```
curl -s -X GET http://localhost:9092/configs/uploads | jq .
{
  "cutoffTimes": [
    {
      "RoutingNumber": "121042882",
      "Cutoff": 1700,
      "Location": "America/New_York"
    }
  ],
  "ftpConfigs": [
    {
      "RoutingNumber": "121042882",
      "Hostname": "localhost:2121",
      "Username": "admin",
      "Password": "1****6"
    }
  ],
  "fileTransferConfigs": [
    {
      "RoutingNumber": "121042882",
      "InboundPath": "inbound/",
      "OutboundPath": "outbound/",
      "ReturnPath": "returned/"
    }
  ]
}
```
