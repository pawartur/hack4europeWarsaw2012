from django.contrib import admin

from backend.ratings.models import (
    Rating,
)


admin.site.register(Rating)