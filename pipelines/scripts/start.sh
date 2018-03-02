#!/bin/bash

if [ -z BD_SCHEME ]; then
 cmd_opts="$cmd_opts --scheme=http"
else
 cmd_opts="$cmd_opts --scheme=$BD_SCHEME"
fi

if [ -n PORT ]; then
 cmd_opts="$cmd_opts --port=$PORT"
fi

if [ -n HOST ]; then
 cmd_opts="$cmd_opts --hoste=$HOST"
fi

if [ -z CONFIG ]; then
 cmd_opts="$cmd_opts --config=docker"
else
 cmd_opts="$cmd_opts --confite=$CONFIG"
fi

if [ -z CONFIG_FILE ]; then
 cmd_opts="$cmd_opts --config-file=./config/weaviate.conf.json"
else
 cmd_opts="$cmd_opts --config-file=$CONFIG_FILE"
fi

/var/weaviate/weaviate $cmd_opts > /var/weaviate/first_run.log 2>&1
