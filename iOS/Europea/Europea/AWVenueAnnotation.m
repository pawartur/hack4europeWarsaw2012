//
//  AWEuropeanaResourceAnnotation.m
//  Europea
//
//  Created by Artur Wdowiarski on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AWVenueAnnotation.h"

@implementation AWVenueAnnotation

@synthesize name = _name;
@synthesize description = _description;
@synthesize coordinate = _coordinate;
@synthesize venue = _venue;

- (id)initWithName:(NSString*)name description:(NSString*)description coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        _name = [name copy];
        _description = [description copy];
        _coordinate = coordinate;
    }
    return self;
}

- (NSString *)title {
    if ([_name isKindOfClass:[NSNull class]]) 
        return @"No title given";
    else
        return _description;
}

@end
