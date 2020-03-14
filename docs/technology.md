Moov uses the latest production level technologies to write and manage software. We believe in supporting Open Source and using the best tool for the task.

## Go

Moov has previous experience with many programming languages and selected Go as our primary language for a few reasons.

- Large company and community support
    - Google has created this language and ran it in their production deployments for years
    - Thousands of companies have created and contributed to OSS software in Go
- High performance
    - Hundreds of projects have been written in Go and ran at huge scale (Prometheus, Kubernetes, etcd, etc...)
- Lots of resources for beginners
    - Go's syntax is easy to learn and there are numerous free tutorials for developers

## Databases

Services we write use databases for persistent storage. By default we use SQLite as it's quick to start and requires no setup. Local development and testing can use these on all major platforms.

### SQLite

[SQLite is an incredible](https://sqlite.org/features.html) database used across industries and we've chosen it as the default because it works great for our data storage needs. It also works well for single-node deployments where we aren't trying to run distributed applications. There is a [distributed version of sqlite](https://github.com/rqlite/rqlite) we want to test and deploy.

### MySQL

[MySQL](https://dev.mysql.com/doc/refman/8.0/en/tutorial.html) is a high quality database which has replication, backups, durable storage and many more features.

## Encryption

We leverage encryption to protect Personally Identifiable Information (PII) data in our databases. This is not only required by various regulations but also a standard practice to protect our customers data against hackers. Our services use the popular [GoCloud.Dev](https://gocloud.dev/howto/secrets/) library to abstract over local NaCL secrets and various cloud providers (Google KMS, Amazon KMC, etc).
