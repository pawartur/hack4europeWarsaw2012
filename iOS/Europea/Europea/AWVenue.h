//
//  AWVenue.h
//  Europea
//
//  Created by Artur Wdowiarski on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AWVenue : NSObject

@property (nonatomic, strong) NSString *idString;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *comments_no;
@property (nonatomic, strong) NSNumber *rating;

@property (nonatomic, strong) NSArray *resources;

@end
