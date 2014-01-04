# Django Vagrant 

##In Progress

This project is a fork from [lawlesst/vivo-vagrant](https://github.com/lawlesst/vivo-vagrant) and is still be transitioned to work with Django instead of VIVO.

The install scripts are heavily commented.  You can copy all lines of code below directly into the command prompt.  If a change of directory is required in between steps, it will be specified.

##Still Needs
1. usep_app bitbucket repository to be made public
2. dump of dj_projects database currently on worf
3. to be made compliant with a Centos5 box

##When Done the following will be true

[Vagrant](http://www.vagrantup.com/) configuration and install scripts for running The Brown University Library's install of [Django](http://djangoproject.org) for the [U.S. Epigraphy Project](http://library.brown.edu/projects/usep/collections/) on an Ubuntu 64 Precise image.

The Django web application will run on http://localhost:5678/projects the local source will be /usr/local/LibraryEnvironment/projects/
The box will boot and install Django 1.4.2 and dependencies.  This will take several minutes for the initial install.

## Install

Currently this is broken into 3 parts because I can't figure out how to install packages into a virtual environment from a bash script and the usep_app code is still in a private repository.  Hopefully someone will be able to knit them into one seamless command, but until then:

####1. Create and provision the Vagrant Box
> git clone https://github.com/Brown-University-Library/django-vagrant.git django-vagrant  
> cd django-vagrant  
> vagrant up

For subsequent vagrant startups, you can use the --no-provision flag to prevent the Django install script from running.  

> vagrant up --no-provision

####2. Create the virtual environment within the Vagrant Box

> vagrant ssh 
> source /usr/local/envs/env_projects/bin/activate

If this works your prompt should be [env-prj].  Now run the script to install django and the create the django 'super project'.
> source provision/virtual.sh

At this point if you run (you should be in /usr/local/LibraryEnvironment)
> tree

 You should get the following output:
 .
|-- logs
|   `-- projects_usep_logs.txt
|-- project_local_settings
|   |-- dj_projects_local_settings
|   |   |-- __init__.py
|   |   |-- settings_PROJECT.py
|   |   `-- usep_app_settings.py
|   `-- __init__.py
`-- projects
    |-- manage.py
    |-- projects
    |   |-- __init__.py
    |   |-- settings.py
    |   |-- urls.py
    |   `-- wsgi.py
    `-- requirements.txt

5 directories, 11 files

####3. Clone specific repository for USEP.
This will be done in the original provisioning as soon as the repository is made public.  Until then go to https://bitbucket.org/bul/projects-usep_app

> cd /usr/local/LibraryEnvironment/projects/ 

> sudo git clone PRIVATE_REPO_ULR usep_app

Use your own password.
Everything should now be in place.  

##Using the code
To view the project, make sure you are in /usr/local/LibraryEnvironment/projects and inside the virtual environment.

You'll have to specify the path to the 'super project' settings when you run manage.py
> PYTHONPATH=/usr/local/LibraryEnvironment/project_local_settings/ python manage.py runserver

Open a browser window back on your home computer and point it to localhost:5678/projects/usep/collections

You should be looking at the collections page for the U.S. Epigraphy Website.


## Notes
 * This is intended for development only.  Change passwords if you intend to use this config for deployment.
 * The source at `/usr/local/LibraryEnvironment/projects/usep_app` is cloned from a seperate github repositor.
 * Your Django environment will be dropped and reconfigured anytime that `vagrant reload` or `vagrant provision` is run.
 Be sure to backup any data or code before running these commands.
 * Various other development tools, are installed too.  Comment those out if they are not needed.

