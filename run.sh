#!/usr/bin/env bash

version='20200401'
author='Robert Nikutta & Data Lab Team <nikutta@noao.edu>'

# Set CWD to the location of this script
cd "$(dirname "$0")"

# Source the config file
. .docker/.config

# extract dir name and tgz file name from URL
nbdatafile=$(basename $nbdataurl)
nbdatadir=$(basename $nbdatafile .tgz)

# Pull container image from docker hub
if [ ! $(docker images -q $image:$tag) ]
then
    echo "Pulling Docker image $image:$tag from Docker Hub. Please wait..."
    #docker pull $image:$tag
    echo "Done."
else
    echo "Docker image $image:$tag already present on local machine.";
fi

# Check if nbdata folder exists
if [ ! -d $nbdatadir ]
then
    echo "Directory $nbdatadir doesn't exist. Creating."
    mkdir $nbdatadir
fi

# Pull nbdata.tgz from from Data Lab's FTP
if [ ! "$(ls -A $nbdatadir)" ]
then
    echo "Downloading data files for notebooks. Please wait..."
    wget $nbdataurl
    echo "Uncompressing notebook data..."
    tar xvfz $nbdatafile
    echo "Done."
else
    echo "Data files for notebooks already present on local machine."
fi

# Run container, while mounting nbdata as volume
echo
echo "############################################################"
echo "       Point your prowser to: http://localhost:$hostport"
echo "############################################################"
echo
sudo docker run -it -v $(pwd)/nbdata:/nbdata -p $hostport:8888 $image:$tag
