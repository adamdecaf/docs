Moov Paygate is a RESTful HTTP API enabling Automated Clearing House ([ACH](https://en.wikipedia.org/wiki/Automated_Clearing_House)) transactions and returns to be processed with an Originating Depository Financial Institution (ODFI) without a deep understanding of a full NACHA file specification. Hosted PayGate operates as a third-party ACH originator, which means we are able to transfer funds from any regulated financial institution in the United States via our financial institution.

[Hosted API documentation](https://api.moov.io/v1/)

## Usage

We are currently building out hosted services for PayGate. [Contact us](mailto:support@moov.io) for more details. You can also start by [running PayGate locally](https://github.com/moov-io/paygate) and convert to our commercial solutions later on.

### Configuration

PayGate is configured with our [production recommendations](https://github.com/moov-io/paygate/blob/master/docs/production.md#running-paygate-in-production). Refer to Moov's [Hosted Customers](https://docs.moov.io/customers/) page for more details on that service's configuration.

We use MySQL as the primary database for storage which is encrypted with industry-standard security.

### Monitoring

Moov uses [Prometheus](https://github.com/prometheus/prometheus) and [Alertmanager](https://github.com/prometheus/alertmanager) for automated verification of our running services. We have PagerDuty and Slack alerting configured for our teams and respond to issues promptly.

## Getting Help

 channel | info
 ------- | -------
 [Moov Support](mailto:support@moov.io) | Email support for Moov Hosted services
 [Project Documentation](https://docs.moov.io/paygate/) | Our project documentation available online.
 Twitter [@moov_io](https://twitter.com/moov_io) | You can follow Moov.IO's Twitter feed to get updates on our project(s). You can also tweet us questions or just share blogs or stories.
 [GitHub Issue](https://github.com/moov-io/paygate/issues) | If you are able to reproduce a problem please open a GitHub Issue under the specific project that caused the error.
 [moov-io slack](https://slack.moov.io/) | Join our slack channel (`#paygate`) to have an interactive discussion about the development of the project.
