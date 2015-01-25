NAME = humu/pandas
VERSION = 0.0.0

build:
	docker build -t $(NAME):$(VERSION) --rm .

test:
	docker run --rm $(NAME):$(VERSION) /bin/bash -c \
	  'pip install nose && nosetests pandas -e test_wdi_download'

tag_latest:
	docker tag -f $(NAME):$(VERSION) $(NAME):latest

release: test tag_latest
	@if ! docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please 	'make build'"; false; fi
	docker push $(NAME)
	git tag rel-$(VERSION) && git push origin rel-$(VERSION)"

.PHONY: build test tag_latest release
