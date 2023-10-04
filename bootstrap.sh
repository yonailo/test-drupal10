#!/bin/bash

service ssh start
/usr/local/bin/docker-php-entrypoint apache2-foreground
