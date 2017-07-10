.PHONY: clean

NAME = redis
NAME_SLAVE = redis-slave
IMAGE = venkman.local:5000/redis-armhf
VERSION = 3.2.9

print-%  : ; @echo $* = $($*)

build:
	docker build --pull -t $(IMAGE):$(VERSION) .
	docker push $(IMAGE):$(VERSION)

pull:
	docker pull $(IMAGE):$(VERSION)

run:
	docker run -p 6379:6379 --restart always --name $(NAME) -v /data/redis-armhf:/data -d $(IMAGE):$(VERSION) redis-server --appendonly yes

update: pull remove run

remove:
	docker stop $(NAME)
	docker rm $(NAME)

run-slave:
	docker run -p 6379:6379 --restart always --name $(NAME_SLAVE) -d $(IMAGE):$(VERSION) redis-server --appendonly no --save "" --slaveof 192.168.1.5 6379

update-slave: pull remove-slave run-slave

remove-slave:
	docker stop $(NAME_SLAVE)
	docker rm $(NAME_SLAVE)

