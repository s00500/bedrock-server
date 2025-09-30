FROM ubuntu:24.04
ARG BDS_Version=1.21.111.1

#https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-1.21.111.1.zip


# Install dependencies
RUN apt-get update && \
    apt-get install -y unzip wget libcurl4 libssl3 && \
    rm -rf /var/lib/apt/lists/*

ENV VERSION=$BDS_Version
# Download and extract the bedrock server
RUN wget https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-${VERSION}.zip -O bedrock-server.zip && \
    unzip bedrock-server.zip -d bedrock-server && \
    rm bedrock-server.zip 
    
# Create a separate folder for configurations move the original files there and create links for the files
RUN mv /bedrock-server/server.properties /bedrock-server/config && \
    mv /bedrock-server/permissions.json /bedrock-server/config && \
    ln -s /bedrock-server/config/server.properties /bedrock-server/server.properties && \
    ln -s /bedrock-server/config/permissions.json /bedrock-server/permissions.json && \
    ln -s /bedrock-server/config/whitelist.json /bedrock-server/whitelist.json

EXPOSE 19132/udp

VOLUME /bedrock-server/worlds /bedrock-server/config

WORKDIR /bedrock-server
ENV LD_LIBRARY_PATH=.
CMD ["./bedrock_server"]
