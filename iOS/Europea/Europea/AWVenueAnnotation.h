//
//  AWVenueAnnotation.h
//  Europea
//
//  Created by Artur Wdowiarski on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "AWVenue.h"

@interface AWVenueAnnotation : NSObject <MKAnnotation>{
    NSString *_name;
    NSString *_description;
    CLLocationCoordinate2D _coordinate;
    
    AWVenue *_resource;
}

@property (copy) NSString *name;
@property (copy) NSString *description;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) AWVenue *venue;

- (id)initWithName:(NSString*)name description:(NSString *)description coordinate:(CLLocationCoordinate2D)coordinate;

@end

