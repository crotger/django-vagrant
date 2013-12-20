# -*- coding: utf-8 -*-


COLLECTIONS_CACHE_SECONDS = 1  # 60 * 5 = 5 minutes

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
TRANSFORMER_XML_URL_SEGMENT = u'http://library.brown.edu/usep/xml'  # can't reliably use XML_URL_SEGMENT because transformer may not be able to access dev boxes.
TRANSFORMER_XSL_URL = u'http://library.brown.edu/django_media/projects_media/usep/xsl/USEp_display.xsl'

XML_URL_SEGMENT = u'http://worfdev.services.brown.edu/usep/xml'
#INSCRIPTIONS_URL_SEGMENT = u'https://raw.github.com/Brown-University-Library/usep-images/master/'
INSCRIPTIONS_URL_SEGMENT = u'https://worfdev.services.brown.edu/django_media/projects_media/usep/images/inscriptions'