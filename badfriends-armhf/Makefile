.PHONY: clean

NAME = badfriends
IMAGE = venkman:5000/badfriends-armhf
VERSION := $(shell ./badrobot --versionOnly)

print-%  : ; @echo $* = $($*)

build:
	docker build --pull -t $(IMAGE):$(VERSION) .
	docker push $(IMAGE):$(VERSION)

create:
	docker service create --name $(NAME) -p 8000:8000 --mode global --constraint "node.role != manager"  $(IMAGE):$(VERSION)

update:
	docker service update --image $(IMAGE):$(VERSION) $(NAME)
