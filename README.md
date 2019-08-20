[![GitHub stars](https://img.shields.io/github/stars/ntuangiang/serveo.svg)](https://github.com/ntuangiang/serveo/stargazers)
[![GitHub license](https://img.shields.io/github/license/ntuangiang/serveo.svg)](https://github.com/ntuangiang/serveo/blob/master/LICENSE)
![Docker Stars](https://img.shields.io/docker/stars/ntuangiang/serveo.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/ntuangiang/serveo.svg)
![Docker Automated build](https://img.shields.io/docker/automated/ntuangiang/serveo.svg)
![Docker Build Status](https://img.shields.io/docker/build/ntuangiang/serveo.svg)

# Expose local servers to the internet

[https://serveo.net](https://serveo.net) Serveo is an SSH server just for remote port forwarding. When a user connects to Serveo, they get a public URL that anybody can use to connect to their localhost server. 

[ntuangiang/serveo](https://hub.docker.com/r/ntuangiang/serveo) can let you secure URL to your localhost server through any NAT or firewall in Docker.

## Usage
1. Write a `docker-compose.yml` file.

## Basic

```yml
version: '3.7'

services:
  serveo:
    build:
      context: .
    environment:
      - SERVEO_PUBLISH_PROJECT=serveonginx

  serveonginx:
    image: nginx
```

## Request a particular subdomain

```yml
version: '3.7'

services:
  serveo:
    build:
      context: .
    environment:
      - SERVEO_SUB_DOMAIN=ntuangiang
      - SERVEO_SUB_DOMAIN_PORT=80 // If it's 80, you don't need this line 
      - SERVEO_PUBLISH_PROJECT=serveonginx
      - SERVEO_PUBLISH_PROJECT_PORT=80 If it's 80, you don't need this line

  serveonginx:
    image: nginx
```

## Request a particular subdomain

```yml
version: '3.7'

services:
  serveo:
    build:
      context: .
    environment:
      - SERVEO_SUB_DOMAIN=ntuangiang
      - SERVEO_SUB_DOMAIN_PORT=80 // If it's 80, you don't need this line 
      - SERVEO_PUBLISH_PROJECT=serveonginx
      - SERVEO_PUBLISH_PROJECT_PORT=80 If it's 80, you don't need this line

  serveonginx:
    image: nginx
```

Change the SSH username to get assigned a different subdomain:


```yml
version: '3.7'

services:
  serveo:
    build:
      context: .
    environment:
      - SERVEO_SUB_DOMAIN=ntuangiang
      - SERVEO_SUB_DOMAIN_PORT=80 // If it's 80, you don't need this line 
      - SERVEO_SSH_USER=ntuangiang
      - SERVEO_PUBLISH_PROJECT=serveonginx
      - SERVEO_PUBLISH_PROJECT_PORT=80 If it's 80, you don't need this line

  serveonginx:
    image: nginx
```

2. use `docker-compose up` to start container.

3. you need to use `docker-compose logs serveo` to see your new URL.

## Demo

```bash
$ git clone https://github.com/ntuangiang/serveo.git

$ cd example

$ sudo docker-compose up

$ sudo docker-compose logs serveo

Attaching to serveo_serveo_1
serveo_1  | Warning: Permanently added 'serveo.net,195.201.91.242' (RSA) to the list of known hosts.
serveo_1  | Forwarding HTTP traffic from https://excolo.serveo.net/
serveo_1  | Press g to start a GUI session and ctrl-c to quit.
```

## LICENSE

MIT License
