from django.db import models

from django_extensions.db.fields import UUIDField
from backend.accounts.models import Profile
from backend.resources.models import Venue


class Comment(models.Model):

    id = UUIDField(primary_key=True)
    profile = models.ForeignKey(Profile, related_name='comments')
    venue = models.ForeignKey(Venue, related_name='comments')
    comment = models.TextField()
    
    def __unicode__(self):
        return self.profile.id