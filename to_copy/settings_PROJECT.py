# -*- coding: utf-8 -*-

'''Django settings for 'projects' project.'''


### standard project settings ###

DEBUG = True
TEMPLATE_DEBUG = DEBUG

ADMINS = (
  ('devstudent', 'devstudent'),
)

MANAGERS = ADMINS

DATABASES = {
  'default': {
    'ENGINE': 'django.db.backends.mysql', # Add 'postgresql_psycopg2', 'mysql', 'sqlite3' or 'oracle'.
   # 'NAME': 'dj_projects_dev',            # Or path to database file if using sqlite3.
    'NAME': 'dj_projects',                # Or path to database file if using sqlite3.
    'USER': 'root',                     # Not used with sqlite3.
    'PASSWORD': 'vagrant',               # Not used with sqlite3.
    'HOST': '127.0.0.1',                  # Set to empty string for localhost. Not used with sqlite3.
   # 'HOST': '',                       # Set to empty string for localhost. Not used with sqlite3.
    'PORT': '',                       # Set to empty string for default. Not used with sqlite3.
  }
}

# Local time zone for this installation. Choices can be found here:
# http://en.wikipedia.org/wiki/List_of_tz_zones_by_name
# although not all choices may be available on all operating systems.
# On Unix systems, a value of None will cause Django to use the same
# timezone as the operating system.
# If running in a Windows environment this must be set to the same as your
# system time zone.
TIME_ZONE = 'America/New_York'

# Language code for this installation. All choices can be found here:
# http://www.i18nguy.com/unicode/language-identifiers.html
LANGUAGE_CODE = 'en-us'

SITE_ID = 1

# If you set this to False, Django will make some optimizations so as not
# to load the internationalization machinery.
USE_I18N = True

# If you set this to False, Django will not format dates, numbers and
# calendars according to the current locale.
USE_L10N = True

# If you set this to False, Django will not use timezone-aware datetimes.
USE_TZ = True

# URL prefix for static files.
# Example: "http://media.lawrence.com/static/"
STATIC_URL = '/static/'

STATIC_ROOT = ''

# Make this unique, and don't share it with anybody.
SECRET_KEY = 'secretsecretfunfun'

# List of callables that know how to import templates from various sources.
TEMPLATE_LOADERS = (
    'django.template.loaders.filesystem.Loader',
    'django.template.loaders.app_directories.Loader',
#     'django.template.loaders.eggs.Loader',
)

MIDDLEWARE_CLASSES = (
    'django.middleware.common.CommonMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    # Uncomment the next line for simple clickjacking protection:
    # 'django.middleware.clickjacking.XFrameOptionsMiddleware',
)

ROOT_URLCONF = 'projects.urls'

# Python dotted path to the WSGI application used by Django's runserver.
#WSGI_APPLICATION = 'projects.apache.wsgi.application'

TEMPLATE_DIRS = (
    ## project
    #'/home/vagrant/LibraryEnvironment/projects/projects/templates_project',
    ## rome_app
    #'/home/vagrant/LibraryEnvironment/projects/rome_app/',
    ## software_app
    #'/home/vagrant/LibraryEnvironment/projects/software_app/',
    ## usep
    '/home/vagrant/LibraryEnvironment/projects/usep_app/',
)

INSTALLED_APPS = (
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.sites',
    'django.contrib.markup',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    # Uncomment the next line to enable the admin:
    'django.contrib.admin',
    # Uncomment the next line to enable admin documentation:
    # 'django.contrib.admindocs',
    #u'rome_app',
    #u'software_app',
    u'usep_app',
    #'markdown_deux',
)

# A sample logging configuration. The only tangible logging
# performed by this configuration is to send an email to
# the site admins on every HTTP 500 error when DEBUG=False.
# See http://docs.djangoproject.com/en/dev/topics/logging for
# more details on how to customize your logging configuration.
# LOGGING = {
#     'version': 1,
#     'disable_existing_loggers': False,
#     'filters': {
#         'require_debug_false': {
#             '()': 'django.utils.log.RequireDebugFalse'
#         }
#     },
#     'handlers': {
#         'mail_admins': {
#             'level': 'ERROR',
#             'filters': ['require_debug_false'],
#             'class': 'django.utils.log.AdminEmailHandler'
#         }
#     },
#     'loggers': {
#         'django.request': {
#             'handlers': ['mail_admins'],
#             'level': 'ERROR',
#             'propagate': True,
#         },
#     }
# }

LOGGING = {
  'version': 1,
  'disable_existing_loggers': True,
  'formatters': {
    'standard': {
      'format' : "[%(asctime)s] %(levelname)s [%(name)s:%(lineno)s] %(message)s",
      'datefmt' : "%d/%b/%Y %H:%M:%S"
    },
  },
  'handlers': {
    'null': {
      'level':'DEBUG',
      'class':'django.utils.log.NullHandler',
    },
    'usep_app_logfile': {
      'level':'DEBUG',
      'class':'logging.handlers.RotatingFileHandler',
      'filename': '/home/vagrant/LibraryEnvironment/logs/projects_usep_log.log',
      # 'maxBytes': 1000000,
      'maxBytes': '16777216', # 16megabytes
      'backupCount': 0,
      'formatter': 'standard',
    },
    'console':{
      'level':'INFO',
      'class':'logging.StreamHandler',
      'formatter': 'standard'
    },
  },
  'loggers': {
    'django': {
      'handlers':['console'],
      'propagate': True,
      'level':'WARN',
    },
    'django.db.backends': {
      'handlers': ['console'],
      'level': 'DEBUG',
      'propagate': False,
    },
    'usep_app': {
#     'handlers': ['console', 'usep_app_logfile'],
      'handlers': ['usep_app_logfile'],
      'level': 'DEBUG',
     },
  }
}


### non-standard project settings ###

# None yet
