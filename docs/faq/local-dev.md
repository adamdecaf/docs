Below is a series of questions and answers around local development setups when running and working on Moov services.

## Operating System

Moov officially supports Linux, macOS, and Windows with our services. Our team typically develops the services on macOS and runs tests on all platforms. The supported versions of each OS are what is supported by Docker or Go and Moov makes no attempts to support older operating systems.

## Database

The default database in local development is [SQLite](https://sqlite.org/about.html) as it's easy to spin up and supports standard SQL syntax used by other databases we support.
