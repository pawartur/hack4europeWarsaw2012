//
//  AWTableViewController.m
//  Europea
//
//  Created by Artur Wdowiarski on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AWTableViewController.h"

@interface AWTableViewController ()

@end

@implementation AWTableViewController

-(CGFloat)heightForCellWithText:(NSString *)text{
    static CGFloat defaultRowHeight = 45.0;
    CGSize maxSize = CGSizeMake(280.0, MAXFLOAT);
    UIFont *font = [UIFont systemFontOfSize:15.0];
    CGSize textSize = [text sizeWithFont:font constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
    return textSize.height > defaultRowHeight ? textSize.height : defaultRowHeight;
}

@end
