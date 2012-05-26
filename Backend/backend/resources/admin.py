from django.contrib import admin

from backend.resources.models import (
    Venue,
    Resource,
)


admin.site.register(Venue)
admin.site.register(Resource)