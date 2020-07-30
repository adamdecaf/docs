## moov-io/docs

[![Build Status](https://travis-ci.com/moov-io/docs.svg?branch=master)](https://travis-ci.com/moov-io/docs)
[![Apache 2 licensed](https://img.shields.io/badge/license-Apache2-blue.svg)](https://raw.githubusercontent.com/moov-io/docs/master/LICENSE)

Documentation for the Moov project hosted at [docs.moov.io](https://docs.moov.io) on Github Pages.

## Getting Started / Install

1. Clone the repository somewhere (`git clone git@github.com:moov-io/docs.git`)
1. Edit, push up a new branch and create a Pull Request!

## Building locally

1. Install [MkDocs](https://www.mkdocs.org/): `pip install mkdocs`
1. Install the [Material theme for MkDocs](https://squidfunk.github.io/mkdocs-material/): `pip install mkdocs-material`
1. Run the server `mkdocs serve`

## Deploy

1. Build the Docker image: `make build`
1. Verify the image runs as expected: `make run`
1. Push a new tag: `make tag`

### Docker Image

We host a [Docker image on Docker Hub](https://hub.docker.com/r/moov/docs/tags) for anyone to download. We host this image at [`docs.moov.io`](https://docs.moov.io).

## Getting Help

 channel | info
 ------- | -------
[Project Documentation](https://docs.moov.io/) | Our project documentation available online.
Google Group [moov-users](https://groups.google.com/forum/#!forum/moov-users)| The Moov users Google group is for contributors other people contributing to the Moov project. You can join them without a google account by sending an email to [moov-users+subscribe@googlegroups.com](mailto:moov-users+subscribe@googlegroups.com). After receiving the join-request message, you can simply reply to that to confirm the subscription.
Twitter [@moov_io](https://twitter.com/moov_io)	| You can follow Moov.IO's Twitter feed to get updates on our project(s). You can also tweet us questions or just share blogs or stories.
[GitHub Issue](https://github.com/moov-io) | If you are able to reproduce a problem please open a GitHub Issue under the specific project that caused the error.
[moov-io slack](https://slack.moov.io/) | Join our slack channel to have an interactive discussion about the development of the project.

## License

Apache License 2.0 See [LICENSE](LICENSE) for details.
