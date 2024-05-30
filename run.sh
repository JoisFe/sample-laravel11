#!/bin/sh

docker build -t my-php-app1 . --no-cache

docker run -it --rm -p 80:80 -p 8081:443 -p 8081:443/udp -e CADDY_GLOBAL_OPTIONS=debug --name my-running-app my-php-app1
