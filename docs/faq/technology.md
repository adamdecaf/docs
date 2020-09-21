Moov uses the latest production level technologies to write and manage software. We believe in supporting open source and using the best tool for the task.

## Operating System

Moov offers two formats for running services in production: Docker images or compiled binaries for Linux, macOS, and Windows. The supported versions of each OS are what is supported by Docker or Go and Moov makes no attempts to support older operating systems.

## Go

Moov's team has previous experience with many programming languages and selected Go as our primary language for a few reasons.

- Large company and community support
    - Google has created this language and ran it in their production deployments for years
    - Thousands of companies have created and contributed to OSS software in Go
- High performance
    - Hundreds of projects have been written in Go and ran at huge scale (Prometheus, Kubernetes, etcd, etc...)
- Lots of resources for beginners
    - Go's syntax is easy to learn and there are numerous free tutorials for developers

## Database

Moov's hosted services use MySQL as their primary database. This is a high-grade production system which supports replication, secure backups, high-availability, and fast queries.

### Secure Backups

Backup and restore of database contents is a critical component of production deployments. This is how business operations continue after major system failure. Moov encrypts database backups and tests their automated restore.

## Encryption

Moov leverages encryption to protect Personally Identifiable Information (PII) data in our databases. This is not only required by various regulations but also a standard practice to protect our customers' data against hackers. Our services use the popular [GoCloud.Dev](https://gocloud.dev/howto/secrets/) library to abstract over local NaCL secrets and various cloud providers (Google KMS, Amazon KMC, etc).
