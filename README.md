# docker-1
The aim of the Docker-1 project is to make you handle docker and docker-machine, the bases to understand the idea of containerization of services. You can see this project as an initiation.


## variables
name | value
------------
CONTAINER_NAME | friendlyhello
OUTSIDE_PORT | 4000
INSIDE_PORT | 80

## basic commands
```diff
# Create image using this directory's Dockerfile
docker build -t <CONTAINER_NAME> .

# Run "<CONTAINER_NAME>" mapping port <OUTSIDE_PORT> to <INSIDE_PORT>
docker run -p <OUTSIDE_PORT>:<INSIDE_PORT> <CONTAINER_NAME>

# Same thing, but in detached mode
docker run -d -p <OUTSIDE_PORT>:<INSIDE_PORT> <CONTAINER_NAME>

# List all running containers
docker container ls

# List all containers, even those not running
docker container ls -a

#list images
docker image ls

# Gracefully stop the specified container
docker container stop <container_id>

# Force shutdown of the specified container
docker container kill <container_id>

# Remove specified container from this machine
docker container rm <container_id>

# Remove all containers
docker container rm $(docker container ls -a -q)

# List all images on this machine
docker image ls -a

# Remove specified image from this machine
docker image rm <image id>

# Remove all images from this machine
docker image rm $(docker image ls -a -q)

# Log in this CLI session using your Docker credentials
docker login

# Tag <image> for upload to registry
docker tag <image> username/repository:tag

# Upload tagged image to registry
docker push username/repository:tag

# Run image from a registry
docker run username/repository:tag
```

## initialize simple container (nodejs)

```diff
$ cd ~/simple-container
$ cat Dockerfile
> FROM node:10
> 
> WORKDIR /app
> 
> COPY . /app
> 
> RUN npm install
> 
> EXPOSE 8080
> 
> CMD [ "node", "server.js" ]

$ cat .dockerignore
> node_modules
> npm-debug.log

$ cat package.json
> {
>   "name": "docker_web_app",
>   "version": "1.0.0",
>   "description": "Node.js on Docker",
>   "author": "First Last <first.last@example.com>",
>   "main": "server.js",
>   "scripts": {
>     "start": "node server.js"
>   },
>   "dependencies": {
>     "express": "^4.16.1"
>   }
> }

$ cat server.js
> 'use strict';
> 
> const express = require('express');
> 
> // Constants
> const PORT = 8080;
> const HOST = '0.0.0.0';
> 
> // App
> const app = express();
> app.get('/', (req, res) => {
>   res.send('Hello world\n');
> });
> 
> app.listen(PORT, HOST);
> console.log(`Running on http://${HOST}:${PORT}`);

# build
$ sudo docker build -t node-docker .

# run and check on http://localhost:4444
$ sudo docker run -d -p 4444:8080 node-docker

# commit image
$ sudo docker tag node-docker tillderoquefeuil/node-docker:v0.0.1

# push image
$ sudo docker push tillderoquefeuil/node-docker:v0.0.1
```
