#!/bin/sh

docker build -t my-php-app1:latest . --no-cache

docker run -it --rm -p 8081:80 -p 8080:443 -p 8080:443/udp -e CADDY_GLOBAL_OPTIONS=debug -e --name my-running-app my-php-app1:latest
