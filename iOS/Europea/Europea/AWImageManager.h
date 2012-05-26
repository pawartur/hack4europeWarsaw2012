//
//  AWImageManager.h
//  Europea
//
//  Created by Artur Wdowiarski on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AWImageManagerDelegate.h"

typedef enum {
    UIImageSizePictureDetails,
    UIImageSizeListThumbnail,
} UIImageStyle;

@interface AWImageManager : NSObject

@property(nonatomic, weak) id delegate;
@property(nonatomic, strong) NSDictionary *stylesDictionary;

+(AWImageManager *) sharedManager;

-(void)imageFromPath:(NSString *)path withStyle:(UIImageStyle)style delegate:(id <AWImageManagerDelegate>)delegate callback:(void (^)(UIImage *returned))callback;
-(NSDictionary *) getAttributesOfStyle: (UIImageStyle)style;
-(CGSize) getImageSizeForStyle: (UIImageStyle)style;
-(NSString *)getPathForImageWithPath:(NSString *)path forSize:(CGSize)size;
-(NSString *)getCacheDirectoryPath;
-(UIImage *)getOrSaveImageWithSize:(CGSize)size withPath:(NSString *)urlPath toPath:(NSString *)path;
-(void)writeImage:(UIImage *)image toPath:(NSString *)path;
-(void)clearCache;

@end
