HOST = quay.io
NAME = humu/pandas
VERSION = 0.0.2

build:
	docker build -t $(HOST)/$(NAME):$(VERSION) --rm .

test: build
	docker run --rm $(HOST)/$(NAME):$(VERSION) /bin/bash -c \
	  'apt-get update && apt-get -y install xvfb && pip install nose && xvfb-run nosetests pandas -e test_wdi_download'

tag:
	docker tag -f $(HOST)/$(NAME):$(VERSION) $(HOST)/$(NAME):latest

release: tag
	docker push $(HOST)/$(NAME)

.PHONY: build test tag release
