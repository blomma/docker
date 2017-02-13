# Master
docker run -p 6379:6379 --name redis -v /data/redis-armhf:/data -d blomma/redis-armhf:latest redis-server --appendonly yes
docker run -p 6379:6379 --name redis -d blomma/redis-armhf:latest redis-server --appendonly no --save "" --slaveof 192.168.1.5 6379
