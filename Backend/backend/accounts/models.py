from django.db import models


class Profile(models.Model):
    
    id = models.CharField(max_length=100, primary_key=True)
    
    def __unicode__(self):
        return self.id