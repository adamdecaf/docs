# Getting Started

## What is WIRE

[Moov Wire](https://github.com/moov-io/fed) implements an HTTP interface to read and write FEDWire Messages

FEDWire (formerly known as the Federal Reserve Wire Network) is a real-time gross settlement funds transfer system operated by the United States Federal Reserve Banks that allows financial institutions to electronically transfer funds between its more than 9,289 participants (as of March 19, 2009).[1] Transfers can only be initiated by the sending bank once they receive the proper wiring instructions from the receiving bank. These instructions include: the receiving bank's routing number, account number, name and dollar amount being transferred. This information is submitted to the Federal Reserve via the Fedwire system. Once the instructions are received and processed, the Fed will debit the funds from the sending bank's reserve account and credit the receiving bank's account. Wire transfers sent via Fedwire are completed in the same day, while some are completed instantly.
[source: FedWire](https://en.wikipedia.org/wiki/Fedwire)

## How does FEDWire work?

[source: FEDWire: How it Works](https://www.americanexpress.com/us/foreign-exchange/articles/fedwire-transfers/)

## Running Moov WIRE Server

Moov WIRE can be deployed in multiple scenarios.

- Binary Distributions are released with every versioned release. Frequently added to the VM/AMI build script for the application needing Moov WIRE.
- Our hosted [api.moov.io](https://api.moov.io) is updated with every versioned release. Our Kubernetes example is what Moov utilizes in our production environment. 
- A Docker container is built and added to Docker Hub with every versioned released.

### Binary Distribution

Download the [latest Moov WIRE server release](https://github.com/moov-io/wire/releases) for your operating system and run it from a terminal.

```sh
host:~ $ cd ~/Downloads/
host:Downloads $ ./fed-darwin-amd64 
ts=2019-06-20T23:23:44.870717Z caller=main.go:75 startup="Starting wire server version v0.2.0"
ts=2019-06-20T23:23:44.871623Z caller=main.go:135 transport=HTTP addr=:8088
ts=2019-06-20T23:23:44.871692Z caller=main.go:125 admin="listening on :9098"
```

Next [Connect to Moov WIRE](#connecting-to-moov-wire)

### Docker Container

Moov WIRE is dependent on Docker being properly installed and running on your machine. Ensure that Docker is running. If your Docker client has issues connecting to the service review the [Docker getting started guide](https://docs.docker.com/get-started/) if you have any issues.

```sh
host:~ $ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
host:~ $ 
```

Execute the Docker run command

```sh
host:~ $ docker run moov/wire:latest
ts=2019-06-21T17:03:23.782592Z caller=main.go:69 startup="Starting wire server version v0.2.0"
ts=2019-06-21T17:03:23.78314Z caller=main.go:129 transport=HTTP addr=:8088
ts=2019-06-21T17:03:23.783252Z caller=main.go:119 admin="listening on :9098"
```

!!! warning "OSX Users"
    You will need to use [port forwarding](https://docs.docker.com/docker-for-mac/networking/#known-limitations-use-cases-and-workarounds):
    `$ docker run -p 8080:8080 -p 9090:9090 moov/wire:latest`)

Next [Connect to Moov WIRE](#connecting-to-moov-wire)

### Kubernetes

The following snippet runs the WIRE Server on [Kubernetes](https://kubernetes.io/docs/tutorials/kubernetes-basics/) in the `apps` namespace. You could reach the fed instance at the following URL from inside the cluster.

```
# Needs to be ran from inside the cluster
$ curl http://wire.apps.svc.cluster.local:8088/ping
PONG
```

Kubernetes manifest - save in a file (`fed.yaml`) and apply with `kubectl apply -f fed.yaml`.

## Connecting to Moov FED
The Moov FED service will be running on port 8086 (with an admin port on 9096).

Confirm that the service is running by issuing the following command or simply visiting the url in your browser localhost:8086/ping

```sh
$ curl http://localhost:8088/ping 
```

```
PONG
```

```
$ curl localhost:8088/files
  {"files":[],"error":null}
```

```json
{"files":[],"error":null}
```

