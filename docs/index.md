# Welcome

**Welcome to the Moov developer site!** Moov's mission is to give developers an easy way to create and integrate bank processing into their own software products. Here you will find documentation to help you start building with Moov as quickly as possible. If you get stuck along the way, we are always here to help!

## Moov Projects

Moov projects are focused on solving a single responsibility capability in financial services. Projects can be leveraged as a RESTFul service or GoLang library and are built from source into an OS specific binary and docker container. Deployment of Moov projects can be deployed as a binary on your application server, as a docker container, or leverage the our hosted API [api.moov.io](https://api.moov.io) endpoints.

### Payments

Process funds with the following settlement methods:

- [Moov ACH](./ach/) (including Same Day ACH) implements a NACHA compliant RESTFul API for file creation, parsing, and validation. Supports generating and parsing all Standard Entry Class (SEC) codes. ACH is the primary method of electronic money movement throughout the United States.
- [Moov PayGate](./paygate/) provides a complete implementation of ACH origination (file creation), micro-deposits, SFTP uploading, and other features to be a complete system for ACH transfers.
- [Moov Wire](./wire/) (domestic Fedwire) implements an interface to write files for the Fedwire Funds Service, a real-time gross settlement funds transfer system operated by the United States Federal Reserve Banks. These compatible files include routing instructions that, once received and processed, will debit the funds from the sending bank's reserve account at their Federal Reserve bank and credit the receiving bank's account. Wire transfers sent via Fedwire are completed in the same day, while some are completed instantly.
- [Moov Image Cash Letter](./icl/) implements Image Cash Letter (ICL) files used for Check21 or Check truncation files for exchange and remote deposit in the U.S.; also known as X9 files, X9.37 files, X9.100-187

### Account Creation

Common functionality for creating funding accounts

- [Moov Customers](https://github.com/moov-io/customers) The Customers project focuses on solving authentic identification of humans who are legally able to hold and transfer currency within the US. Primarily this project solves Know Your Customer (KYC), Customer Identification Program (CIP), Office of Foreign Asset Control (OFAC) checks and verification workflows to comply with US federal law and ensure authentic transfers.
- [Moov Accounts](https://github.com/moov-io/accounts) is an RESTful API implementation of an accounting General Ledger used to track monetary transfers in digital systems.
- [Moov Watchman](./watchman/) is an HTTP API and Go library to download, parse and offer search functions over numerous trade sanction lists from the United States and European Union.
- [Moov FED](./fed/) implements utility services for searching the United States Federal Reserve System such as ABA routing numbers, Financial Institution name lookup and Fed Wire routing information.

## Design Goals

The core principles underlying Moov are performance, scalability, and ease-of-use. Based on these principles, Moov is designed around the following core features:

- Highly performant (fast)
- Few opinions, lightly held (interoperability)
- Extremely lightweight (small footprint)
- Support client languages (polyglot clients)
- micro building blocks (single responsibility principle)

## Getting Help

 channel | info
 ------- | -------
[moov-io slack](http://moov-io.slack.com/) | Join our slack channel to have an interactive discussion about the development of the project. [Request an invite to the slack channel](https://join.slack.com/t/moov-io/shared_invite/enQtNDE5NzIwNTYxODEwLTRkYTcyZDI5ZTlkZWRjMzlhMWVhMGZlOTZiOTk4MmM3MmRhZDY4OTJiMDVjOTE2MGEyNWYzYzY1MGMyMThiZjg)
 [Project Documentation](https://docs.moov.io/) | Our project documentation available online. (This site!)
 Google Group [moov-users](https://groups.google.com/forum/#!forum/moov-users)| The Moov users Google group is for contributors other people contributing to the Moov project. You can join them without a google account by sending an email to [moov-users+subscribe@googlegroups.com](mailto:moov-users+subscribe@googlegroups.com). After receiving the join-request message, you can simply reply to that to confirm the subscription.
Twitter [@moov_io](https://twitter.com/moov_io)	| You can follow Moov.IO's Twitter feed to get updates on our project(s). You can also tweet us questions or just share blogs or stories.
[GitHub Issue](https://github.com/moov-io) | If you are able to reproduce a problem please open a GitHub Issue under the specific project that caused the error.

## Contributing

Wow, we really appreciate that you even looked at this section! We are trying to make the worlds best atomic building blocks for financial services that accelerate innovation in banking and we need your help!

You only have a fresh set of eyes once! The easiest way to contribute is to give feedback on the documentation that you are reading right now. This can be as simple as sending a message to our Google Group with your feedback or updating the markdown in this documentation and issuing a pull request.

Stability is the hallmark of any good software. If you find an edge case that isn't handled please [open an GitHub issue](https://github.com/moov-io/ach/issues/new) with the example data so that we can make our software more robust for everyone. We also welcome pull requests if you want to get your hands dirty.
