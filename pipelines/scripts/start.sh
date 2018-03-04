#!/bin/bash

if [ -n $WEAVIATE_SCHEME ]; then
 cmd_opts="$cmd_opts --scheme=http"
else
 cmd_opts="$cmd_opts --scheme=$WEAVIATE_SCHEME"
fi

if [ -n $WEAVIATE_PORT ]; then
 cmd_opts="$cmd_opts --port=80"
else
 cmd_opts="$cmd_opts --port=$WEAVIATE_PORT"
fi

if [ -n $WEAVIATE_HOST ]; then
 cmd_opts="$cmd_opts --host=0.0.0.0"
else
 cmd_opts="$cmd_opts --host=$WEAVIATE_HOST"
fi

if [ -n $WEAVIATE_CONFIG ]; then
 cmd_opts="$cmd_opts --config=cassandra"
else
 cmd_opts="$cmd_opts --config=$WEAVIATE_CONFIG"
fi

if [ -n $WEAVIATE_CONFIG_FILE ]; then
 cmd_opts="$cmd_opts --config-file=./weaviate.conf.json"
else
 cmd_opts="$cmd_opts --config-file=$WEAVIATE_CONFIG_FILE"
fi

echo "$WEAVIATE_CONFIG"

if [ "$WEAVIATE_CONFIG" == "cassandra" ]; then
 until cqlsh --cqlversion=3.4.4 "$WEAVIATE_CASSANDRA_DB_HOST" -e exit; do
   >&2 echo "Cassandra is unavailable - sleeping"
   sleep 1
 done
else
 echo "DB is not cassandra"
 exit 1
fi


cd /var/weaviate/
echo $cmd_opts
exec ./weaviate $cmd_opts
