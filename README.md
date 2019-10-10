# docker-1
The aim of the Docker-1 project is to make you handle docker and docker-machine, the bases to understand the idea of containerization of services. You can see this project as an initiation.


## basic commands
```diff

# Log in this CLI session using your Docker credentials
docker login -u <username>
```

```diff
##### Dockerfile, image & container #####

# Create image using this directory's Dockerfile
docker build -t <container_name> .

# Run "<container_name>" mapping port <outside_port> to <inside_port>
docker run -p <outside_port>:<inside_port> <container_name>

# Same thing, but in detached mode
docker run -d -p <outside_port>:<inside_port> <container_name>

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

# Tag <image> for upload to registry
docker tag <image> username/repository:tag

# Upload tagged image to registry
docker push username/repository:tag

# Run image from a registry
docker run username/repository:tag
```

```diff
##### docker-compose.yml, stack & service #####

# List stacks or apps
docker stack ls

# Run the specified Compose file
docker stack deploy -c <composefile> <appname>

# List running services associated with an app
docker service ls

# List tasks associated with an app
docker service ps <service>

# Inspect task or container
docker inspect <task or container>

# List container IDs
docker container ls -q

# Tear down an application
docker stack rm <appname>

# Take down a single node swarm from the manager
docker swarm leave --force
```

```diff
##### Swarms & docker-machine #####

# Create a VM
docker-machine create --driver virtualbox <vm1name>

# View basic information about your node
docker-machine env <vm1name>

# List the nodes in your swarm
docker-machine ssh <vm1name> "docker node ls"

# Inspect a node
docker-machine ssh <vm1name> "docker node inspect <node ID>"

# INIT
docker swarm init --advertise-addr <vm1name ip>

# View join token
docker-machine ssh <vm1name> "docker swarm join-token -q worker"

# Open an SSH session with the VM; type "exit" to end
docker-machine ssh <vm1name>

# View nodes in swarm (while logged on to manager)
docker node ls

# Make the worker leave the swarm
docker-machine ssh <vm2name> "docker swarm leave"

# Make master leave, kill swarm
docker-machine ssh <vm1name> "docker swarm leave -f"

# list VMs, asterisk shows which VM this shell is talking to
docker-machine ls

# Start a VM that is currently not running
docker-machine start <vm1name>

# show environment variables and command for <vm1name>
docker-machine env <vm1name>

# Mac command to connect shell to <vm1name>
eval $(docker-machine env <vm1name>)

# Deploy an app; command shell must be set to talk to manager (<vm1name>), uses local Compose file
docker stack deploy -c <file> <app>

# Copy file to node's home dir (only required if you use ssh to connect to manager and deploy the app)
docker-machine scp docker-compose.yml <vm1name>:~

# Deploy an app using ssh (you must have first copied the Compose file to <vm1name>)
docker-machine ssh <vm1name> "docker stack deploy -c <file> <app>"

# Disconnect shell from VMs, use native docker
eval $(docker-machine env -u)

# Stop all running VMs
docker-machine stop $(docker-machine ls -q)

# Delete all VMs and their disk images
docker-machine rm $(docker-machine ls -q)
```

## initialize simple container (nodejs)

1. Dockerfile, image & container
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
$ sudo docker build -t hello-node .

# run and check on http://localhost:4444
$ sudo docker run -d -p 4444:8080 hello-node

# commit image
$ sudo docker tag hello-node tillderoquefeuil/hello-node:v0.0.1

# push image
$ sudo docker push tillderoquefeuil/hello-node:v0.0.1
```

2. docker-compose.yml, stack & service
```diff
$ cd ~/simple-container
$ cat docker-compose.yml
> version: "3"
> services:
>   web:
>     # replace username/repo:tag with your name and image details
>     image: tillderoquefeuil/hello-node:v0.0.1
>     deploy:
>       replicas: 2
>       resources:
>         limits:
>           cpus: "0.1"
>           memory: 50M
>       restart_policy:
>         condition: on-failure
>     ports:
>       - "4444:8080"
>     networks:
>       - webnet
> networks:
>   webnet:

$ sudo docker swarm init
$ sudo docker stack deploy -c docker-compose.yml hello-node
```