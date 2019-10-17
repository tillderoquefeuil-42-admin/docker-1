#!/bin/sh
echo "docker build"
docker build -t ex01 .

echo "docker run"
docker run -d --name teamspeak --rm -p 9987:9987/udp -p 10011:10011 -p 30033:30033 ex01

echo "server is running"
echo "connect with local client to $(docker-machine ip Char)"
echo "to stop run \`docker stop teamspeak\`"