#!/bin/bash

# Validate that the tag argument is provided
if [ -z "$1" ]; then
    echo "Error: Image tag is required as an argument."
    exit 1
fi

# Validate that the Dockerfile exists
if [ ! -f "src/demo2-publish/dockerfile" ]; then
    echo "Error: Dockerfile not found at src/demo2-publish/dockerfile."
    exit 1
fi

# Build the Docker image
docker image build -t piyushh69/jenkins-demo2:$1 -f src/demo2-publish/dockerfile .
if [ $? -ne 0 ]; then
    echo "Error: Docker build failed."
    exit 1
fi

# Check for Docker Hub credentials and log in if available
if [ -z "$DOCKER_HUB_USER" ] || [ -z "$DOCKER_HUB_PASSWORD" ]; then
    echo "Skipping login - Docker Hub credentials not set."
else
    echo "Logging into Docker Hub..."
    docker login -u "$DOCKER_HUB_USER" -p "$DOCKER_HUB_PASSWORD"
    if [ $? -ne 0 ]; then
        echo "Error: Docker login failed."
        exit 1
    fi
fi

# Push the Docker image
docker push piyushh69/jenkins-demo2:$1
if [ $? -ne 0 ]; then
    echo "Error: Docker push failed."
    exit 1
fi

echo "Docker image pushed successfully: piyushh69/jenkins-demo2:$1"
