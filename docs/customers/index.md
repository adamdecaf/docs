Moov Customers project focuses on solving authentic identification of humans who are legally able to hold and transfer currency within the US. Primarily this project solves [Know Your Customer](https://en.wikipedia.org/wiki/Know_your_customer) (KYC), [Customer Identification Program](https://en.wikipedia.org/wiki/Customer_Identification_Program) (CIP), [Office of Foreign Asset Control](https://www.treasury.gov/about/organizational-structure/offices/Pages/Office-of-Foreign-Assets-Control.aspx) (OFAC) checks and verification workflows to comply with US federal law and ensure authentic transfers. Also, Customers has an objective to be a service for detailed due diligence on individuals and companies for Financial Institutions and services in a modernized and extensible way.

[Hosted API documentation](https://api.moov.io/v1/)

## Usage

We are currently building out hosted services for Customers. [Contact us](mailto:support@moov.io) for more details. You can also start by [running Customers locally](https://github.com/moov-io/customers) and convert to our commercial solutions later on.

### Configuration

Moov uses the official [OFAC Sanctions Search](https://sanctionssearch.ofac.treas.gov/) data files from the US Government. These files are automatically updated daily.

For the hosted [Moov Fed](https://github.com/moov-io/fed) service uses data files from our financial institution.

We use MySQL as the primary database for storage which is encrypted with industry-standard security.

### Monitoring

Moov uses [Prometheus](https://github.com/prometheus/prometheus) and [Alertmanager](https://github.com/prometheus/alertmanager) for automated verification of our running services. We have PagerDuty and Slack alerting configured for our teams and respond to issues promptly.

## Getting Help

 channel | info
 ------- | -------
 [Moov Support](mailto:support@moov.io) | Email support for Moov Hosted services
 [Project Documentation](https://docs.moov.io/customers/) | Our project documentation available online.
 Twitter [@moov_io](https://twitter.com/moov_io) | You can follow Moov.IO's Twitter feed to get updates on our project(s). You can also tweet us questions or just share blogs or stories.
 [GitHub Issue](https://github.com/moov-io/customers/issues) | If you are able to reproduce a problem please open a GitHub Issue under the specific project that caused the error.
 [moov-io slack](https://slack.moov.io/) | Join our slack channel (`#customers`) to have an interactive discussion about the development of the project.
