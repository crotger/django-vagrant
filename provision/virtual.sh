#!/bin/bash

#Only run this file WITHIN THE VIRTUAL ENVIRONMENT
#Otherwise django will be installed in the wrong place!

#This script installs Django and the other requirements into the virtual environment.
#It also creates the mysql database, starts the django project
#and replaces the default settings.py file with one that points to the settings of the
#'super project'

#install Django
sudo pip install Django==1.4.2

#install dependencies for lxml -- loaded later from requirements.txt
sudo apt-get -y install libxml2-dev libxslt-dev

LOCAL=/usr/local

#cd into the directory where the django project will live.
cd $LOCAL/LibraryEnvironment

#create the django project -- imaginatively named 'projects'
sudo django-admin.py startproject projects

#replace django default settings.py with 1 line file that calls settings from 'super project'
sudo cp /to_copy/settings.py projects/projects/
sudo cp /to_copy/urls.py projects/projects/
sudo cp /to_copy/wsgi.py projects/projects/

#add requirements.txt file to root of django project and install rest of the environment
sudo cp /to_copy/requirements.txt projects/
sudo pip install -r projects/requirements.txt

#drop database if desired
#mysql -uroot -pvagrant -e "DROP DATABASE IF EXISTS dj_projects;"
#create the database for the django project
#matches the settings_PROJECT.py file copied from the shared folder
mysql -uroot -pvagrant -e "CREATE DATABASE IF NOT EXISTS dj_projects DEFAULT CHARACTER SET utf8;"

#load database with dump copied from shared folder
#mysql -uroot -pvagrant dj_projects < somedump_TIMESTAMP.sql

#clone repo
#cd projects
#sudo git clone ACTUAL_URL_ONCE_PROJECT_IS_PUBLIC usep_app