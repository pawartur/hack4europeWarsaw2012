//
//  AWEuropeanaSubresourceDetailsViewControllerViewController.m
//  Europea
//
//  Created by Artur Wdowiarski on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AWResourceDetailsViewController.h"
#import "AWPictureCell.h"
#import "AWTableViewCell.h"

@interface AWResourceDetailsViewController ()

@end

@implementation AWResourceDetailsViewController

@synthesize resource = _resource;


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 1: author
    // 2: title
    // 3: image
    // 4: description
    return 4;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"Title";
        case 1:
            return @"Author";
        case 2:
            return @"Picture";
        case 3:
            return @"Description";
        default:
            return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return [self heightForCellWithText:self.resource.title];
        case 1:
            return [self heightForCellWithText:self.resource.author];
        case 2:
            return 209;
        case 3:
            return [self heightForCellWithText:self.resource.description];
        default:
            return [super tableView:tableView heightForRowAtIndexPath:indexPath];
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier, *text, *detailText;
    UITableViewCellStyle cellStyle = UITableViewCellStyleDefault;
    
    switch (indexPath.section) {
        case 0:
            reuseIdentifier = @"titleCell";
            text = self.resource.title;
            break;
        case 1:
            reuseIdentifier = @"authorCell";
            text = self.resource.author;
            break;
        case 2:
        {
            reuseIdentifier = @"pictureCell";
            AWPictureCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
            if (cell == nil) {
                cell = [[AWPictureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
            }
            [cell displayResizedImageFromPath:self.resource.imageUri];
            return cell;
        }
        case 3:
            reuseIdentifier = @"descriptionCell";
            text = self.resource.description;
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
    [cell.textLabel sizeToFit];
    cell.detailTextLabel.text = detailText;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
