#!/bin/bash

#This script creates the file structure necessary to support the django 'super project'
#architecture.  It also creates the python virtual environment where the django project will be created. 

#Files/Directories to be created in VirtualEnv inside Vagrant Box for working django instance

#most of the directories created will be under /user/local so it is being given a variable name
LOCAL=/usr/local

cd $LOCAL

#Create container folder, you will stay in this folder for the rest of the shell script
mkdir LibraryEnvironment
cd LibraryEnvironment

#create log file
mkdir logs
touch logs/projects_usep_log.txt
sudo chmod 777 /usr/local/LibraryEnvironment/logs/projects_usep_log.txt

#create local settings folders as python packages
mkdir project_local_settings
touch project_local_settings/__init__.py
mkdir project_local_settings/dj_projects_local_settings
touch project_local_settings/dj_projects_local_settings/__init__.py

#copy in 'super project settings' from shared folder
cp /to_copy/settings_PROJECT.py project_local_settings/dj_projects_local_settings/
cp /to_copy/usep_app_settings.py project_local_settings/dj_projects_local_settings/

#Now create the virtual environment.
#It will live under /usr/local

cd $LOCAL
mkdir envs
cd envs
virtualenv --prompt=[env_prj] $LOCAL/envs/env_projects