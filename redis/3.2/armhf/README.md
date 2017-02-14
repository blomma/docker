# Master
docker run -p 6379:6379 --name redis -v /data/redis-armhf:/data -d blomma/redis-armhf redis-server --appendonly yes
docker run -p 6379:6379 --name redis-slave -d blomma/redis-armhf redis-server --appendonly no --save "" --slaveof 192.168.1.5 6379
