# Overview

<a class="github-button" href="https://github.com/moov-io/customers" data-size="large" data-show-count="true" aria-label="Star moov-io/customers on GitHub">moov-io/customers</a>
<a href="https://godoc.org/github.com/moov-io/customers"><img src="https://godoc.org/github.com/moov-io/customers?status.svg" /></a>
<a href="https://raw.githubusercontent.com/moov-io/customers/master/LICENSE"><img src="https://img.shields.io/badge/license-Apache2-blue.svg" /></a>

The Customers project focuses on solving authentic identification of humans who are legally able to hold and transfer currency within the US. Primarily this project solves [Know Your Customer](https://en.wikipedia.org/wiki/Know_your_customer) (KYC), [Customer Identification Program](https://en.wikipedia.org/wiki/Customer_Identification_Program) (CIP), [Office of Foreign Asset Control](https://www.treasury.gov/about/organizational-structure/offices/Pages/Office-of-Foreign-Assets-Control.aspx) (OFAC) checks and verification workflows to comply with US federal law and ensure authentic transfers. Also, Customers has an objective to be a service for detailed due diligence on individuals and companies for Financial Institutions and services in a modernized and extensible way.

## Running Moov Customers Server

- The quickest way to try Customers is with our <a href="#running-locally">Docker compose</a> setup.
- <a href="#binary-distribution">Binary Distributions</a> are released with every versioned release. Frequently added to the VM/AMI build script for the application needing Moov Customers.
- A <a href="#docker-container">Docker container</a> is built and added to Docker Hub with every versioned released.
- Our hosted [api.moov.io](https://api.moov.io) is updated with every versioned release. Our Kubernetes example is what Moov utilizes in our production environment.

### Running Locally

Customers has a [Docker Compose](https://docs.docker.com/compose/gettingstarted/) setup which you can run locally. This uses the latest releases of Customers and Watchman.

```
$ docker-compose up
Creating customers_watchman_1 ... done
Creating customers_customers_1 ... done
...
customers_1  | ts=2020-03-06T22:56:24.2184402Z caller=main.go:50 startup="Starting moov-io/customers server version v0.4.0-rc1"
customers_1  | ts=2020-03-06T22:56:24.393462Z caller=watchman.go:102 watchman="using http://watchman:8084 for Watchman address"
customers_1  | ts=2020-03-06T22:56:24.3951132Z caller=main.go:171 startup="binding to :8087 for HTTP server"
```

Once the systems start you can access Customers via `http://localhost:8087` and Watchman's [web interface or api](http://localhost:8084).

### Binary Distribution

Download the [latest Moov Customers server release](https://github.com/moov-io/customers/releases) for your operating system and run it from a terminal.

```sh
$ ./customers-darwin-amd64
ts=2020-02-25T19:30:58.193727Z caller=main.go:50 startup="Starting moov-io/customers server version v0.4.0-rc1"
ts=2020-02-25T19:30:58.193846Z caller=main.go:63 main="sqlite version 3.30.1"
ts=2020-02-25T19:30:58.193863Z caller=sqlite.go:93 main="sqlite version 3.30.1"
ts=2020-02-25T19:30:58.196666Z caller=main.go:207 main="WARNING!!!! USING INSECURE DEFAULT FILE STORAGE, set FILEBLOB_HMAC_SECRET for ANY production usage"
ts=2020-02-25T19:30:58.196709Z caller=main.go:90 admin="listening on [::]:9097"
ts=2020-02-25T19:30:58.196747Z caller=watchman.go:102 watchman="using http://localhost:8084 for Watchman address"
ts=2020-02-25T19:30:58.19709Z caller=main.go:171 startup="binding to :8087 for HTTP server"
```

### Docker Container

Moov Customers is dependent on Docker being properly installed and running on your machine. Ensure that Docker is running. If your Docker client has issues connecting to the service review the [Docker getting started guide](https://docs.docker.com/get-started/) if you have any issues.

Execute the Docker run command

```sh
$ docker run -p 8087:8087 -p 9097:9097 moov/customers:latest
ts=2020-02-25T19:30:58.193727Z caller=main.go:50 startup="Starting moov-io/customers server version v0.4.0-rc1"
...
```

### Kubernetes

Moov deploys Customers from [this manifest template](https://github.com/moov-io/infra/blob/master/lib/apps/16-customers.yml) on [Kubernetes](https://kubernetes.io/docs/tutorials/kubernetes-basics/) in the `apps` namespace. You could reach the Customers instance using `http://customers.apps.svc.cluster.local:8080` inside the cluster.

We also offer a [Helm Chart](https://github.com/moov-io/charts/tree/master/charts) for deployment.

## Configuration

View our [section on environmental variables](https://github.com/moov-io/customers#configuration) for options that Customers accepts.

For database storage we offer [SQLite](https://github.com/moov-io/customers#sqlite) (default) and [MySQL](https://github.com/moov-io/customers#mysql) with various configuration options.

[Document storage](https://github.com/moov-io/customers#document-storage) can be in in a [local filesystem](https://github.com/moov-io/customers#local-filesystem-storage),  [AWS S3](https://github.com/moov-io/customers#aws-s3-storage), or [Google Cloud Storage](https://github.com/moov-io/customers#google-cloud-storage).

### Customers Admin Port

The port `:9097` is bound by Customers for our admin service. This HTTP server has endpoints for Prometheus metrics (`GET /metrics`), readiness (`GET /ready`) and liveness checks (`GET /live`).

## API documentation

See our [API documentation](https://moov-io.github.io/customers/) for Moov Customers endpoints.

## Getting Help

 channel | info
 ------- | -------
 [Project Documentation](https://docs.moov.io/) | Our project documentation available online.
 Google Group [moov-users](https://groups.google.com/forum/#!forum/moov-users)| The Moov users Google group is for contributors other people contributing to the Moov project. You can join them without a google account by sending an email to [moov-users+subscribe@googlegroups.com](mailto:moov-users+subscribe@googlegroups.com). After receiving the join-request message, you can simply reply to that to confirm the subscription.
Twitter [@moov_io](https://twitter.com/moov_io)	| You can follow Moov.IO's Twitter feed to get updates on our project(s). You can also tweet us questions or just share blogs or stories.
[GitHub Issue](https://github.com/moov-io) | If you are able to reproduce a problem please open a GitHub Issue under the specific project that caused the error.
[moov-io slack](https://slack.moov.io/) | Join our slack channel (`#customers`) to have an interactive discussion about the development of the project.
