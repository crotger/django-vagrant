# Django Vagrant

##In Progress

This project is a fork from [lawlesst/vivo-vagrant](https://github.com/lawlesst/vivo-vagrant) and is still being transitioned to work with Django instead of VIVO.

The install scripts are heavily commented.  You can copy all lines of code below directly into the command prompt.  If a change of directory is required in between steps, it will be specified.

##Still Needs
- to be made compliant with a Centos5 box (currently Ubuntu)

##What this does

[Vagrant](http://www.vagrantup.com/) configuration and install scripts for running The Brown University Library's install of [Django](http://djangoproject.org) for the [U.S. Epigraphy Project](http://library.brown.edu/projects/usep/collections/) on an Ubuntu 64 Precise image. It will also create a virtual environment that runs Python 2.6 (to match the Library's server configuration).

The Django web application will run on http://localhost:5678/usep/ the local source will be /home/vagrant/LibraryEnvironment/projects/

All files will be installed in a synced folder called LibraryEnvironment (a blank copy ships with this repository) so you can access them with the editor of your choice on your host machine.  Just make sure you don't check the additional files back into the repostory!

The box will boot and install Django 1.4.2 and dependencies.  This will take several minutes for the initial install.  I suggest using an ethernet connection and getting a cup of coffee.

##Requirements

- [Vagrant](http://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/)

These are both open source software packages.  You don't need to worry about using Virtual Box directly, but you might want to spend some time with the [Vagrant Documentation](http://docs.vagrantup.com/v2/), especially the Getting Started Tutorial, which is very good.

## Install

Currently this is broken into 2 parts because 1) I can't figure out how to install packages into a virtual environment from a bash script.  Hopefully someone will be able to knit them into one seamless command, but until then:

####1. Create and provision the Vagrant Box

    laptop$ git clone https://github.com/Brown-University-Library/django-vagrant.git ./django-vagrant
    laptop$ cd ./django-vagrant
    laptop$ vagrant up

For subsequent vagrant startups, you can use the --no-provision flag to prevent the Django install script from running.

    laptop$ vagrant up --no-provision

Note, this step pulls the usep_app from github into a temporary location. It will be moved, in the next script, to its proper destination (which doesn't exist yet at this point).

####2. Create the virtual environment within the Vagrant Box

    laptop$ vagrant ssh
    vagrant@precise64:~$ pwd
    /home/vagrant
    vagrant$ source ./envs/env_projects/bin/activate

If this works your prompt should be [env-prj].  Now run the script to install django and the create the django 'super project'.  This can be your second coffee break.

    [env-prj]vagrant$ source ./provision/virtual.sh

At this point you should be in a 'projects' directory:

    [env_prj]vagrant:~/LibraryEnvironment/projects$ pwd
    /home/vagrant/LibraryEnvironment/projects

At this point if you run

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

    10 directories, 136 files
    5 directories, 11 files

Everything should now be in place.

##Using the code
To view the project, make sure you are in /home/vagrant/LibraryEnvironment/projects and inside the virtual environment.

To start the django built-in dev-server (binding the server to an external IP)...

    [env-prj]vagrant$ python ./manage.py runserver 0.0.0.0:8000

The output you'll see is:

    Validating models...

    0 errors found
    Django version 1.4.2, using settings 'projects.settings'
    Development server is running at http://0.0.0.0:8000/
    Quit the server with CONTROL-C.

Open a browser window back on your home computer and point it to a specific collection -- http://127.0.0.1:5678/usep/collections/CA.Berk.UC.HMA/

You should be looking at the collections page for the University of California at Berkeley on the U.S. Epigraphy Website and can view individual inscriptions.  You can change collections if you have the collection ID and can type it into the URL.  But without the database you cannot use the site navigation, because all the static pages are in the database.  You also cannot access the search page, but that is becuase the kochief instance is a seperate django app.

(Often when I do this for the _first_ time, I see web-content without CSS, and note that the web-server has quit. Starting it up again and loading the page then works reliably.)

## Notes
 * This is intended for development only.  Change passwords if you intend to use this config for deployment.
 * The source at `/home/vagrant/LibraryEnvironment/projects/usep_app` is cloned from a seperate github repository
 * Your Django environment will be dropped and reconfigured anytime that `vagrant reload` or `vagrant provision` is run.  Be sure to backup any data or code before running these commands.
 * Various other development tools, are installed too.  Comment those out if they are not needed.
