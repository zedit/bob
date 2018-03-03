#!/bin/bash

if [ -n BD_SCHEME ]; then
 cmd_opts="$cmd_opts --scheme=http"
else
 cmd_opts="$cmd_opts --scheme=$BD_SCHEME"
fi

if [ -n PORT ]; then
 cmd_opts="$cmd_opts --port=11121"
else
 cmd_opts="$cmd_opts --port=$PORT"
fi

if [ -n HOST ]; then
 cmd_opts="$cmd_opts --host=localhost"
else
 cmd_opts="$cmd_opts --host=$HOST"
fi

if [ -n CONFIG ]; then
 cmd_opts="$cmd_opts --config=cassandra"
else
 cmd_opts="$cmd_opts --config=$CONFIG"
fi

if [ -n CONFIG_FILE ]; then
 cmd_opts="$cmd_opts --config-file=./weaviate.conf.json"
else
 cmd_opts="$cmd_opts --config-file=$CONFIG_FILE"
fi

cd /var/weaviate/
echo $cmd_opts
exec ./weaviate $cmd_opts
