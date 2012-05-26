//
//  AWObjectMappingManager.m
//  Europea
//
//  Created by Artur Wdowiarski on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AWObjectMappingManager.h"
#import "AWVenue.h"
#import "AWResource.h"
#import "AWComment.h"

@implementation AWObjectMappingManager

@synthesize 
    venueMapping = _venueMapping,
    resourceMapping = _resourceMapping,
    commentMapping = _commentMapping;

+(AWObjectMappingManager *)sharedManager{
    static dispatch_once_t onceToken;
    static AWObjectMappingManager *sharedObjectMappingManager = nil;
    dispatch_once(&onceToken, ^{
        sharedObjectMappingManager = [[AWObjectMappingManager alloc] init];
    });
    return sharedObjectMappingManager;
}

-(RKObjectMapping *)venueMapping{
    if (_venueMapping) {
        return _venueMapping;
    }
    _venueMapping = [RKObjectMapping mappingForClass:[AWVenue class]];
    [_venueMapping mapKeyPath:@"id" toAttribute:@"idString"];
    [_venueMapping mapKeyPath:@"name" toAttribute:@"name"];
    [_venueMapping mapKeyPath:@"latitude" toAttribute:@"latitude"];
    [_venueMapping mapKeyPath:@"longitude" toAttribute:@"longitude"];
    [_venueMapping mapKeyPath:@"comments_no" toAttribute:@"comments_no"];
    [_venueMapping mapKeyPath:@"rating" toAttribute:@"rating"];
    
    return _venueMapping;
}

-(RKObjectMapping *)resourceMapping{
    if (_resourceMapping) {
        return _resourceMapping;
    }
    _resourceMapping = [RKObjectMapping mappingForClass:[AWResource class]];
    [_resourceMapping mapKeyPath:@"id" toAttribute:@"idString"];
    [_resourceMapping mapKeyPath:@"author" toAttribute:@"author"];
    [_resourceMapping mapKeyPath:@"resource_uri" toAttribute:@"uri"];
    [_resourceMapping mapKeyPath:@"title" toAttribute:@"title"];
    [_resourceMapping mapKeyPath:@"image" toAttribute:@"imageUri"];
    [_resourceMapping mapKeyPath:@"description" toAttribute:@"description"];
    [_resourceMapping mapKeyPath:@"venue" toAttribute:@"venueIdString"];
    
    return _resourceMapping;
}

-commentMapping{
    if (_commentMapping) {
        return _commentMapping;
    }
    _commentMapping = [RKObjectMapping mappingForClass:[AWComment class]];
    [_commentMapping mapKeyPath:@"id" toAttribute:@"idString"];
    [_commentMapping mapKeyPath:@"venue" toAttribute:@"venueIdString"];
    [_commentMapping mapKeyPath:@"author" toAttribute:@"author"];
    [_commentMapping mapKeyPath:@"comment" toAttribute:@"comment"];
    return _commentMapping;
}

-(RKObjectMapping *)objectMappingForData:(id)data{
    if ([data objectForKey:@"comments_no"]) {
        return self.venueMapping;
    }
    if ([data objectForKey:@"comment"]) {
        return self.commentMapping;
    }
    if ([data objectForKey:@"venue"]) {
        return self.resourceMapping;
    }
    return nil;
}

@end
