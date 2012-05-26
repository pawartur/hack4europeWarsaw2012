from django.db import models

from backend.accounts.models import Profile
from backend.resources.models import Venue


class Rating(models.Model):
    
    profile = models.ForeignKey(Profile, related_name='ratings')
    venue = models.ForeignKey(Venue, related_name='ratings')
    rating = models.IntegerField()
    
    def __unicode__(self):
        return self.profile.id