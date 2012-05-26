//
//  AWResourceDetailsViewController.h
//  Europea
//
//  Created by Artur Wdowiarski on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AWResource.h"
#import "AWTableViewController.h"

@interface AWResourceDetailsViewController : AWTableViewController

@property (nonatomic, strong) AWResource *resource;

@end
