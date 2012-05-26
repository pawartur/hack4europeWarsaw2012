//
//  AWVenueDetailsViewController.h
//  Europea
//
//  Created by Artur Wdowiarski on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AWTableViewController.h"
#import "AWVenue.h"
#import "AWResource.h"
#import <RestKit/RestKit.h>

@interface AWVenueDetailsViewController : AWTableViewController <RKObjectLoaderDelegate>{
    AWVenue *_resource;
    AWResource *_selectedResource;
}

@property (nonatomic, strong) AWVenue *venue;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, strong) NSArray *resources;

-(void)downloadComments;

@end
