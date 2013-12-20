# Django Vagrant 

##In Progress

This project is a fork from (lawlesst/vivo-vagrant)[https://github.com/lawlesst/vivo-vagrant] and is still be transitioned to work with Django instead of VIVO.

##When Done the following will be true

[Vagrant](http://www.vagrantup.com/) configuration and install scripts for running The Brown University Library's install of [Django](http://djangoproject.org)for the [U.S. Epigraphy Project](http://library.brown.edu/projects/usep/collections/) on an Ubuntu 64 Precise image.

The Django web application will run on http://http://localhost:8080/projects the local source will be /usr/local/LibraryEnvironment/projects/
The box will boot and install Django 1.4.2 and dependencies.  This will take several minutes for the initial install.

## Install

~~~
$ git clone https://github.com/Brown-University-Library/django-vagrant.git django-vagrant
$ cd django-vagrant
$ vagrant up
~~~

For subsequent vagrant startups, you can use the --no-provision flag to prevent the Django install script from running.  
~~~
$ vagrant up --no-provision
~~~

## Notes
 * This is intended for development only.  Change passwords if you intend to use this config for deployment.
 * The source at `/usr/local/LibraryEnvironment/projects/usep_app` is cloned from a seperate githup repository.  ADD URL ONCE PUBLIC
 * Your Django environment will be dropped and reconfigured anytime that `vagrant reload` or `vagrant provision` is run.
 Be sure to backup any data or code before running these commands.
 * Various other development tools, are installed too.  Comment those out if they are not needed.

