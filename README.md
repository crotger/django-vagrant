# Django Vagrant

##In Progress

The install scripts are heavily commented.  You can copy all lines of code below directly into the command prompt.  If a change of directory is required in between steps, it will be specified.

##Still Needs
- to be made compliant with a Centos5 box (currently Ubuntu)

##What this does

This code uses [Vagrant](http://www.vagrantup.com/) to configure a complete working environment to run Brown's [Django](http://djangoproject.org) app for the [U.S. Epigraphy Project](http://library.brown.edu/projects/usep/collections/).

Specifically, it will

- use [VirtualBox](https://www.virtualbox.org/) to install an Ubuntu 64 Precise image
- install all necessary software on the Ubuntu server
- create a virtual environment that runs Python 2.6 (to match the Library's server configuration)
- install Django and create the necessary project for the usep_app
- install the current github code for the usep_app
- and populate the Ubuntu mysql tables with data

The Django web application will run on http://localhost:5678/usep/ the local source will be /home/vagrant/LibraryEnvironment/projects/

All files will be installed in a synced folder called LibraryEnvironment (a blank copy ships with this repository) so you can access them with the editor of your choice on your host machine.

The box will boot and install Django 1.4.2 and dependencies.  This will take several minutes.  I suggest using an ethernet connection and getting a cup of coffee.

##Requirements

- [Vagrant](http://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/)

These are both open source software packages.  You don't need to worry about using Virtual Box directly, but you might want to spend some time with the [Vagrant Documentation](http://docs.vagrantup.com/v2/), especially the Getting Started Tutorial, which is very good.

## Install

####Create and provision the Vagrant Box

    laptop$ git clone https://github.com/birkin/django-vagrant.git ./django-vagrant
    laptop$ cd ./django-vagrant
    laptop$ vagrant up

For subsequent vagrant startups, you can use the --no-provision flag to prevent the Django install script from running.

    laptop$ vagrant up --no-provision

####Login to the Vagrant Box

    laptop$ vagrant ssh
    vagrant$ pwd
    /home/vagrant

####Activate the python virtual environment
    vagrant$ source ./LibraryEnvironment/envs/env_projects/bin/activate

Your prompt should now be [env-prj].

####Explore a bit

    [env_prj]vagrant$ cd ./LibraryEnvironment/projects/
    [env_prj]vagrant$ pwd
    /home/vagrant/LibraryEnvironment/projects

At this point, if you run

    [env-prj]vagrant$ tree

 You should get the following output (only two levels shown):

    .
    |-- manage.py
    |-- projects
    |   |-- __init__.py
    |   |-- __init__.pyc
    |   |-- settings.py
    |   |-- settings.pyc
    |   |-- urls.py
    |   `-- wsgi.py
    |-- requirements.txt
    `-- usep_app
        |-- admin.py
        |-- __init__.py
        |-- __init__.pyc
        |-- models.py
        |-- models.pyc
        |-- README.md
        |-- settings_app.py
        |-- settings_app.pyc
        |-- static
        |-- templatetags
        |-- tests.py
        |-- urls_app.py
        |-- usep_templates
        `-- views.py

Everything should now be in place.

##Using the code
To view the project, make sure:

- you have run 'vagrant ssh' from the 'django-vagrant' directory
- you are in /home/vagrant/LibraryEnvironment/projects
- you have activated the virtual environment

(if you're following along with this readme, you'll be all set)

To start the django built-in dev-server...

    [env-prj]vagrant$ python ./manage.py runserver 0.0.0.0:8000

The output you'll see is:

    Validating models...

    0 errors found
    Django version 1.4.2, using settings 'projects.settings'
    Development server is running at http://0.0.0.0:8000/
    Quit the server with CONTROL-C.

Open a browser window back on your home computer and point it to a specific collection -- http://127.0.0.1:5678/usep/collections/CA.Berk.UC.HMA/

(Why port 5678 when the dev-server was started with port 8000? Because we configured vagrant to listen on your laptop for incoming laptop port 5678 requests, and route them to your Ubuntu box's port 8000.)

You should be looking at the collections page for the University of California at Berkeley on the U.S. Epigraphy Website and can view individual inscriptions.  You can change collections if you have the collection ID and can type it into the URL. You cannot access the search page, because the kochief search instance is a separate django app.

(BJD note: occasionally when I do this for the _first_ time, I see web-content without CSS, and note that the web-server has quit. Starting it up again and loading the page then works reliably.)

## Notes
 * This is intended for development only.  Change passwords if you intend to use this config for deployment.
 * The source at `/home/vagrant/LibraryEnvironment/projects/usep_app` is cloned from a seperate github repository
 * Your Django environment will be dropped and reconfigured anytime that `vagrant reload` or `vagrant provision` is run.  Be sure to backup any data or code before running these commands.
 * Various other development tools, are installed too.  Comment those out if they are not needed.

## Acknowledgements
This project was originally forked from [lawlesst/vivo-vagrant](https://github.com/lawlesst/vivo-vagrant).
