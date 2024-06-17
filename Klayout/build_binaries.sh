#!/bin/bash

# Ask the user for input with a default value
read -p "Enter the Klayout version (i.e. 0.29.0) [default: 0.29.0]: " klayout_v
klayout_v=${klayout_v:-0.29.0}  # Use default if no input is provided

# Confirm the version to be used
echo "Using Klayout version: $klayout_v"

# Build the Docker image
echo "Building Docker image klayout:$klayout_v..."
if docker build --build-arg KLAYOUT_VERSION=$klayout_v -t klayout:$klayout_v .; then
    echo "Docker image klayout:$klayout_v built successfully."
else
    echo "Failed to build Docker image klayout:$klayout_v." >&2
    exit 1
fi

