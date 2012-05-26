//
//  AWResource.h
//  Europea
//
//  Created by Artur Wdowiarski on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AWResource : NSObject

@property (nonatomic, strong) NSString *venueIdString;
@property (nonatomic, strong) NSString *idString;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *uri;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageUri;
@property (nonatomic, strong) NSString *description;

@end
