#!/bin/bash

# This script is called directly from the Vagrantfile

## general config ##

#vagrant config?
export DEBIAN_FRONTEND=noninteractive
set -e # Exit script immediately on first error.
set -x # Print commands and their arguments as they are executed.

#update package manager resources
sudo apt-get update -y

#set time zone
area="America"
zone="New_York"
sudo echo "$area/$zone" > /tmp/timezone
sudo cp -f /tmp/timezone /etc/timezone
sudo cp -f /usr/share/zoneinfo/$area/$zone /etc/localtime

## end general config ##

## main server installs ##

#basics (bjd- needed?)
sudo apt-get install -y git-core mercurial vim screen wget curl raptor-utils unzip
sudo apt-get install -y tree

#apache
sudo apt-get install -y apache2

#System Python (2.7) (bdj- neede?)
sudo apt-get install -y python python-dev python-mysqldb python-lxml python-virtualenv
sudo apt-get install -y libmysqlclient-dev

sudo apt-get install -y python-software-properties #required for add-apt-repository command below
sudo apt-get update -y

#Python 2.6 for use in Virtual Environment (to match production server)
#This repository can be found here https://launchpad.net/~fkrull/+archive/deadsnakes
sudo add-apt-repository -y ppa:fkrull/deadsnakes
sudo apt-get update -y
sudo apt-get install -y python2.6 python2.6-dev

#MySQL
echo mysql-server mysql-server/root_password password vagrant | sudo debconf-set-selections
echo mysql-server mysql-server/root_password_again password vagrant | sudo debconf-set-selections
sudo apt-get install -y mysql-server
sudo apt-get install -y mysql-client

#lxml dependencies -- loaded later from requirements.txt
apt-get -y install libxml2-dev libxslt-dev

## end main server installs ##

## virtualenv work ##

#Create a virtualenv and ACTIVATE it
mkdir /home/vagrant/LibraryEnvironment/envs
virtualenv -p python2.6 --prompt=[env_prj] /home/vagrant/LibraryEnvironment/envs/env_projects

#Add extra variables for TTWR. TEMPORARY SOLUTION!!! (Carlos, 1/26/15)
cat /to_copy/extra_settings.sh >> /home/vagrant/LibraryEnvironment/envs/env_projects/bin/activate
source /home/vagrant/LibraryEnvironment/envs/env_projects/bin/activate

#install necessary python packages
pip install -r /to_copy/requirements.txt

#install bdrxml for Rome
git clone https://github.com/Brown-University-Library/bdrxml.git ~/bdrxml
python ~/bdrxml/setup.py install

#copy usep.pth to env_projects->site-packages to automatically get settings on the env_projects PYTHONPATH
cp /to_copy/usep.pth /home/vagrant/LibraryEnvironment/envs/env_projects/lib/python2.6/site-packages/usep.pth

## end virtualenv work ##

## create support files ##

#logs
mkdir /home/vagrant/LibraryEnvironment/logs
touch /home/vagrant/LibraryEnvironment/logs/projects_usep_log.log
sudo chmod 777 /home/vagrant/LibraryEnvironment/logs/projects_usep_log.log

#'real' settings directory (django settings.py and settings_app.py will reference these)
#__init__.py makes directories into python packages
mkdir /home/vagrant/LibraryEnvironment/project_local_settings
touch /home/vagrant/LibraryEnvironment/project_local_settings/__init__.py
mkdir /home/vagrant/LibraryEnvironment/project_local_settings/dj_projects_local_settings
touch /home/vagrant/LibraryEnvironment/project_local_settings/dj_projects_local_settings/__init__.py

#set up 'real' settings files
cp /to_copy/settings_PROJECT.py /home/vagrant/LibraryEnvironment/project_local_settings/dj_projects_local_settings/settings_PROJECT.py
cp /to_copy/usep_app_settings.py /home/vagrant/LibraryEnvironment/project_local_settings/dj_projects_local_settings/usep_app_settings.py

## end create support files ##

## create django project (named 'projects') ##

#main django project
cd /home/vagrant/LibraryEnvironment
django-admin.py startproject projects

#usep app
cd /home/vagrant/LibraryEnvironment/projects
git clone https://github.com/Brown-University-Library/projects-usep-app.git usep_app

#replace django default project-level settings.py with 1 line file that calls 'real' settings from 'super project'
cp /to_copy/settings.py /home/vagrant/LibraryEnvironment/projects/projects/settings.py

#replace django default project-level urls.py with file that enables usep_app
cp /to_copy/urls.py /home/vagrant/LibraryEnvironment/projects/projects/urls.py

#replace django default wsgi.py with customized one -- not used right now; dev-server used instead
cp /to_copy/wsgi.py /home/vagrant/LibraryEnvironment/projects/projects/wsgi.py

#add requirements.txt file to root of django project
cp /to_copy/requirements.txt /home/vagrant/LibraryEnvironment/projects/requirements.txt

## end create django project ##

## set up and populate database ##

#mysql -uroot -pvagrant -e "DROP DATABASE IF EXISTS dj_projects;"
#create the database for the django project
#matches the settings_PROJECT.py file copied from the shared folder
mysql -uroot -pvagrant -e "CREATE DATABASE IF NOT EXISTS dj_projects DEFAULT CHARACTER SET utf8;"

#create database tables
cd /home/vagrant/LibraryEnvironment/projects
python ./manage.py syncdb --noinput

#populate tables required for links to work
python ./manage.py loaddata usep_app /to_copy/usep_aboutpage.json
python ./manage.py loaddata usep_app /to_copy/usep_contactspage.json
python ./manage.py loaddata usep_app /to_copy/usep_flatcollection.json
python ./manage.py loaddata usep_app /to_copy/usep_linkspage.json
python ./manage.py loaddata usep_app /to_copy/usep_publicationspage.json
python ./manage.py loaddata usep_app /to_copy/usep_textspage.json

## end set up and populate database ##

echo "---"
echo "---"
echo "Box provisioned! Now log into vagrant, intialize the virtual environment, start the dev server and you'll be able to see the usep-app!"
echo "---"
echo "---"

exit

