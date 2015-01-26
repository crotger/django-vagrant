from django.conf.urls import patterns, include, url

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'projects.views.home', name='home'),
    # url(r'^projects/', include('projects.foo.urls')),

    url( r'^usep/',  include('usep_app.urls_app') ),
  	url( r'^admin/',  include(admin.site.urls) ),
    
    # Uncomment for TTWR project
    # url( r'^rome/',  include('rome_app.urls_app') ),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    # url(r'^admin/', include(admin.site.urls)),
)
