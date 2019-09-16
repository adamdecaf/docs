VERSION=v$(shell date +"%Y.%m.%d").1

.PHONY: build

build:
	docker build -t moov/docs:$(VERSION) .
	docker tag moov/docs:$(VERSION) moov/docs:latest

.PHONY: release-push
release-push:
	docker push moov/docs:$(VERSION)
	docker push moov/docs:latest
