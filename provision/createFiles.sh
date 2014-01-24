#!/bin/bash

#This script is called by bootstrap.sh

#This script creates the file structure necessary to support the django 'super project'
#architecture.  It also creates the python virtual environment where the django project will be created.

#Files/Directories to be created in VirtualEnv inside Vagrant Box for working django instance

#most of the directories created will be under /home/vagrant so it is being given a variable name
LOCAL=/home/vagrant

#cd into the synced folder where you will create the django 'super project'
cd $LOCAL/LibraryEnvironment

#create log file
mkdir logs
touch logs/projects_usep_log.log
sudo chmod 777 /home/vagrant/LibraryEnvironment/logs/projects_usep_log.log

#create local settings folders as python packages
mkdir project_local_settings
touch project_local_settings/__init__.py
mkdir project_local_settings/dj_projects_local_settings
touch project_local_settings/dj_projects_local_settings/__init__.py

#copy in 'super project settings' from shared folder
cp /to_copy/settings_PROJECT.py project_local_settings/dj_projects_local_settings/
cp /to_copy/usep_app_settings.py project_local_settings/dj_projects_local_settings/

#Now create the virtual environment, called env_projects
#It will live under /home/vagrant and use Python 2.6
#When you activate the virtualenv your prompt will read [env_prj]

cd $LOCAL
mkdir envs
cd envs
virtualenv -p python2.6 --prompt=[env_prj] $LOCAL/envs/env_projects

#copy usep.pth to site-packages to automatically get settings on PYTHONPATH
cp /to_copy/usep.pth /home/vagrant/envs/env_projects/lib/python2.6/site-packages/usep.pth

#get app from bitbucket
#storing it in to_copy for now because there is not yet a 'projects' dir
#grrr can't do this yet; will make this public eventually and then it will work
    # cd /to_copy/
    # export APP_URL="https://$BB_USERNAME:$BB_PASSWORD@bitbucket.org/bul/projects-usep_app.git"
    # echo "app url is: $APP_URL"
    # git clone $APP_URL ./usep_app
# cd /to_copy/
# git clone https://bitbucket.org/bul/projects-usep_app.git ./usep_app
