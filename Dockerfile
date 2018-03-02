# Run on Ubuntu
FROM ubuntu:16.04

# Set config args
ARG config 
ARG action_schema
ARG thing_schema

# Crearing the dir of weaviate
RUN mkdir -p /var/weaviate/config && cd /var/weaviate

# Install needed packages and scripts
RUN echo "BUILDING weaviate_nightly_linux_amd64.zip"

RUN apt-get -qq update && apt-get -qq install -y jq curl zip wget && \
    wget -q -O /var/weaviate/weaviate.zip https://storage.googleapis.com/weaviate-dist/nightly/weaviate_nightly_linux_amd64.zip && \
    unzip -o -q -j weaviate.zip && \
    rm /var/weaviate/weaviate.zip && \
    rm -rf weaviate_nightly_linux_amd64.zip && \
    chmod +x /var/weaviate/weaviate
    
# Expose dgraph ports
EXPOSE 80

# Copying config files with using args
COPY $config /var/weaviate/
COPY $action_schema /var/weaviate/
COPY $thing_schema /var/weaviate/

# Copy script in container
COPY ./pipeline/scripts/start.sh /start.sh

# Set workdir
WORKDIR /

# Run!
ENTRYPOINT ["/start.sh"]

