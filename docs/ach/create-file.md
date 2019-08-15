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

Our ACH HTTP server also handles [uploading raw ACH files](https://api.moov.io/#operation/createFile) which is the NACHA text format. We have [example ACH files](https://github.com/moov-io/ach/blob/master/test/testdata/ppd-debit.ach) in their NACHA format.

Note: The header `Content-Type: text/plain` should be set.
