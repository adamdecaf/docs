[Moov's PayGate project](https://github.com/moov-io/paygate) provides an HTTP REST endpoint for submitting and receiving ACH payments and builds upon a suite of services offered by Moov, including [ACH](https://github.com/moov-io/ach), [Customers](https://github.com/moov-io/customers), [FED](https://github.com/moov-io/fed), and [Watchman](https://github.com/moov-io/watchman). We provide several examples of setting up a complete installation using [Docker Compose](https://docs.docker.com/compose/), Kubernetes, or directly using the provided binaries.

**Note**: This documentation is for the v0.8.x series of PayGate.

## Running PayGate

### Docker Compose (Quickest)

PayGate can be quickly ran using the provided [Docker Compose file](https://github.com/moov-io/paygate/blob/master/docker-compose.yml). Ensur you have [installed Docker Compose](https://docs.docker.com/compose/install/) for your platform

Clone the repository and run `docker-compose up` within it.

```
$ git clone https://github.com/moov-io/paygate.git
$ cd paygate
$ docker-compose up -d
```

That's it! The Docker files will be downloaded and ran on your machine. PayGate endpoints will be accessible at `http://localhost:8082` and `http://localhost:9092`. You can verify paygate is running with `curl http://localhost:8082/ping` and monitor the health with `curl http://localhost:9092/live`.

### From Source

PayGate can run directly from source using Go, but the required services need to be running as well in order for API calls to complete successfully. The default port `8082` is used unless a CLI flag (e.g. `-http.addr=<port>`) or environment variable override from [our configuration documentation](https://github.com/moov-io/paygate#configuration) is set when running PayGate.

```
# With Golang and git installed:
$ git clone https://github.com/moov-io/paygate.git
$ cd paygate
$ go run .
```

### Kubernetes

Moov uses [Kubernetes](https://kubernetes.io/) for clustering our production services and we have [Helm charts for each application](https://github.com/moov-io/charts) in beta currently. Inside the [moov-io/infra repository we have Kubernetes manifests](https://github.com/moov-io/infra/tree/master/lib/apps) or a [Terraform module](https://github.com/moov-io/infra/tree/master/modules/paygate) which you can reference.

## Make a Transfer

After confirming that the services are running correctly, there are several things needed before ACH transactions can be created/processed using PayGate.  Listed below are the steps necessary:

1. TODO(adam)

## API documentation

See our [API documentation](https://moov-io.github.io/paygate/) for Moov PayGate endpoints or the [admin endpoint documentation](./admin/).

## Configuration

PayGate accepts a `-config <path>` command-line argument to read a YAML file. Please [refer to our documentation on this file](./config/).

## Vocab

Refer to our [vocab and models page](vocab.md) for detailed definitions of PayGate terms.

## Getting Help

 channel | info
 ------- | -------
 [Project Documentation](https://docs.moov.io/) | Our project documentation available online.
 Google Group [moov-users](https://groups.google.com/forum/#!forum/moov-users)| The Moov users Google group is for contributors other people contributing to the Moov project. You can join them without a google account by sending an email to [moov-users+subscribe@googlegroups.com](mailto:moov-users+subscribe@googlegroups.com). After receiving the join-request message, you can simply reply to that to confirm the subscription.
Twitter [@moov_io](https://twitter.com/moov_io)	| You can follow Moov.IO's Twitter feed to get updates on our project(s). You can also tweet us questions or just share blogs or stories.
[GitHub Issue](https://github.com/moov-io) | If you are able to reproduce a problem please open a GitHub Issue under the specific project that caused the error.
[moov-io slack](https://slack.moov.io/) | Join our slack channel (`#paygate`) to have an interactive discussion about the development of the project.
