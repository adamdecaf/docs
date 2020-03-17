### Accounts

#### I don't need Accounts or a General Ledger (GL)

PayGate can report transactions and lookup account balances with an Account implementation, however it's common to disable this if PayGate is deployed to only create and upload ACH files.

Set <code>CUSTOMERS_CALLS_DISABLED=yes</code> to disable these accounting calls.

### Customers

#### I don't need Customers checks. No KYC/OFAC/CIP verification

This option is typically only used when authorization has been previously approved. Such approval is required by federal regulations.

Set <code>CUSTOMERS_CALLS_DISABLED=yes</code> to disable these checks.

#### problem with Customer checks ...  has unacceptable status=none for Transfers

The <code>status=none</code> is talking about that Customer not having KYC/OFAC checks performed yet. Attempt an <a href="https://api.moov.io/admin/customers/#put-/customers/{customerID}/status">update to the Customer status</a> will perform the needed checks.
