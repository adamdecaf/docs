[Moov Customers](/customers) is used by PayGate as a service to ensure customers created by `Originator` and `Receiver` pass Anit-Money Laundering (AML), Know Your Customer (KYC), and other checks required by the US Government.

To disable calls from PayGate to an Customers service set `CUSTOMERS_CALLS_DISABLED=yes`. This should only be used when customers are verified outside of PayGate as skipping this step is a violation of federal law.

### OFAC Searches

Customers performs searches against the OFAC list of entities which US businesses are blocked from doing business with. This list changes frequently with world politics and policies.

PayGate requires customers be in `OFAC` or greater status from Customers in order for `Transfers` to be accepted.g

#### Periodic Refreshing

By default PayGate will refresh a customer's OFAC search weekly to ensure they do not appear on the blocked entities list. To change this set `CUSTOMERS_OFAC_REFRESH_EVERY=30d` when running PayGate.

### Disclaimers

Before `Transfer` objects can be created the user needs to accept various legal agreements. Having unaccepted disclaimers will result in `Transfer` creation failing with an error message.
