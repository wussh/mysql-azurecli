# Use an Ubuntu base image
FROM ubuntu:20.04

# Install MySQL server and client
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server mysql-client

# Install curl and the Azure CLI
RUN apt-get update && apt-get install -y curl \
    && curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Copy the backup script
COPY backup.sh /scripts/backup.sh
RUN chmod +x /scripts/backup.sh

# Start MySQL and keep the container running
CMD ["sh", "-c", "/scripts/backup.sh"]