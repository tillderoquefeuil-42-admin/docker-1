#!/bin/sh
echo "Starting build..."
docker build -t ex01 .

echo "Build finished. Running..."
docker run -d --name teamspeak --rm -p 9987:9987/udp -p 10011:10011 -p 30033:30033 ex01

echo "Server is running. Connect with local client to $(docker-machine ip Char)."
echo "When finished, run \`docker stop teamspeak\`"