.PHONY: clean

NAME = registry
IMAGE = blomma/registry-armhf
VERSION = 2.6.1

print-%  : ; @echo $* = $($*)

build:
	docker build --pull -t $(IMAGE):$(VERSION) .

run:
	docker run -d -p 5000:5000 --restart=always --name $(NAME) -v /data/registry:/var/lib/registry $(IMAGE):$(VERSION)

update: remove run

remove:
	docker stop $(NAME)
	docker rm $(NAME)
