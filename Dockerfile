#Run on Ubuntu
FROM ubuntu:16.04

# Set the Workdir to weaviate
RUN mkdir -p /var/weaviate/config && cd /var/weaviate
WORKDIR /var/weaviate

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

COPY ./pipeline/scripts/start.sh /start.sh

WORKDIR /

# Run!
ENTRYPOINT ["/start.sh"]

