`Customer` and `Account` objects must be validated in order to transfer money and for US businesses to do business. This is to ensure the customer is an entity not blacklisted by the US government along with being authorized at the Financial Institution to transact using the Account. This typically involves an OFAC/KYC check for the Customer and micro-deposits (sending two debits under $0.50 to the account and having the user confirm these amounts) followed by a credit from the account to balance the accounting.

## Micro Deposits

micro-deposits are used as one option for verifying accounts used in ACH transactions. Account validation is an important and required aspect of originating ACH credits and debits. Using an incorrect routing and transit number and/or account number for the recipient of an ACH transaction can cost a business both time and money.

PayGate submits small deposits, credits the balance and has the user confirm the amounts manually. This is only required once per `Account`.

### Metrics

Two metrics are exported: `micro_deposits_initiated` and `micro_deposits_confirmed` which are counts of each respective action performed by clients.

## Instant Account Validation

Instant Account Validation is a technique used to approve `Account` objects faster than the typical 2-3 business days with micro-deposits.

We are currently working on integrations with vendors to allow instant account validation. Join the `#paygate` [channel in slack](https://slack.moov.io) for discussion and more details.
