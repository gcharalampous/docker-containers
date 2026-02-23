#!/bin/bash

# Fetch the latest Klayout version from GitHub
latest=$(curl -s https://api.github.com/repos/KLayout/klayout/releases/latest | grep tag_name | cut -d '"' -f 4 | sed 's/v//')

# Ask the user for input with the latest version as default
echo "Latest Klayout version: $latest (press Enter to use this version)"
read -p "Enter the Klayout version: " klayout_v
klayout_v=${klayout_v:-$latest}

# Confirm the version to be used
echo "Using Klayout version: $klayout_v"

KLAYOUT_VERSION=$klayout_v

# Function to clean up the container
cleanup() {
    echo "Stopping and removing the container..."
    docker stop klayout-container >/dev/null 2>&1
    docker rm klayout-container >/dev/null 2>&1
    echo "Cleanup completed."
}

# Run the Docker container
echo "Starting Docker container klayout-container with image klayout:$KLAYOUT_VERSION..."
if ! docker run -d --name klayout-container klayout:$KLAYOUT_VERSION; then
    echo "Failed to start Docker container." >&2
    exit 1
fi

# Ensure cleanup happens on script exit
trap cleanup EXIT

# Give the container a few seconds to start up
echo "Waiting for the container to start up..."
sleep 5

# Copy the binary from the container to the host
echo "Copying the binary from the container to the host..."
if ! sudo docker cp klayout-container:/opt/klayout-$KLAYOUT_VERSION /opt/klayout-$KLAYOUT_VERSION; then
    echo "Failed to copy the binary from the container." >&2
    exit 1
fi

echo "Binary copied successfully."

# Only remove the image if copy succeeded
echo "Removing the Docker image..."
docker rmi klayout:$KLAYOUT_VERSION >/dev/null 2>&1
echo "Image removed."
