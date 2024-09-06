#!/bin/bash
/docker-entrypoint.sh
nginx -g 'daemon off;' & ./server01