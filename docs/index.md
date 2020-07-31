# Welcome

**Welcome to the Moov developer site!** Moov's mission is to give developers an easy way to create and integrate bank processing into their own software products. Here you will find documentation to help you start building with Moov as quickly as possible. If you get stuck along the way, we are always here to help!

## Moov Projects

Moov projects are focused on solving a single responsibility capability in financial services. We offer RESTFul API's on [api.moov.io](https://api.moov.io) in a hosted service that developers can leverage for making payments.

### Payments

- [Moov PayGate](./paygate/) provides a complete implementation of ACH origination (file creation), micro-deposits, SFTP uploading, and other features to be a complete system for ACH transfers.

#### Supporting Services

- [Moov ACH](https://github.com/moov-io/ach) (including Same Day ACH) implements a NACHA compliant RESTFul API for file creation, parsing, and validation. Supports generating and parsing all Standard Entry Class (SEC) codes. ACH is the primary method of electronic money movement throughout the United States.
- [Moov Customers](./customers/) The Customers project focuses on solving authentic identification of humans who are legally able to hold and transfer currency within the US. Primarily this project solves Know Your Customer (KYC), Customer Identification Program (CIP), Office of Foreign Asset Control (OFAC) checks and verification workflows to comply with US federal law and ensure authentic transfers.
- [Moov Watchman](https://github.com/moov-io/watchman) is an HTTP API and Go library to download, parse and offer search functions over numerous trade sanction lists from the United States and European Union.
- [Moov FED](https://github.com/moov-io/fed) implements utility services for searching the United States Federal Reserve System such as ABA routing numbers, Financial Institution name lookup and Fed Wire routing information.

### Future Payment Methods

- [Moov Image Cash Letter](https://github.com/moov-io/imagecashletter) implements Image Cash Letter (ICL) files used for Check21 or Check truncation files for exchange and remote deposit in the U.S.; also known as X9 files, X9.37 files, X9.100-187
- [Moov Wire](https://github.com/moov-io/wire) (domestic Fedwire) implements an interface to write files for the Fedwire Funds Service, a real-time gross settlement funds transfer system operated by the United States Federal Reserve Banks. These compatible files include routing instructions that, once received and processed, will debit the funds from the sending bank's reserve account at their Federal Reserve bank and credit the receiving bank's account. Wire transfers sent via Fedwire are completed in the same day, while some are completed instantly.

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
[moov-io slack](https://slack.moov.io/) | Join our slack channel to have an interactive discussion about the development of the project.
[Project Documentation](https://docs.moov.io/) | Our project documentation available online. (This site!)
Twitter [@moov_io](https://twitter.com/moov_io)	| You can follow Moov.IO's Twitter feed to get updates on our project(s). You can also tweet us questions or just share blogs or stories.
[GitHub Issue](https://github.com/moov-io) | If you are able to reproduce a problem please open a GitHub Issue under the specific project that caused the error.

## Contributing

Wow, we really appreciate that you even looked at this section! We are creating open source services that accelerate innovation in banking and we need your help!

You only have a fresh set of eyes once! The easiest way to contribute is to give feedback on the documentation that you are reading right now. This can be as simple as dropping a note in the [moov-io slack channel](https://slack.moov.io/) with your feedback or updating the markdown in this documentation and issuing a pull request.

Stability is the hallmark of any good software. If you find an edge case that isn't handled please [open an GitHub issue](https://github.com/moov-io) on the project's repository with the example data so that we can make our software more robust for everyone. We also welcome pull requests if you want to get your hands dirty.
