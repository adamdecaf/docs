VERSION=v0.0.0

.PHONY: build

build:
	docker build -t moov/docs:$(VERSION) .
	docker tag moov/docs:$(VERSION) moov/docs:latest
