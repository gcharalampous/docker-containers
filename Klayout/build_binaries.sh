#!/bin/bash

# Fetch the latest Klayout version from GitHub
latest=$(curl -s https://api.github.com/repos/KLayout/klayout/releases/latest | grep tag_name | cut -d '"' -f 4 | sed 's/v//')

# Ask the user for input with the latest version as default
echo "Latest Klayout version: $latest (press Enter to use this version)"
read -p "Enter the Klayout version: " klayout_v
klayout_v=${klayout_v:-$latest}

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

