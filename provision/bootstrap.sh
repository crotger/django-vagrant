#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
set -e # Exit script immediately on first error.
set -x # Print commands and their arguments as they are executed.

# Comment out during development
sudo apt-get update -y

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

# Python
sudo apt-get install -y python python-dev python-mysqldb python-lxml python-virtualenv
sudo apt-get install -y libmysqlclient-dev

# MySQL
echo mysql-server mysql-server/root_password password vagrant | sudo debconf-set-selections
echo mysql-server mysql-server/root_password_again password vagrant | sudo debconf-set-selections
sudo apt-get install -y mysql-server
sudo apt-get install -y mysql-client

#call script to create project structure, virtualenv, and install django app
source /home/vagrant/provision/createFiles.sh

echo Box provisioned. Now log into vagrant and intialize virtual environment.

exit

