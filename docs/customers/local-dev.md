### Running from source

Customers can run directly from source using Go, but requires [Moov Watchman](https://github.com/moov-io/watchman) to be running as well. The default ports: `8087` and `9097` are used. Environment variables setup beforehand as [outlined here](https://github.com/moov-io/customers#configuration).

```
# With Golang and git installed:
$ git clone https://github.com/moov-io/customers.git
$ cd customers
$ go run .
ts=2020-02-25T19:30:58.193727Z caller=main.go:50 startup="Starting moov-io/customers server version v0.4.0-rc1"
...
```
