from django.conf import settings
from django.conf.urls import patterns, include, url
from django.contrib import admin

from tastypie.api import Api

from backend.api import CommentResource
from backend.api import VenueResource
from backend.api import ProfileResource
from backend.api import RatingResource
from backend.api import ResourceResource


v1_api = Api(api_name='v1')
v1_api.register(CommentResource())
v1_api.register(VenueResource())
v1_api.register(ProfileResource())
v1_api.register(RatingResource())
v1_api.register(ResourceResource())

admin.autodiscover()

urlpatterns = patterns('',
    url(r'^api/', include(v1_api.urls)),
    url(r'^admin/', include(admin.site.urls)),
)

if settings.DEBUG:
    urlpatterns += patterns('',
        url(r'^media/(?P<path>.*)$', 'django.views.static.serve', {
            'document_root': settings.MEDIA_ROOT,
        }),
   )