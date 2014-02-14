#!/bin/bash

#Only run this file WITHIN THE VIRTUAL ENVIRONMENT
#Otherwise django will be installed in the wrong place!

#This script installs Django and the other requirements into the virtual environment.
#It also creates the mysql database, starts the django project
#and replaces the default settings.py file with one that points to the settings of the
#'super project'

#install Django
pip install Django==1.4.2

#install dependencies for lxml -- loaded later from requirements.txt
apt-get -y install libxml2-dev libxslt-dev

LOCAL=/home/vagrant

#cd into the directory where the django project will live.
cd $LOCAL/LibraryEnvironment

#create the django project -- imaginatively named 'projects' -- hey, JB, I saw that! -BJD  :)
django-admin.py startproject projects

#move in usep app
mv /to_copy/usep_app $LOCAL/LibraryEnvironment/projects/usep_app

#replace django default settings.py with 1 line file that calls settings from 'super project'
cp /to_copy/settings.py projects/projects/
cp /to_copy/urls.py projects/projects/
cp /to_copy/wsgi.py projects/projects/

#add requirements.txt file to root of django project and install rest of the environment
cp /to_copy/requirements.txt projects/
pip install -r projects/requirements.txt

#drop database if desired
#mysql -uroot -pvagrant -e "DROP DATABASE IF EXISTS dj_projects;"
#create the database for the django project
#matches the settings_PROJECT.py file copied from the shared folder
mysql -uroot -pvagrant -e "CREATE DATABASE IF NOT EXISTS dj_projects DEFAULT CHARACTER SET utf8;"



#create database tables
cd $LOCAL/LibraryEnvironment/projects
python ./manage.py syncdb --noinput
# /home/vagrant/LibraryEnvironment/envs/env_projects/bin/python2.6 ./manage.py syncdb --noinput



#populate tables required for links to work
python ./manage.py loaddata usep_app /to_copy/usep_aboutpage.json
python ./manage.py loaddata usep_app /to_copy/usep_contactspage.json
python ./manage.py loaddata usep_app /to_copy/usep_flatcollection.json
python ./manage.py loaddata usep_app /to_copy/usep_linkspage.json
python ./manage.py loaddata usep_app /to_copy/usep_publicationspage.json
python ./manage.py loaddata usep_app /to_copy/usep_textspage.json
