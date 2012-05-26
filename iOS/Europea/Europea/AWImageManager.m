//
//  AWImageManager.m
//  Europea
//
//  Created by Artur Wdowiarski on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AWImageManager.h"

@implementation AWImageManager

@synthesize delegate = _delegate;
@synthesize stylesDictionary = _stylesDict;

+(AWImageManager *)sharedManager{
    static dispatch_once_t onceToken;
    static AWImageManager *sharedImageManager = nil;
    dispatch_once(&onceToken, ^{
        sharedImageManager = [[AWImageManager alloc] init];
    });
    return sharedImageManager;
}

-(id)init{
    AWImageManager *manager = [super init];
    
    // Make sure the cache directory exists;
    [[NSFileManager defaultManager] createDirectoryAtPath:[manager getCacheDirectoryPath] withIntermediateDirectories:NO attributes:nil error:nil];
    
    // Load the plist with styles' attributes
    NSString *path = [[NSBundle mainBundle] pathForResource:@"UIImageStyles" ofType:@"plist"];
    _stylesDict = [NSDictionary dictionaryWithContentsOfFile:path];
    return manager;
}

-(void)imageFromPath:(NSString *)path withStyle:(UIImageStyle)style delegate:(id <AWImageManagerDelegate>)aDelegate callback:(void (^)(UIImage *returned))callback{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CGSize size = [self getImageSizeForStyle: style];
        NSString *cachedImagePath = [self getPathForImageWithPath:path forSize:size];
        UIImage *image = [self getOrSaveImageWithSize:size withPath:path toPath:cachedImagePath];
        if (callback){
            callback(image);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (aDelegate) {
                [aDelegate imageManager:self gotImage:image fromPath:path withSize:size];
            }else{
                [self.delegate imageManager:self gotImage:image fromPath:path withSize:size];
            }
        });
    });
}

-(NSDictionary *)getAttributesOfStyle:(UIImageStyle)style{
    NSString *styleName;
    switch (style) {
        case UIImageSizePictureDetails:
            styleName = @"UIImageSizePictureDetails";
            break;
        case UIImageSizeListThumbnail:
            styleName = @"UIImageSizeListThumbnail";
            break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected UIImageStyle."];
            break;
    }
    NSDictionary *styleAttrsDict = [_stylesDict objectForKey:styleName];
    return styleAttrsDict;
}

-(CGSize)getImageSizeForStyle:(UIImageStyle)style{
    NSDictionary *styleAttrsDict = [self getAttributesOfStyle:style];
    NSNumber *width = [styleAttrsDict objectForKey:@"width"];
    NSNumber *height = [styleAttrsDict objectForKey:@"height"];
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] == YES && [[UIScreen mainScreen] scale] == 2.00) {
        width = [NSNumber numberWithFloat:([width floatValue] * 2)];
        height = [NSNumber numberWithFloat:([height floatValue] * 2)];
    }
    return CGSizeMake([width floatValue], [height floatValue]);
}

-(NSString *)getCacheDirectoryPath{
    NSString *cacheSubDirName = @"image_cache";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    return [NSString stringWithFormat:@"%@/%@", cachesDirectory, cacheSubDirName];
}

-(NSString *)getPathForImageWithPath:(NSString *)path forSize:(CGSize)size{
    NSString *originalImageName = [[path componentsSeparatedByString:@"/"] lastObject];
    NSString *cachedImageName = [NSString stringWithFormat:@"%@_%f_%f.png", originalImageName, size.width, size.height];
    NSString *cacheDirPath = [self getCacheDirectoryPath];
    NSString *cachedImagePath = [NSString stringWithFormat:@"%@/%@", cacheDirPath, cachedImageName];
    return cachedImagePath;
}

-(UIImage *)getOrSaveImageWithSize:(CGSize)size withPath:(NSString *)originalPath toPath:(NSString *)path{
    NSData *imageData = [NSData dataWithContentsOfFile:path];
    UIImage *image;
    if (!imageData) {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:originalPath]];
        image = [UIImage imageWithData:data];
        
        UIGraphicsBeginImageContext(size);
        [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
        image = UIGraphicsGetImageFromCurrentImageContext(); 
        UIGraphicsEndImageContext();
        
        [self writeImage:image toPath:path];
    }else{
        image = [UIImage imageWithData:imageData];
    }
    return image;
}

-(void)writeImage:(UIImage *)image toPath:(NSString *)path{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSData *pngData = [NSData dataWithData:UIImagePNGRepresentation(image)];
        NSError *error = nil;
        [pngData writeToFile:path options:NSDataWritingAtomic error:&error];
    });
}

-(void)clearCache{
    NSString *cacheDirPath = [self getCacheDirectoryPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *dirEnum = [fileManager enumeratorAtPath:cacheDirPath];
    NSString *file;
    while (file = [dirEnum nextObject]) {
        [fileManager removeItemAtPath:file error:nil];
    }
}

@end
