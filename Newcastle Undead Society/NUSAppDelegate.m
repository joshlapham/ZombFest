//
//  NUSAppDelegate.m
//  Newcastle Undead Society
//
//  Created by jl on 11/03/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSAppDelegate.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "Reachability.h"
#import "Stores/JPLReachabilityManager.h"
#import "Stores/NUSDataStore.h"

@implementation NUSAppDelegate

#pragma mark - Setup UI method

- (void)setupUI
{
    // Show status bar after app launch image has shown
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    // Set navbar colour
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.29 green:0.29 blue:0.29 alpha:1]];
    
    // Set navbar font
    //NSShadow *shadow = [[NSShadow alloc] init];
    //shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    //shadow.shadowOffset = CGSizeMake(0, 1);
    //NSDictionary *titleAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName, shadow, NSShadowAttributeName, [UIFont fontWithName:@"JohnRoderickPaine" size:21.0], NSFontAttributeName, nil];
    //[[UINavigationBar appearance] setTitleTextAttributes:titleAttributes];
    
    // Set navbar font colour to red
    //NSDictionary *titleAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.46 green:0.19 blue:0.18 alpha:1], NSForegroundColorAttributeName, nil];
    //[[UINavigationBar appearance] setTitleTextAttributes:titleAttributes];
    
    // Set navbar font colour to white
    NSDictionary *titleAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [[UINavigationBar appearance] setTitleTextAttributes:titleAttributes];
    
    // Set navbar items to white
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    // Change status bar text to white
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // Set navbar items of UIActivityViews to white
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTintColor:[UIColor whiteColor]];
}

#pragma mark - Reachability NSNotification method

- (void)reachabilityDidChange
{
    if ([JPLReachabilityManager isReachable]) {
        DDLogVerbose(@"Network reachability did change, and the network is available");
    } else if ([JPLReachabilityManager isUnreachable]) {
        DDLogVerbose(@"Network reachability did change, and no network is available");
    }
}

#pragma mark - App Delegate methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Setup UI
    [self setupUI];
    
    // CocoaLumberjack
    // Setup XCode console logger
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    // Init dataStore
    [NUSDataStore sharedStore];
    
    // Init reachability
    [JPLReachabilityManager sharedManager];
    
    if ([JPLReachabilityManager isReachable]) {
        DDLogVerbose(@"Network is available");
    } else if ([JPLReachabilityManager isUnreachable]) {
        DDLogVerbose(@"No network is available");
    }
    
    // Register for reachability NSNotification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityDidChange)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
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
