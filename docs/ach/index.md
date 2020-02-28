# Overview
<!-- Place this tag where you want the button to render. -->
<a class="github-button" href="https://github.com/moov-io/ach" data-size="large" data-show-count="true" aria-label="Star moov-io/ach on GitHub">moov-io/ach</a>
<a href="https://godoc.org/github.com/moov-io/ach"><img src="https://godoc.org/github.com/moov-io/ach?status.svg" /></a>
<a href="https://raw.githubusercontent.com/moov-io/ach/master/LICENSE"><img src="https://img.shields.io/badge/license-Apache2-blue.svg" /></a>

Moov ACH implements a low level Automated Clearing House (ACH) interface for parsing, creating, validating, and merging ACH files. Moov ACH exposes an HTTP API for REST based interaction. Any language which can use HTTP and JSON can leverage the ACH Server. The API's endpoints expose both text and JSON to easily ingest or export either format.

## Running Moov ACH Server

Moov ACH can be deployed in multiple scenarios.

- <a href="#binary-distribution">Binary Distributions</a> are released with every versioned release. Frequently added to the VM/AMI build script for the application needing Moov ACH.
- A <a href="#docker-container">Docker container</a> is built and added to Docker Hub with every versioned released.
- Our hosted [api.moov.io](https://api.moov.io) is updated with every versioned release. Our Kubernetes example is what Moov utilizes in our production environment.

### Binary Distribution

Download the [latest Moov ACH server release](https://github.com/moov-io/ach/releases) for your operating system and run it from a terminal.

```sh
$ cd ~/Downloads/
$ ./ach-darwin-amd64
ts=2019-06-20T23:23:44.870717Z caller=main.go:75 startup="Starting ach server version v1.0.2"
ts=2019-06-20T23:23:44.871623Z caller=main.go:135 transport=HTTP addr=:8080
ts=2019-06-20T23:23:44.871692Z caller=main.go:125 admin="listening on :9090"
```

Next [Connect to Moov ACH](#connecting-to-moov-ach)

### Docker Container

Moov ACH is dependent on Docker being properly installed and running on your machine. Ensure that Docker is running. If your Docker client has issues connecting to the service review the [Docker getting started guide](https://docs.docker.com/get-started/) if you have any issues.

```sh
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
$
```

Execute the Docker run command

```sh
$ docker run -p 8080:8080 -p 9090:9090 moov/ach:latest
ts=2019-06-21T17:03:23.782592Z caller=main.go:69 startup="Starting ach server version v1.0.2"
ts=2019-06-21T17:03:23.78314Z caller=main.go:129 transport=HTTP addr=:8080
ts=2019-06-21T17:03:23.783252Z caller=main.go:119 admin="listening on :9090"
```

Next [Connect to Moov ACH](#connecting-to-moov-ach)

### Kubernetes

The following snippet runs the ACH Server on [Kubernetes](https://kubernetes.io/docs/tutorials/kubernetes-basics/) in the `apps` namespace. You could reach the ach instance at the following URL from inside the cluster.

```
# Needs to be ran from inside the cluster
$ curl http://ach.apps.svc.cluster.local:8080/ping
PONG

$ curl http://localhost:8080/files
{"files":[],"error":null}
```

Kubernetes manifest - save in a file (`ach.yaml`) and apply with `kubectl apply -f ach.yaml`.

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: apps
---
apiVersion: v1
kind: Service
metadata:
  name: ach
  namespace: apps
spec:
  type: ClusterIP
  selector:
    app: ach
  ports:
    - name: http
      protocol: TCP
      port: 8080
      targetPort: 8080
    - name: metrics
      protocol: TCP
      port: 9090
      targetPort: 9090
---
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: ach
  namespace: apps
  labels:
    app: ach
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ach
  template:
    metadata:
      labels:
        app: ach
    spec:
      containers:
      - image: moov/ach:v1.0.0
        imagePullPolicy: Always
        name: ach
        args:
          - -http.addr=:8080
          - -admin.addr=:9090
        env:
          - name: ACH_FILE_TTL
            value: 30m # 30 minutes
        ports:
          - containerPort: 8080
            name: http
            protocol: TCP
          - containerPort: 9090
            name: metrics
            protocol: TCP
        resources:
          limits:
            cpu: 0.1
            memory: 50Mi
          requests:
            cpu: 25m
            memory: 10Mi
        readinessProbe:
          httpGet:
            path: /ping
            port: 8080
          initialDelaySeconds: 5
          periodSeconds: 10
        livenessProbe:
          httpGet:
            path: /ping
            port: 8080
          initialDelaySeconds: 5
          periodSeconds: 10
      restartPolicy: Always
```
Next [Connect to Moov ACH](#connecting-to-moov-ach)

## Connecting to Moov ACH

The Moov ACH service will be running on port `8080` (with an admin port on `9090`).

Confirm that the service is running by issuing the following command or simply visiting the url in your browser [localhost:8080/ping](http://localhost:8080/ping)

```bash
$ curl http://localhost:8080/ping
PONG

$ curl http://localhost:8080/files
{"files":[],"error":null}
```

You can also send [an example PPD ACH file we have](https://github.com/moov-io/ach/blob/master/test/testdata/ppd-valid.json) to any ACH service or read through HTTP examples in [Ruby](https://github.com/moov-io/ruby-ach-demo) and [Go](https://github.com/moov-io/ach/blob/master/examples/http/main.go).

### API documentation

See our [API documentation](https://api.moov.io/apps/ach/) for Moov ACH endpoints.

### ACH Admin Port

The port `9090` is bound by ACH for our admin service. This HTTP server has endpoints for Prometheus metrics (`GET /metrics`), readiness (`GET /ready`) and liveness checks (`GET /live`).
