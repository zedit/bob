## Documentation


To build this app, you must clone repository in your directory and make "docker-compose up".

Before your build you can add environment variables to override default values in docker-compose.yaml:

WEAVIATE_SCHEME - the listeners to enable, this can be repeated and defaults to the schemes in the swagger spec (default: http)
WEAVIATE_PORT - the port to listen on for insecure connections (defaults: 80) 
WEAVIATE_HOST - the IP to listen on (default: localhost)
WEAVIATE_CONFIG - the section inside the config file that has to be used (default: cassandra) 
WEAVIATE_CONFIG_FILE - path to config file (default: ./weaviate.conf.json)

CQLVERSION - Specify a particular CQL version (default: 3.4.4).

