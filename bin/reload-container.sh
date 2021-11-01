#!/bin/sh

if [ -n "$CONTAINER_TO_RESTART" ] && [ -S '/var/run/docker.sock' ]; then
	curl -s -X POST --unix-socket /var/run/docker.sock "http://v1.30/containers/$CONTAINER_TO_RESTART/restart" >&2
fi
