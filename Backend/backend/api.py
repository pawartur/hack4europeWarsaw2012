from django.conf.urls.defaults import *

from tastypie.resources import ModelResource
from tastypie import fields
from tastypie.authorization import Authorization
from tastypie.utils import trailing_slash

from backend.accounts.models import Profile
from backend.resources.models import Venue
from backend.resources.models import Resource
from backend.comments.models import Comment
from backend.ratings.models import Rating


class ProfileResource(ModelResource):
    
    comments = fields.ToManyField('backend.api.CommentResource', 'comments', related_name='profile', null=True)
    ratings = fields.ToManyField('backend.api.RatingResource', 'ratings', related_name='profile', null=True)
    
    class Meta:
        queryset = Profile.objects.all()
        resource_name = 'profile'
        authorization = Authorization()


class VenueResource(ModelResource):
    
    comments = fields.ToManyField('backend.api.CommentResource', 'comments', related_name='venue', null=True)
    ratings = fields.ToManyField('backend.api.RatingResource', 'ratings', related_name='venue', null=True)
    resources = fields.ToManyField('backend.api.ResourceResource', 'resources', related_name='venue', null=True)
    rating = fields.FloatField(readonly=True)    
    comments_no = fields.IntegerField(readonly=True)    
    
    def dehydrate_rating(self, bundle):
        total_score = 0.0
        ratings_no = bundle.obj.ratings.count()
        if not ratings_no:
            return total_score
        for rating in bundle.obj.ratings.all():
            total_score += rating.rating
        return total_score / ratings_no
        
    def dehydrate_comments_no(self, bundle):
        comments_no = bundle.obj.comments.count()
        return comments_no
        
    def override_urls(self):
        return [
            url(r'^(?P<resource_name>%s)/(?P<pk>.+)/comments%s$' % (self._meta.resource_name, trailing_slash()), self.wrap_view('get_comments'), name='api_get_comments'),
            url(r'^(?P<resource_name>%s)/(?P<pk>.+)/resources%s$' % (self._meta.resource_name, trailing_slash()), self.wrap_view('get_resources'), name='api_get_resources'),
        ]

    def get_comments(self, request, **kwargs):
        pk = kwargs.get('pk')
        result_set = Comment.objects.filter(venue=pk)
        
        objects = []

        for result in result_set:
            bundle = self.build_bundle(obj=result, request=request)
            bundle = CommentResource().full_dehydrate(bundle)
            objects.append(bundle)

        object_list = {
            'objects': objects,
        }

        return self.create_response(request, object_list)

    def get_resources(self, request, **kwargs):
        pk = kwargs.get('pk')
        result_set = Resource.objects.filter(venue=pk)
        
        objects = []

        for result in result_set:
            bundle = self.build_bundle(obj=result, request=request)
            bundle = ResourceResource().full_dehydrate(bundle)
            objects.append(bundle)

        object_list = {
            'objects': objects,
        }

        return self.create_response(request, object_list)
        
    class Meta:
        queryset = Venue.objects.all()
        resource_name = 'venue'
        authorization = Authorization()
    

class ResourceResource(ModelResource):
    
    venue = fields.ToOneField(VenueResource, 'venue')

    class Meta:
        queryset = Resource.objects.all()
        resource_name = 'resource'
        authorization = Authorization()
    

class CommentResource(ModelResource):
    
    venue = fields.ToOneField(VenueResource, 'venue')
    profile = fields.ToOneField(ProfileResource, 'profile')
    author = fields.CharField(readonly=True)

    def dehydrate_author(self, bundle):
        return bundle.obj.profile.id
    
    class Meta:
        queryset = Comment.objects.all()
        resource_name = 'comment'
        authorization = Authorization()


class RatingResource(ModelResource):
    
    venue = fields.ToOneField(VenueResource, 'venue')
    profile = fields.ToOneField(ProfileResource, 'profile')
    
    class Meta:
        queryset = Rating.objects.all()
        resource_name = 'rating'
        authorization = Authorization()