//
//  AWEuropeanaResourceDetailsViewControllerViewController.m
//  Europea
//
//  Created by Artur Wdowiarski on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AWVenueDetailsViewController.h"
#import "AWResourceDetailsViewController.h"
#import "AWCommentsViewController.h"
#import "AWComment.h"
#import "AWResource.h"
#import <RestKit/RestKit.h>
#import "MBProgressHUD.h"
#import "AWTableViewCell.h"

@interface AWVenueDetailsViewController ()

@end

@implementation AWVenueDetailsViewController

@synthesize venue = _venue, comments = _comments, resources = _resources;

#pragma mark Custom Methods

-(void)downloadComments{
    RKObjectManager* objectManager = [RKObjectManager sharedManager];
    NSString *resourcePath= [NSString stringWithFormat:@"/venue/%@/comments/?format=json", self.venue.idString];
    [objectManager loadObjectsAtResourcePath:resourcePath delegate:self];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading comments...";
}

# pragma mark RKObjectLoaderDelegate Methods

-(void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response{
    return;
}

-(void)request:(RKRequest *)request didFailLoadWithError:(NSError *)error{
    NSLog(@"Request failed due to error %@", error);
}

-(void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects{
    self.comments = objects;
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
    hud.labelText = @"Done!";
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self performSegueWithIdentifier:@"showComments" sender:self];
}

-(void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error{
    NSLog(@"Unable to load Europeana resources due to error %@", error);
}


# pragma mark TableViewController Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // 1: Name
    // 2: Ratings and comments
    // 3: Eesources
    return 3;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"Name";
        case 1:
            return @"Opinions";
        case 2:
            return @"What you can see here";
        default:
            return nil;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 2;
        case 2:
            return [self.venue.resources count];
        default:
            return 0;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 1:
            if (indexPath.row == 1) {
                [self downloadComments];
            }
            break;
        case 2:
            _selectedResource = [self.venue.resources objectAtIndex:indexPath.row];
            [self performSegueWithIdentifier:@"showEuropeanaSubesourceDetails" sender:self];
            break;
        default:
            break;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showComments"]) {
        AWCommentsViewController *next = segue.destinationViewController;
        next.venue = self.venue;
        next.comments = self.comments;
    }
    if ([segue.identifier isEqualToString:@"showEuropeanaSubesourceDetails"]) {
        AWResourceDetailsViewController *next = segue.destinationViewController;
        next.resource = _selectedResource;
        _selectedResource = nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return [self heightForCellWithText:self.venue.name];
        case 2:
        {
            AWResource *resource = [self.venue.resources objectAtIndex:indexPath.row];
            CGFloat height = [self heightForCellWithText:resource.title];
            return height;
        }
        default:
            return [super tableView:self.tableView heightForRowAtIndexPath:indexPath];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseIdentifier, *text, *detailText;
    UITableViewCellStyle cellStyle = UITableViewCellStyleDefault;
    AWResource *resource;
    
    switch (indexPath.section) {
        case 0:
            reuseIdentifier = @"nameCell";
            text = self.venue.name;
            break;
        case 1:
            reuseIdentifier = @"socialCell";
            cellStyle = UITableViewCellStyleValue1;
            if (indexPath.row == 0) {
                text = @"Average rating";
                detailText = [NSString stringWithFormat:@"%@", self.venue.rating];
            }else {
                text = @"Comments";
                detailText = self.venue.comments_no.intValue == 1 ?  @"1 comment" : [NSString stringWithFormat:@"%@ comments", self.venue.comments_no];
            }
            break;
        case 2:
            reuseIdentifier = @"subresourceCell";
            resource = [self.venue.resources objectAtIndex:indexPath.row];
            text = resource.title;
            break;
        default:
            reuseIdentifier = @"unknownCell";
            break;
    }
    
    AWTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[AWTableViewCell alloc] initWithStyle:cellStyle reuseIdentifier:reuseIdentifier];
    }
    cell.textLabel.text = text;
    cell.detailTextLabel.text = detailText;
    if (indexPath.section == 0 || (indexPath.section == 1 && indexPath.row == 0)) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

@end
