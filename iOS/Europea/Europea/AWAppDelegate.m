//
//  AWAppDelegate.m
//  Europea
//
//  Created by Artur Wdowiarski on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AWAppDelegate.h"
#import <RestKit/RestKit.h>
#import "AWObjectMappingManager.h"

@implementation AWAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //RKLogConfigureByName("RestKit/Network*", RKLogLevelTrace);
    //RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
    
    // Initialize RestKit
    NSString *path = [[NSBundle mainBundle] pathForResource:@"configuration" ofType:@"plist"];
    NSDictionary *configuration = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *baseURLString = [NSString stringWithFormat:@"%@%@", [configuration objectForKey:@"baseURL"], [configuration objectForKey:@"apiV1Path"]];
    RKObjectManager* objectManager = [RKObjectManager managerWithBaseURLString:baseURLString];
    [RKObjectManager setSharedManager:objectManager];
    
    // Enable automatic network activity indicator management
    objectManager.client.requestQueue.showsNetworkActivityIndicatorWhenBusy = YES;
    
    RKDynamicObjectMapping *dynamicMapping = [RKDynamicObjectMapping dynamicMapping];
    AWObjectMappingManager *objectMappingManager = [AWObjectMappingManager sharedManager];
    dynamicMapping.delegate = objectMappingManager;
    [objectManager.mappingProvider setMapping:dynamicMapping forKeyPath:@"objects"];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
