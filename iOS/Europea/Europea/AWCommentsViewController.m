//
//  AWCommentsViewController.m
//  Europea
//
//  Created by Artur Wdowiarski on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AWCommentsViewController.h"
#import "AWComment.h"
#import "AWTableViewCell.h"

@interface AWCommentsViewController ()

@end

@implementation AWCommentsViewController

@synthesize venue = _venue, comments = _comments;


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.comments count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AWComment *comment = [self.comments objectAtIndex:indexPath.row];
    return [self heightForCellWithText:comment.comment] + [self heightForCellWithText:comment.author];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"CommentCell";
    AWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
        cell = [[AWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    
    AWComment *comment = [self.comments objectAtIndex:indexPath.row];
    
    cell.textLabel.text = comment.comment;
    cell.detailTextLabel.text = comment.author;
    
    return cell;
}

- (IBAction)add:(UIBarButtonItem *)sender {
}
@end
