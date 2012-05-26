//
//  AWAnnotationView.h
//  Europea
//
//  Created by Artur Wdowiarski on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "AWVenue.h"

@interface AWAnnotationView : MKPinAnnotationView{
    AWVenue *_resource;
}

@property (nonatomic, strong) AWVenue *venue;

@end
