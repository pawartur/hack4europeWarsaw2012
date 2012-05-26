from django.db import models


class Venue(models.Model):
    
    id = models.CharField(max_length=100, primary_key=True)
    name = models.CharField(max_length=100)
    latitude = models.DecimalField(max_digits=8, decimal_places=6)
    longitude = models.DecimalField(max_digits=8, decimal_places=6)
    
    def __unicode__(self):
        return self.name


class Resource(models.Model):
    
    id = models.CharField(max_length=100, primary_key=True)
    venue = models.ForeignKey('resources.Venue', related_name='resources')
    title = models.CharField(max_length=100)
    author = models.CharField(max_length=100)
    description = models.TextField()
    image = models.ImageField(upload_to='images')
    
    def __unicode__(self):
        return self.id