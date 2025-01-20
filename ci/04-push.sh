#!/bin/bash
docker image build -t piyushh69/jenkins-demo2:$1 -f src/demo2-publish/dockerfile .

if [ -z ${DOCKER_HUB_USER+x} ]
then 
    echo 'Skipping login - credentials not set' 
else 
    docker login -u $DOCKER_HUB_USER -p $DOCKER_HUB_PASSWORD
fi

docker push piyushh69/jenkins-demo2:$1
