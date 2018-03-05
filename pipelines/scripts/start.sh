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


if [ "$WEAVIATE_CONFIG" == "cassandra" ]; then
 counter=0
 until cqlsh --cqlversion=3.4.4 "$WEAVIATE_CASSANDRA_DB_HOST" -e exit; do
   >&2 echo "Cassandra is unavailable - sleeping"
   sleep 3
   ((counter++))
   if [ $counter -eq 10 ]; then
     echo "cassandra is not available trying to start without cassandra"
     break 
   fi
 done
else
 echo "DB is not cassandra"
fi


cd /var/weaviate/
exec ./weaviate $cmd_opts
