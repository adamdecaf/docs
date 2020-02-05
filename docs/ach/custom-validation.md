ACH files can vary sometimes from the official NACHA guidelines due to vendor changes. Moov ACH defaults to NACHA guidelines, so to handle this there's an exported `ValidateWith(opts)` method on some structures (`File`, `FileHeader`, etc). The `opts` struct, [`ValidateOpts`](https://godoc.org/github.com/moov-io/ach#ValidateOpts) can have fields added in minor releases without breaking API compatibility with callers. The default values in this struct with match NACHA's guidelines.

- [`File.ValidateWith`](https://godoc.org/github.com/moov-io/ach#File.ValidateWith)
- [`FileHeader.ValidateWith`](https://godoc.org/github.com/moov-io/ach#FileHeader.ValidateWith)

Please refer to [`ValidateOpts`](https://godoc.org/github.com/moov-io/ach#ValidateOpts) for the version of Moov ACH you're using.

```go
file, err := ach.NewReader(fd).Open()
if err != nil {
    // error handling
}

// set ImmediateOrigin to a vendor specific value
file.Header.ImmediateOrigin = "0000000000"

err = file.ValidateWith(ach.ValidateOpts{
    BypassOriginValidation: true,
})
if err != nil {
    // error handling
}
```
