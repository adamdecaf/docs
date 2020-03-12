Moov works to make it easier for developers to integrate with banks, credit unions, and payment platforms. We believe that empowering individuals and companies in an open community helps better serve all of our customers and technologies.

## What are you trying to do?

### Read and write ACH files

We offer [Moov ACH](./ach/) as a Go library and HTTP service to create, manage, and parse ACH files.

### Run a full ACH origination service

We offer [Moov PayGate](./paygate/) as a service written in Go to operate as a full ACH originator. The project is under active partnership with several large existing originators.

### Use a General Ledger and accounting system

We're building [Moov Accounts](./accounts/) as a general ledger and transaction store of record in an HTTP service.

### Verify Federal Reserve ACH or Wire routing numbers

We built [Moov Fed](./fed/) to parse Federal Reserve data files for ACH and Wire participants bundled in an HTTP service.

### Validate customer records

We built [Moov Customers](./customers/) as a HTTP service to track, validate and authenticate customer records with OFAC, Know Your Customer (KYC), Customer Identity Protection (CIP) checks.

### Lookup and comply with sanction laws or restrictions

We built [Moov Watchman](./watchman) which indexes the latest sanction lists from the United States government for compliance with Anti Money Laundring (AML) regulations.

### Read and write ImageCashLetter / Check21 files

We've built [Moov ImageCashLetter](./icl/) (ICL) as a Go library and HTTP service to create, manage, and parse ICL files.

### Read and write Wire files

We've built [Moov Wire](./wire/) as a Go library and HTTP service to create, manage, and parse Wire files.
