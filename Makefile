NAME = humu/pandas
VERSION = 0.0.1

build:
	docker build -t $(NAME):$(VERSION) --rm .

test: build
	docker run --rm $(NAME):$(VERSION) /bin/bash -c \
	  'apt-get update && apt-get -y install xvfb && pip install nose && xvfb-run nosetests pandas -e test_wdi_download'

tag_latest:
	docker tag -f $(NAME):$(VERSION) $(NAME):latest

release: tag_latest
	git tag rel-$(VERSION) && git push origin rel-$(VERSION)

.PHONY: build test tag_latest release
