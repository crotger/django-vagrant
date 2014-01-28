#!/bin/bash

#This script is called directly from the Vagrantfile

export DEBIAN_FRONTEND=noninteractive
set -e # Exit script immediately on first error.
set -x # Print commands and their arguments as they are executed.

# Comment out during development
sudo apt-get update -y



# # Install Python 2.6 for use in Virtual Environment
# #This repository can be found here https://launchpad.net/~fkrull/+archive/deadsnakes
# sudo add-apt-repository -y ppa:fkrull/deadsnakes
# sudo apt-get update -y
# sudo apt-get install -y python2.6 python2.6-dev



# # Install  virtualenv
# mkdir /home/vagrant/LibraryEnvironment/envs
# virtualenv -p python2.6 --prompt=[env_prj] /home/vagrant/LibraryEnvironment/envs/env_projects
# source /home/vagrant/LibraryEnvironment/envs/env_projects/bin/activate
# pip freeze



#Set time zone
area="America"
zone="New_York"
sudo echo "$area/$zone" > /tmp/timezone
sudo cp -f /tmp/timezone /etc/timezone
sudo cp -f /usr/share/zoneinfo/$area/$zone /etc/localtime

# Basics.
sudo apt-get install -y git-core mercurial vim screen wget curl raptor-utils unzip
sudo apt-get install -y tree

# Web server
sudo apt-get install -y apache2

# System Python (2.7)
sudo apt-get install -y python python-dev python-mysqldb python-lxml python-virtualenv
sudo apt-get install -y libmysqlclient-dev

sudo apt-get install -y python-software-properties #required for add-apt-repository command below
sudo apt-get update -y

# Install Python 2.6 for use in Virtual Environment
#This repository can be found here https://launchpad.net/~fkrull/+archive/deadsnakes
sudo add-apt-repository -y ppa:fkrull/deadsnakes
sudo apt-get update -y
sudo apt-get install -y python2.6 python2.6-dev



# Install  virtualenv
mkdir /home/vagrant/LibraryEnvironment/envs
virtualenv -p python2.6 --prompt=[env_prj] /home/vagrant/LibraryEnvironment/envs/env_projects
source /home/vagrant/LibraryEnvironment/envs/env_projects/bin/activate
pip freeze



# MySQL
echo mysql-server mysql-server/root_password password vagrant | sudo debconf-set-selections
echo mysql-server mysql-server/root_password_again password vagrant | sudo debconf-set-selections
sudo apt-get install -y mysql-server
sudo apt-get install -y mysql-client

#call script to create project structure, virtualenv, and install django app
source /home/vagrant/provision/createFiles.sh


source /home/vagrant/provision/virtual.sh

# echo Box provisioned. Now log into vagrant and intialize virtual environment.

exit

