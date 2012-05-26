//
//  AWImageManagerDelegate.h
//  Europea
//
//  Created by Artur Wdowiarski on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AWImageManager;

@protocol AWImageManagerDelegate <NSObject>

@optional
-(void)imageManager:(AWImageManager *)sender gotImage:(UIImage *)image fromPath:(NSString *)path withSize:(CGSize)size;
-(void)imageManager:(AWImageManager *)sender gotResizedImage:(UIImage *)resizedImage withSize:(CGSize)size fromImage:(UIImage *)image;

@end
