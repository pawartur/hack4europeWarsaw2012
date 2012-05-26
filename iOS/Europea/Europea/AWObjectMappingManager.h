//
//  AWObjectMappingManager.h
//  Europea
//
//  Created by Artur Wdowiarski on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>


@interface AWObjectMappingManager : NSObject <RKDynamicObjectMappingDelegate>

@property (nonatomic, strong) RKObjectMapping *venueMapping;
@property (nonatomic, strong) RKObjectMapping *resourceMapping;
@property (nonatomic, strong) RKObjectMapping *commentMapping;

+(AWObjectMappingManager *)sharedManager;

@end
