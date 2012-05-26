//
//  AWAddCommentViewController.h
//  Europea
//
//  Created by Artur Wdowiarski on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AWAddCommentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)done:(UIBarButtonItem *)sender;
- (IBAction)cancel:(UIBarButtonItem *)sender;

@end
