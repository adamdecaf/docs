VERSION=v$(shell date +"%Y.%m.%d").1

.PHONY: build
build:
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
