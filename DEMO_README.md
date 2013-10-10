# Nimblestrat.us Demo

## Introduction

This demonstration of the Nimblestrat.us infrastructure was originally developed for [Code Camp Columbus](http://codecampcolumbus.com) 2013. In order to alleviate issues with network vagaries, etc., it builds out the framework on a single host, simulating the use of multiple hosts via vagrant/virtualbox.  

## Setup

In order to run the demo, a host with the following is needed:

* [Docker](http://docker.io)
* git -- apt-get install git
* [vagrant](http://vagrantup.com)
* [virtualbox](http://virtualbox.org)

Please see the relevant pages for installation instructions.

Additionally, files are placed in `/opt/docker`, which is used to store the repository and scripts/binaries.

## Building the Demo

The `build_demo.sh` script does the following:


1. Install [pipework](https://github.com/jpetazzo/pipework) to `/opt/docker/bin`

2. Create a docker container for the [docker registry](https://github.com/nimblestratus/docker-registry).  This fork specifies the location of the container images and uses it as a volume.  Then the container is started.  All of the containers used for the demo are held in the registry.  Expose port 5000.

3. Build two vagrant virtualbox images:
   * Master Node
   * Worker Node
   
   These are based on the [Docker](http://github.com/dotcloud/docker) Vagrantfile, but add a few more packages:
	   * etcd
	   * etcdctl
	   * collectd
	   * pipework

4. Build logstash containers from Paul Czar's [logstash-demo](https://github.com/paulczar/docker-logstash-demo) base and place in registry.

5. Build [hipache](https://github.com/dotcloud/hipache) container and place in registry. This uses [](https://index.docker.io/u/samalba/hipache/) for the base.

6. Build collectd-graphite container using [lopter/collectd-graphite](https://index.docker.io/u/lopter/collectd-graphite/) as a base.

7. Build master node container and add to registry.


# Running the Demo

`run_demo.sh` does the following:


1. Start up master node.

2. Start up worker nodes, informing them about the master.  At some point the notification will become automated.

3. Start up hipache balancer in a worker

4. Start up collectd-graphite in a worker

5. Start up logstash

