## moov-io/docs

[![Build Status](https://travis-ci.com/moov-io/docs.svg?branch=master)](https://travis-ci.com/moov-io/docs)
[![Apache 2 licensed](https://img.shields.io/badge/license-Apache2-blue.svg)](https://raw.githubusercontent.com/moov-io/docs/master/LICENSE)

Documentation for the Moov project hosted at [docs.moov.io](https://docs.moov.io) on Github Pages.

## Getting Started / Install

1. Clone the repository somewhere (`git clone git@github.com:moov-io/docs.git`)
1. Edit, push up a new branch and create a Pull Request!

## Building locally

1. Install [MkDocs](https://www.mkdocs.org/) `pip install mkdocs`
1. Install [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) `pip install mkdocs-material`
1. Run the server `mkdocs serve`

## Deploy

1. `mkdocs build` will assemble HTML from the markdown files
1. `mkdocs gh-deploy` builds HTML and pushes to GitHub's `gh-pages` branch

### Docker Image

We host a [Docker image on Docker Hub](https://hub.docker.com/r/moov/docs/tags) for anyone to download. We host this image at [`docs.moov.io`](https://docs.moov.io).

## License

Apache License 2.0 See [LICENSE](LICENSE) for details.
