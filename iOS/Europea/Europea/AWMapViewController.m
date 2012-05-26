    //
//  AWMapViewControllerViewController.m
//  Europea
//
//  Created by Artur Wdowiarski on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MBProgressHUD.h"
#import "AWMapViewController.h"
#import "AWVenueDetailsViewController.h"
#import "AWVenue.h"
#import "AWVenueAnnotation.h"
#import "AWAnnotationView.h"

@interface AWMapViewController ()

@end

@implementation AWMapViewController
@synthesize mapView = _mapView;
@synthesize venues = _venues;

#pragma mark AW Methods

-(void)zoomToUsersLocation{
    //CLLocationCoordinate2D location = [[[self.mapView userLocation] location] coordinate];
    CLLocationCoordinate2D location;
    // Somewhere in Warsaw, Poland
    location.latitude = 52.2;
    location.longitude = 21.0;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location, 4*METERS_PER_MILE, 4*METERS_PER_MILE);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    [self.mapView setRegion:adjustedRegion animated:YES];
}

-(void)loadVenues{
    RKObjectManager* objectManager = [RKObjectManager sharedManager];
    [objectManager loadObjectsAtResourcePath:@"/venue/?format=json/" delegate:self];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading data...";
}

-(void)loadResources{
    RKObjectManager* objectManager = [RKObjectManager sharedManager];
    NSString *resourcePath = [NSString stringWithFormat:@"/venue/%@/resources/?format=json/", _chosenVenue.idString];
    [objectManager loadObjectsAtResourcePath:resourcePath delegate:self];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading data...";
}

-(void)prepareAnnotations{
    for (id<MKAnnotation> annotation in _mapView.annotations) {
        [_mapView removeAnnotation:annotation];
    }
    
    for (AWVenue *venue in self.venues) {
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = venue.latitude.doubleValue;            
        coordinate.longitude = venue.longitude.doubleValue;            
        AWVenueAnnotation *annotation = [[AWVenueAnnotation alloc] initWithName:venue.idString description:venue.name coordinate:coordinate];
        annotation.venue = venue;
        [_mapView addAnnotation:annotation];    
    }

}

#pragma mark RKObjectLoaderDelegate Methods
-(void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects{
    if (_chosenVenue) {
        _chosenVenue.resources = objects;
        [self performSegueWithIdentifier:@"showEuropeanaResourceDetails" sender:self];
    }else {
        self.venues = objects;
        [self prepareAnnotations];
    }
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
    hud.labelText = @"Done!";
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error{
    NSLog(@"Unable to load Europeana resources due to error %@", error);
}

#pragma mark MKMapViewDelegate Methods

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    _chosenVenue = ((AWAnnotationView *)view).venue;
    [self loadResources];
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    if (!_showedInitialLocation) {
        [self zoomToUsersLocation];
        [self loadVenues];
    }
    _showedInitialLocation = YES;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"EuropeanaResource";
    
    if ([annotation isKindOfClass:[AWVenueAnnotation class]]) {
        AWAnnotationView *annotationView = (AWAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[AWAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.venue = ((AWVenueAnnotation *)annotation).venue;
        
        UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.rightCalloutAccessoryView = infoButton;
       
        return annotationView;
    }
    return nil;    
}

#pragma mark IBActions handlers

-(void)refreshClicked:(UIBarButtonItem *)sender{
    [self loadVenues];
}

- (IBAction)zoomClicked:(UIBarButtonItem *)sender {
    [self zoomToUsersLocation];
}

#pragma mark UIViewController Methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showEuropeanaResourceDetails"]) {
        AWVenueDetailsViewController *next = segue.destinationViewController;
        next.venue = _chosenVenue;
        _chosenVenue = nil;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
}

@end
