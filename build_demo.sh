#!/bin/env bash

# The purpose of this script is to build out a nimblestratus install
# for testing/demo purposes.

# setup

sudo mkdir -p /opt/docker/bin
PATH=/opt/docker/bin:$PATH


echo Installing pipework
sudo curl -s https://raw.github.com/jpetazzo/pipework/master/pipework > /opt/docker/bin/pipework
sudo chmod u+x ./bin/pipework


echo Creating container for registry

docker build -t nimblestratus/docker-registry github.com/nimblestratus/docker-registry

REGISTRY=$(docker run -d -p 5000:5000 nimblestratus/docker-registry)

echo Registry is running as $REGISTRY on port 5000

echo Setting up vagrant

echo "  Checking for vocker"
x=`vagrant plugin list|grep vocker`
if [[ "XX$x" == "XX" ]]; then
    vagrant plugin install vocker
else
    echo "    Already installed"
fi


