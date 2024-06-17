#!/bin/bash

# Ask the user for input with a default value
read -p "Enter the Klayout version (i.e. 0.29.0) [default: 0.29.0]: " klayout_v
klayout_v=${klayout_v:-0.29.0}  # Use default if no input is provided

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

# Cleanup will be handled by the trap command

