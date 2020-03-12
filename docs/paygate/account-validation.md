In order to validate `Depository` objects and transfer money PayGate needs to verify the user is authorized to access the `Depository`. This typically involves micro-deposits (sending two debits under $1 to the account and having the user confirm these amounts) followed by a credit from the account to balance the accounting.

## Micro Deposits

micro-deposits are used as one option for verifying accounts used in ACH transactions. Account validation is an important and required aspect of originating ACH credits and debits. Using an incorrect routing and transit number and/or account number for the recipient of an ACH transaction can cost a business both time and money.

PayGate submits small deposits, credits the balance and has the user confirm the amounts manually. This is only required once per `Depository`. To setup the funding account for these deposits the following configuration options for paygate are below and are all required:

### ODFI Account

The Originator Depository Financial Institution (ODFI) will have an account setup to initiate the credits and debit against the proposed remote account.

| Environmental Variable | Description | Default |
|-----|-----|-----|
| `ODFI_ACCOUNT_NUMBER` | Account Number of Financial Institution which is originating micro deposits. | 123 |
| `ODFI_ACCOUNT_TYPE` | Type of ODFI account used for micro-depsits (Checking or Savings) | Savings |
| `ODFI_BANK_NAME` | Legal name of Financial Institution which is originating micro deposits. | Moov, Inc |
| `ODFI_HOLDER` | Legal name of Financial Institution which is originating micro deposits. | Moov, Inc |
| `ODFI_IDENTIFICATION` | Number by which the customer is known to the Financial Institution originating micro deposits. | 001 |
| `ODFI_ROUTING_NUMBER` | ABA routing number of Financial Institution which is originating micro deposits. | 121042882 |

### Allowed Attempts

Each `Depository` has a maximum number of attempts for verification. This is set as an audit trail and to prevent endless attempts as a result of brute forcing values or overloading paygate's resources. By default the maximum allowed attemps for a Depository is 5.

### Metrics

Two metrics are exported: `micro_deposits_initiated` and `micro_deposits_confirmed` which are counts of each respective action performed by clients.

## Instant Account Validation

[Instant Account Validation](#) (IAT) is a technique used to approve `Depository` objects faster than the typical 2-3 business days with micro-deposits.

### Plaid

We are currenty working on integrating [Plaid](https://plaid.com/docs/#introduction) to use for IAT. Please see the `#paygate` [channel in slack](https://slack.moov.io) for discussion.
