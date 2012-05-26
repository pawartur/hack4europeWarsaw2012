//
//  AWMapViewControllerViewController.h
//  Europea
//
//  Created by Artur Wdowiarski on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <RestKit/RestKit.h>
#import "AWVenue.h"

#define METERS_PER_MILE 1609.344

@interface AWMapViewController : UIViewController<MKMapViewDelegate, RKObjectLoaderDelegate>{
    AWVenue *_chosenVenue;
    BOOL _showedInitialLocation;
}

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSArray *venues;

-(IBAction)refreshClicked:(UIBarButtonItem *)sender;
-(IBAction)zoomClicked:(UIBarButtonItem *)sender;
-(void)loadVenues;
-(void)loadResources;
-(void)prepareAnnotations;
-(void)zoomToUsersLocation;
@end
