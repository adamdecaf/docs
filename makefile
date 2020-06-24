VERSION=v$(shell date -u +"%Y.%m.%d").1

.PHONY: generate
generate:
	wget -O ./docs/paygate/config.md http://raw.githubusercontent.com/moov-io/paygate/master/docs/config.md

.PHONY: build
build: generate
	docker build --pull -t moov/docs:$(VERSION) .
	docker tag moov/docs:$(VERSION) moov/docs:latest

.PHONY: run
run:
	mkdir -p ./nginx/cache/ ./nginx/run/
	docker run --read-only -p 8080:8080 -v $(shell pwd)/nginx/cache/:/var/cache/nginx -v $(shell pwd)/nginx/run/:/var/run moov/docs:$(VERSION)

.PHONY: release-push
release-push:
	docker push moov/docs:$(VERSION)
	docker push moov/docs:latest

.PHONY: tag
tag:
	git tag $(VERSION)
	git push origin $(VERSION)
