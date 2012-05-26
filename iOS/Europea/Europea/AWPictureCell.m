//
//  AWPictureCell.m
//  Europea
//
//  Created by Artur Wdowiarski on 5/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AWPictureCell.h"
#import "AWImageManager.h"

@implementation AWPictureCell

-(void)displayResizedImageFromPath:(NSString *)path{
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"configuration" ofType:@"plist"];
    NSDictionary *configuration = [NSDictionary dictionaryWithContentsOfFile:configPath];
    path = [NSString stringWithFormat:@"%@%@", [configuration objectForKey:@"baseURL"], path];
    AWImageManager *imageManager = [AWImageManager sharedManager];
    [imageManager imageFromPath:path withStyle:UIImageSizePictureDetails delegate:nil callback:^(UIImage *image){
        self.imageView.image = image;
    }];
}

@end
