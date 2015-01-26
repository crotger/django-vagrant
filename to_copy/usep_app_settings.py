# -*- coding: utf-8 -*-


COLLECTIONS_CACHE_SECONDS = 1  # 60 * 5 = 5 minutes

# INSCRIPTIONS_URL_SEGMENT = u'https://worfdev.services.brown.edu/django_media/projects_media/usep/images/inscriptions'
INSCRIPTIONS_URL_SEGMENT = u'https://worfdev.services.brown.edu/usep_images'

LOGIN_URL = u'http://127.0.0.1/projects/usep/login/'

PERMITTED_ADMINS = [
  u'devstudent',
  ]

PERMITTED_ADMIN_CONTACT = u'elli_mylonas@brown.edu'

PROJECT_APP = u'projects/usep'

SERVER_NAME = u'localhost:8000'
#SERVER_NAME = u'127.0.0.1'

# SOLR_URL_BASE = u'http://127.0.0.1:8080/solr/us_epigraphy/select/'  # vbox
# SOLR_URL_BASE = u'http://128.148.41.115:8080/solr/us_epigraphy/select/'  # vbox
SOLR_URL_BASE = u'http://worfdev.services.brown.edu:8080/solr/us_epigraphy/select/'

SPOOFED_ADMIN = u'devstudent'

TRANSFORMER_URL = u'http://repository.library.brown.edu:8081/saxon_processor/v2/transform'
# TRANSFORMER_XML_URL_SEGMENT = u'http://library.brown.edu/usep/xml'  # can't reliably use XML_URL_SEGMENT because transformer may not be able to access dev boxes.
TRANSFORMER_XML_URL_SEGMENT = u'http://library.brown.edu/usep_data/inscriptions'  # can't reliably use XML_URL_SEGMENT because transformer may not be able to access dev boxes.
TRANSFORMER_XSL_URL = u'http://library.brown.edu/django_media/projects_media/usep/xsl/USEp_display.xsl'

# XML_URL_SEGMENT = u'http://worfdev.services.brown.edu/usep/xml'
XML_URL_SEGMENT = u'http://worfdev.services.brown.edu/usep_data/inscriptions'


## testing with dummy cd display -- remove after 4-Oct-2014

TEMP_SOURCE_XML_URL = u'http://worfdev.services.brown.edu/usep_data/inscriptions/temp/data.xml'  # contains the relative path to the include file
TEMP_XSL_URL = u'http://worfdev.services.brown.edu/usep_data/resources/temp/stylesheet.xsl'
TEMP_SAXONCE_FILE_URL = u'http://worfdev.services.brown.edu/django_media/projects_media/usep/js/saxonce/Saxonce.nocache.js'
TEMP_XIPR_URL = u'http://worfdev.services.brown.edu/usep_data/resources/temp/xipr.xsl'


## testing with hardcoded but real data -- remove after 4-Oct-2014

TEMP2_SOURCE_XML_URL = u'http://worfdev.services.brown.edu/usep_data/inscriptions/CA.Berk.UC.HMA.G.8-4213.xml'
TEMP2_XSL_URL = u'http://worfdev.services.brown.edu/usep_data/resources/xsl/USEp_display.xsl'
TEMP2_SAXONCE_FILE_URL = u'http://worfdev.services.brown.edu/django_media/projects_media/usep/js/saxonce/Saxonce.nocache.js'
TEMP2_XIPR_URL = u'http://worfdev.services.brown.edu/django_media/projects_media/usep/xsl/xipr.xsl'


## display inscription

DISPLAY_INSCRIPTION_XML_URL_PATTERN = u'SCHEME://HOSTNAME/usep_data/inscriptions/INSCRIPTION_ID.xml'
DISPLAY_INSCRIPTION_XSL_URL = u'http://worfdev.services.brown.edu/usep_data/resources/xsl/USEp_display.xsl'
DISPLAY_INSCRIPTION_SAXONCE_FILE_URL = u'http://worfdev.services.brown.edu/django_media/projects_media/usep/js/saxonce/Saxonce.nocache.js'
DISPLAY_INSCRIPTION_XIPR_URL = u'http://worfdev.services.brown.edu/django_media/projects_media/usep/xsl/xipr.xsl'


## display publications

DISPLAY_PUBLICATIONS_XSL_URL = u'http://worfdev.services.brown.edu/usep_data/resources/xsl/pubs.xsl'
DISPLAY_PUBLICATIONS_BIB_URL = u'http://worfdev.services.brown.edu/usep_data/resources/titles.xml'
# DISPLAY_PUBLICATIONS_BIB_URL = u'http://worfdev.services.brown.edu/usep_data/resources/usepi.bib.xml'
