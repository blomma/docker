.PHONY: clean

NAME = redis
IMAGE = venkman:5000/redis-armhf
VERSION = 3.2.8

print-%  : ; @echo $* = $($*)

build:
	docker build --pull -t $(IMAGE):$(VERSION) .

run:
	docker run -p 6379:6379 --restart always --name $(NAME) -v /data/redis-armhf:/data -d $(IMAGE):$(VERSION) redis-server --appendonly yes

update: remove run

remove:
	docker stop $(NAME)
	docker rm $(NAME)
