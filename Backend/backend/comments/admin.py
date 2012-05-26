from django.contrib import admin

from backend.comments.models import (
    Comment,
)


admin.site.register(Comment)