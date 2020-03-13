[Moov Accounts](/accounts/) is used by PayGate to track transactions in an external ledger. This is required as one service needs to be the system of record. The interface PayGate expects is minimal and designed to be vendor agnostic.

To disable calls from PayGate to an Accounts service set `ACCOUNTS_CALLS_DISABLED=yes`.

### Searching Accounts

PayGate has a couple operations which require an account lookup. These are around finding the ODFI account and posting transactions on micro-deposits or transfers.

### Posting Transactions

PayGate will post any transfer or micro-deposit it creates against the Accounts service. This is ot ensure accurate accounting in the external ledger.
