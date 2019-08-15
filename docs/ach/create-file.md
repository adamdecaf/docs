## Setup our ACH file

Creating an Automated Clearing House (ACH) file can be done several ways:

- [using Go and our generated client](#go-client)
- [uploading a JSON representation](#upload-a-json-representation)
- [uploading a raw ACH file](#upload-a-json-representation)

### Go Client

We have an example of [using our Go client and uploading the JSON representation](https://github.com/moov-io/ach/blob/master/examples/http/main.go). The basic idea follows this structure:

1. Create a [BatchHeader](https://godoc.org/github.com/moov-io/ach#BatchHeader) record with `ach.NewBatchHeader()`.
1. Create an [EntryDetail](https://godoc.org/github.com/moov-io/ach#EntryDetail) record with `ach.NewEntryDetail()`.
1. Create a [Batch](https://godoc.org/github.com/moov-io/ach#Batch) from our `BatchHeader` and `EntryDetail`.
   1. Using a constructor like `batch := ach.NewBatchPPD(batchHeader)` and adding the batch with `batch.AddEntry(entry)`.
   1. Call and verify `batch.Create()` returns no error.
1. Create our ACH File record `file := ach.NewFile()` and [FileHeader](https://godoc.org/github.com/moov-io/ach#FileHeader) with `ach.NewFileHeader()`
1. Add the `FileHeader` (via `file.SetHeader(fileHeader)`) and `Batch` records to the file (via `file.AddBatch(batch)`).
   1. Call and verify `file.Create()` returns no error.
1. Encode the `File` to JSON (via `json.NewEncoder(&buf).Encode(&file)`) for a `net/http` request.

### Upload a JSON representation

In Ruby we have an example of [creating an ACH file from JSON](https://github.com/moov-io/ruby-ach-demo/blob/master/main.rb). The JSON structure corresponds to our [api endpoint for creating files](https://api.moov.io/#operation/createFile) that the ACH HTTP server expects.

We have [example ACH files](https://github.com/moov-io/ach/blob/master/test/testdata/ppd-valid.json) in JSON.

Note: The header `Content-Type: application/json` must be set.

### Upload a raw ACH file

Our ACH HTTP server also handles [uploading raw ACH files](https://api.moov.io/#operation/createFile) which is the NACHA text format.  We have example files in their NACHA format and example code for creating the files and reading the files.

| SEC Code | Description | Example ACH File | Read | Create
| :---: | :---: | :---: | :--- | :--- |
| ACK | Acknowledgment Entry for CCD | [Credit](test/ach-ack-read/ack-read.ach) | [ACK Read](examples/ach-ack-read/main.go) | [ACK Create](examples/ach-ack-write/main.go) |
| ADV | Automated Accounting Advice | [Prenote Debit](test/ach-adv-read/adv-read.ach) | [ADV Read](examples/ach-adv-read/main.go) | [ADV Create](examples/ach-adv-write/main.go) |
| ARC | Accounts Receivable Entry | [Debit](test/ach-arc-read/arc-debit.ach) | [ARC Read](examples/ach-arc-read/main.go) | [ARC Create](examples/ach-arc-write/main.go) |
| ATX | Acknowledgment Entry for CTX | [Credit](test/ach-atx-read/atx-read.ach) | [ATX Read](examples/ach-atx-read/main.go) | [ATX Create](examples/ach-atx-write/main.go) |
| BOC | Back Office Conversion | [Debit](test/ach-boc-read/boc-debit.ach) | [BOC Read](examples/ach-boc-read/main.go) | [BOC Create](examples/ach-boc-write/main.go) |
| CCD | Corporate credit or debit | [Debit](test/ach-ccd-read/ccd-debit.ach) | [CCD Read](examples/ach-ccd-read/main.go) | [CCD Create](examples/ach-ccd-write/main.go) |
| CIE | Customer-Initiated Entry | [Credit](test/ach-cie-read/cie-credit.ach) | [CIE Read](examples/ach-cie-read/main.go) | [CIE Create](examples/ach-cie-write/main.go) |
| COR | Automated Notification of Change(NOC) | [NOC](test/ach-cor-read/cor-read.ach)   | [COR Read](examples/ach-cor-read/main.go) | [COR Create](examples/ach-cor-write/main.go) |
| CTX | Corporate Trade Exchange | [Debit](test/ach-ctx-read/ctx-debit.ach) | [CTX Read](examples/ach-ctx-read/main.go) | [CTX Create](examples/ach-ctx-write/main.go) |
| DNE | Death Notification Entry | [DNE](test/ach-dne-read/dne-read.ach) | [DNE Read](examples/ach-dne-read/main.go) | [DNE Create](examples/ach-dne-write/main.go) |
| ENR | Automatic Enrollment Entry | [ENR](test/ach-enr-read/enr-read.ach) | [ENR Read](examples/ach-enr-read/main.go) | [ENR Create](examples/ach-enr-write/main.go) |
| IAT | International ACH Transactions | [Credit](test/ach-iat-read/iat-credit.ach) | [IAT Read](examples/ach-iat-read/main.go) | [IAT Create](examples/ach-iat-write/main.go) |
| MTE | Machine Transfer Entry | [Credit](test/ach-mte-read/mte-read.ach) | [MTE Read](examples/ach-mte-read/main.go) | [MTE Create](examples/ach-mte-write/main.go) |
| POP | Point of Purchase | [Debit](test/ach-pop-read/pop-debit.ach) | [POP Read](examples/ach-pop-read/main.go) | [POP Create](examples/ach-pop-write/main.go) |
| POS | Point of Sale | [Debit](test/ach-pos-read/pos-debit.ach) | [POS Read](examples/ach-pos-read/main.go) | [POS Create](examples/ach-pos-write/main.go) |
| PPD | Prearranged payment and deposits | [Debit](test/ach-ppd-read/ppd-debit.ach) and [Credit](test/ach-ppd-read/ppd-credit.ach) | [PPD Read](examples/ach-ppd-read/main.go) | [PPD Create](examples/ach-ppd-write/main.go) |
| RCK | Represented Check Entries | [Debit](test/ach-rck-read/rck-debit.ach) | [RCK Read](examples/ach-rck-read/main.go) | [RCK Create](examples/ach-rck-write/main.go) |
| SHR | Shared Network Entry | [Debit](test/ach-shr-read/shr-debit.ach) | [SHR Read](examples/ach-shr-read/main.go) | [SHR Create](examples/ach-shr-write/main.go) |
| TEL | Telephone-Initiated Entry | [Debit](test/ach-tel-read/tel-debit.ach) | [TEL Read](examples/ach-tel-read/main.go) | [TEL Create](examples/ach-tel-write/main.go) |
| TRC | Truncated Check Entry | [Debit](test/ach-trc-read/trc-debit.ach) | [TRC Read](examples/ach-trc-read/main.go) | [TRC Create](examples/ach-trc-write/main.go) |
| TRX | Check Truncation Entries Exchange | [Debit](test/ach-trx-read/trx-debit.ach) | [TRX Read](examples/ach-trx-read/main.go) | [TRX Create](examples/ach-trx-write/main.go) |
| WEB | Internet-initiated Entries | [Credit](test/ach-web-read/web-credit.ach) | [WEB Read](examples/ach-web-read/main.go) | [WEB Create](examples/ach-web-write/main.go) |
| XCK | Destroyed Check Entry | [Debit](test/ach-xck-read/xck-debit.ach)  | [XCK Read](examples/ach-xck-read/main.go) | [XCK Create](examples/ach-xck-write/main.go) |


Note: The header `Content-Type: text/plain` should be set.
