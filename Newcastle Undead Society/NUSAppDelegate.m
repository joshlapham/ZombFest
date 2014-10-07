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
    [[UINavigationBar appearance] setBarTintColor:[UIColor navbarColour]];
    
    // Navbar shadow
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    
    // Set navbar font colour to white; set font and apply shadow
    UIFont *navbarFont = [UIFont navbarFont];
    NSDictionary *titleAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, navbarFont, NSFontAttributeName, nil];
    [[UINavigationBar appearance] setTitleTextAttributes:titleAttributes];
    
    // Set navbar items to white
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    // Change status bar text to white
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // Set navbar items of UIActivityViews to white
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTintColor:[UIColor whiteColor]];
    
    // Set navbar button font
    NSDictionary *navbarButtonTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont navbarButtonFont]};
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:navbarButtonTextAttributes forState:UIControlStateNormal];
}

#pragma mark - Reachability NSNotification method

- (void)reachabilityDidChange
{
    if ([JPLReachabilityManager isReachable]) {
        DDLogVerbose(@"Network reachability did change, and the network is available");
        
        // Preload all gallery images
        [self preloadAllGalleryImages];
        
        // Refresh data
        if ([NUSDataStore isCurrentlyFetchingZombieJSONDataFile] == NO) {
            [NUSDataStore downloadZombieJSONDataFileToDevice];
        }
        
    } else if ([JPLReachabilityManager isUnreachable]) {
        DDLogVerbose(@"Network reachability did change, and no network is available");
    }
}

#pragma mark - Preload all gallery images method

- (void)preloadAllGalleryImages
{
    DDLogVerbose(@"%s", __FUNCTION__);
    
    // Preload all gallery images if on WiFi
    if ([JPLReachabilityManager isReachableViaWiFi]) {
        [NUSDataStore preloadGalleryImagesForAllEvents];
    } else {
        DDLogVerbose(@"Not on WiFi, so not preloading all gallery images");
    }
}

#pragma mark - Fetch data method

- (void)fetchZombieData
{
    // Check if this is first load, if so then use data file included with app instead
    if ([NUSDataStore hasFirstDataFetchHappened] == YES) {
        DDLogVerbose(@"First data fetch has happened");
        
        // Download new copy of data file
        if ([JPLReachabilityManager isReachable]) {
            
            if ([NUSDataStore isCurrentlyFetchingZombieJSONDataFile] == NO) {
                [NUSDataStore downloadZombieJSONDataFileToDevice];
            }
            
            // Preload all gallery images
            if ([NUSDataStore isCurrentlyPreloadingGalleryImages] == NO) {
                [self preloadAllGalleryImages];
            }
            
        } else if ([JPLReachabilityManager isUnreachable]) {
            
            // No network is available, and first data fetch has happened,
            // so check that a JSON file has been downloaded to the device
            // and use that for the data
            if ([NUSDataStore returnPathToLocalZombieJSONDataFile]) {
                DDLogVerbose(@"dataStore: found downloaded JSON file at path: %@", [NUSDataStore returnPathToLocalZombieJSONDataFile]);
                
                // Parse JSON file
                [NUSDataStore parseZombieJSONDataFileWithFilePath:[NUSDataStore returnPathToLocalZombieJSONDataFile]];
            }
            
            // TODO: post notification that data load has happened? Maybe?
        }
        
    } else {
        DDLogVerbose(@" First data fetch has NOT happened, using local data file");
        // Is first load, use local data file
        [NUSDataStore parseZombieJSONDataFileWithFilePath:[NUSDataStore returnPathToLocalZombieJSONDataFileIncludedOnDevice]];
        
        // Preload all gallery images
        if ([NUSDataStore isCurrentlyPreloadingGalleryImages] == NO) {
            [self preloadAllGalleryImages];
        }
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
    
    // Fetch data
    [self fetchZombieData];
    
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
