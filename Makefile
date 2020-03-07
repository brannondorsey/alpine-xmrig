.PHONY: build push check-env

default: build push

build: check-env
	docker build -t brannondorsey/alpine-xmrig --build-arg XMRIG_VERSION=$(XMRIG_VERSION) .
	docker tag brannondorsey/alpine-xmrig brannondorsey/alpine-xmrig:$(XMRIG_VERSION)

push: check-env
	docker push brannondorsey/alpine-xmrig
	docker push brannondorsey/alpine-xmrig:$(XMRIG_VERSION)

check-env:
ifndef XMRIG_VERSION
	$(error The XMRIG_VERSION environment variable must be defined)
endif
