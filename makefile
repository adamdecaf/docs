VERSION=v$(shell date +"%Y.%m.%d").2

.PHONY: build
build:
	docker build --pull -t moov/docs:$(VERSION) .
	docker tag moov/docs:$(VERSION) moov/docs:latest

.PHONY: run
run:
	docker run -p 8080:8080 moov/docs:$(VERSION)

.PHONY: release-push
release-push:
	docker push moov/docs:$(VERSION)
	docker push moov/docs:latest

.PHONY: tag
tag:
	git tag $(VERSION)
	git push origin $(VERSION)
