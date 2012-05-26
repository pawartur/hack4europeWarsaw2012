//
//  AWCommentsViewController.h
//  Europea
//
//  Created by Artur Wdowiarski on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AWVenue.h"
#import "AWTableViewController.h"

@interface AWCommentsViewController : AWTableViewController

@property (nonatomic, strong) AWVenue *venue;
@property (nonatomic, strong) NSArray *comments;

- (IBAction)add:(UIBarButtonItem *)sender;

@end
