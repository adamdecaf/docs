## Checks

Various levels of affirmation can be set on a `Customer` object. These are: `None`, `KYC`, `OFAC`, and `CIP`. Each later status can only be obtained after the previous one, so `OFAC` affirms `KYC` checks have passed.

### KYC

[Know Your Customer](https://en.wikipedia.org/wiki/Know_your_customer) (KYC) checks are ran over a Customers First/Last name, birth date and address. These are not currently checked against a third-party service, but we plan to integrate such solutions.

### OFAC

Customers uses [Moov Watchman](/watchman/) for performing OFAC checks against the government data files. All United States companies are required to comply with various regulations and sanction lists, so this is enabled by default.

OFAC results are stored in the database and the latest search result is used to reject positives matches.

```
$ curl -s localhost:8087/customers/:id/ofac | jq .
{
  "entityId": "11969",
  "sdnName": "...",
  "sdnType": "individual",
  "match": 0.76421,
  "createdAt": "2020-02-25T19:52:29.5918211Z"
}
```

OFAC match results over `OFAC_MATCH_THRESHOLD` will prevent the Customer from obtaining an `OFAC` status.

#### Refreshing OFAC Searches

Clients can call `PUT /customers/:id/refresh/ofac` to manually refresh a customers OFAC search results.

### CIP

[Customer Identification Program](https://en.wikipedia.org/wiki/Customer_Identification_Program) (CIP) performs Social Security Number (SSN) validation over the Customers stored SSN. Currently we do not perform validation against a third-party, but plan to.
