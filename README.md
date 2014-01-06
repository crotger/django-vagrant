# Django Vagrant 

##In Progress

This project is a fork from [lawlesst/vivo-vagrant](https://github.com/lawlesst/vivo-vagrant) and is still be transitioned to work with Django instead of VIVO.

The install scripts are heavily commented.  You can copy all lines of code below directly into the command prompt.  If a change of directory is required in between steps, it will be specified.

##Still Needs
1. usep_app bitbucket repository to be made public
2. dump of dj_projects database currently on worf
  - until this is done, any part of the website that relies on the database will not display (including the main collections page)
3. to be made compliant with a Centos5 box and running Python2.6 (currently Ubuntu and Python2.7)

##When Done the following will be true

[Vagrant](http://www.vagrantup.com/) configuration and install scripts for running The Brown University Library's install of [Django](http://djangoproject.org) for the [U.S. Epigraphy Project](http://library.brown.edu/projects/usep/collections/) on an Ubuntu 64 Precise image.

The Django web application will run on http://localhost:5678/usep/ the local source will be /home/vagrant/LibraryEnvironment/projects/

All files will be installed in a synced folder called LibraryEnvironment (a blank copy ships with this repository) so you can access them with the editor of your chose on your host machine.  Just make sure you don't check the additional files back into the repostory! 

The box will boot and install Django 1.4.2 and dependencies.  This will take several minutes for the initial install.  I suggest using an ethernet connection and getting a cup of coffee.

##Requirements

- [Vagrant](http://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/)

These are both open source software packages.  You don't need to worry about using Virtual Box directly, but you might want to spend some time with the [Vagrant Documentation](http://docs.vagrantup.com/v2/), especially the Getting Started Tutorial, which is very good.

## Install

Currently this is broken into 3 parts because 1) I can't figure out how to install packages into a virtual environment from a bash script and 2) the usep_app code is still in a private repository.  Hopefully someone will be able to knit them into one seamless command, but until then:

####1. Create and provision the Vagrant Box
> git clone https://github.com/Brown-University-Library/django-vagrant.git django-vagrant  

> cd django-vagrant  

> vagrant up

For subsequent vagrant startups, you can use the --no-provision flag to prevent the Django install script from running.  

> vagrant up --no-provision

####2. Create the virtual environment within the Vagrant Box

> vagrant ssh

> source /home/vagrant/envs/env_projects/bin/activate

If this works your prompt should be [env-prj].  Now run the script to install django and the create the django 'super project'.  This can be your second coffee break.
> source provision/virtual.sh

At this point if you run
> tree

 You should get the following output:
(assuming you are in /home/vagrant/LibraryEnvironment)

- logs
   - projects_usep_logs.txt
- project_local_settings
   - dj_projects_local_settings
      - __init__.py
      - settings_PROJECT.py
      - usep_app_settings.py
   - __init__.py
- projects
    - manage.py
    - projects
       - __init__.py
       - settings.py
       - urls.py
       - wsgi.py
    - requirements.txt

5 directories, 11 files

####3. Clone specific repository for USEP.
This will be done in the original provisioning as soon as the repository is made public.  Until then go to https://bitbucket.org/bul/projects-usep_app

> cd /home/vagrant/LibraryEnvironment/projects/ 

> sudo git clone PRIVATE_REPO_ULR usep_app

Use your own password.  Get a 3rd cup of coffee.
Everything should now be in place.  

##Using the code
To view the project, make sure you are in /home/vagrant/LibraryEnvironment/projects and inside the virtual environment.

You'll have to specify the path to the 'super project' settings when you run manage.py AND bind the server to an external IP
> PYTHONPATH=/home/vagrant/LibraryEnvironment/project_local_settings/ python manage.py runserver 0.0.0.0:8000

Open a browser window back on your home computer and point it to a specific collection localhost:5678/usep/collections/CA.Berk.UC.HMA/

You should be looking at the collections page for the University of California at Berkeley on the U.S. Epigraphy Website and can view individual inscriptions.  You can change collections if you have the collection ID and can type it into the URL.  But without the database you cannot use the site navigation, because all the static pages are in the database.  You also cannot access the search page, but that is becuase the kochief instance is a seperate django app.


## Notes
 * This is intended for development only.  Change passwords if you intend to use this config for deployment.
 * The source at `/home/vagrant/LibraryEnvironment/projects/usep_app` is cloned from a seperate github repository
 * Your Django environment will be dropped and reconfigured anytime that `vagrant reload` or `vagrant provision` is run.  Be sure to backup any data or code before running these commands.
 * Various other development tools, are installed too.  Comment those out if they are not needed.

