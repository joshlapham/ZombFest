//
//  NUSDataStore.m
//  Newcastle Undead Society
//
//  Created by jl on 5/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSDataStore.h"
#import "NUSEvent.h"
#import "NUSSocialLink.h"
#import "NUSNewsItem.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SDWebImagePrefetcher.h"
#import "AFNetworking.h"

@implementation NUSDataStore

#pragma mark - Return values from NSUserDefaults methods

// Check if first data fetch has been completed
+ (BOOL)hasFirstDataFetchHappened
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstDataFetchDidHappen"] == YES) {
        return YES;
    } else {
        return NO;
    }
}

// Check if dataStore is currently fetching data
+ (BOOL)isCurrentlyFetchingZombieJSONDataFile
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isCurrentlyFetchingData"] == YES) {
        DDLogVerbose(@"dataStore is currently fetching zombie JSON data file");
        return YES;
    } else {
        DDLogVerbose(@"dataStore NOT currently fetching anything");
        return NO;
    }
}

// Check if dataStore is currently preloading gallery images
+ (BOOL)isCurrentlyPreloadingGalleryImages
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isCurrentlyPreloadingGalleryImages"] == YES) {
        DDLogVerbose(@"dataStore is currently preloading gallery images");
        return YES;
    } else {
        DDLogVerbose(@"dataStore NOT currently preloading gallery images");
        return NO;
    }
}

// News items
+ (NSArray *)returnNewsItemsFromCache
{
    NSData *newsItemData = [[NSUserDefaults standardUserDefaults] objectForKey:@"newsItemResults"];
    NSArray *arrayToReturn = [NSKeyedUnarchiver unarchiveObjectWithData:newsItemData];
    
    DDLogVerbose(@"Return news items count: %d", [arrayToReturn count]);
    
    return arrayToReturn;
}

// Past events
+ (NSArray *)returnPastEventsFromCache
{
    NSData *pastEventsData = [[NSUserDefaults standardUserDefaults] objectForKey:@"pastEventResults"];
    NSArray *arrayToReturn = [NSKeyedUnarchiver unarchiveObjectWithData:pastEventsData];
    
    DDLogVerbose(@"Return past events count: %d", [arrayToReturn count]);
    
    return arrayToReturn;
}

// Future events
+ (NSArray *)returnFutureEventsFromCache
{
    NSData *futureEventsData = [[NSUserDefaults standardUserDefaults] objectForKey:@"futureEventResults"];
    NSArray *arrayToReturn = [NSKeyedUnarchiver unarchiveObjectWithData:futureEventsData];
    
    DDLogVerbose(@"Return future events count: %d", [arrayToReturn count]);
    
    return arrayToReturn;
}

// Social media links
+ (NSArray *)returnSocialMediaLinksFromCache
{
    NSData *socialMediaLinksData = [[NSUserDefaults standardUserDefaults] objectForKey:@"socialMediaLinksResults"];
    NSArray *arrayToReturn = [NSKeyedUnarchiver unarchiveObjectWithData:socialMediaLinksData];
    
    //DDLogVerbose(@"Return past events count: %d", [arrayToReturn count]);
    
    return arrayToReturn;
}

#pragma mark - Parse fetched Zombie JSON data

+ (void)parseZombieJSONDataFileWithFilePath:(NSString *)pathToJsonDataFile
{
    // Init results arrays
    NSMutableArray *newsItemsResults = [[NSMutableArray alloc] init];
    NSMutableArray *aboutSectionResults = [[NSMutableArray alloc] init];
    NSMutableArray *pastEventsResults = [[NSMutableArray alloc] init];
    NSMutableArray *futureEventsResults = [[NSMutableArray alloc] init];
    NSMutableArray *videoResults = [[NSMutableArray alloc] init];
    NSMutableArray *socialMediaLinksResults = [[NSMutableArray alloc] init];
    
    // Init data source
    NSData *jsonLocalData = [NSData dataWithContentsOfFile:pathToJsonDataFile
                                                   options:NSDataReadingMappedIfSafe
                                                     error:nil];
    
    NSDictionary *jsonLocalDataDict = [NSJSONSerialization JSONObjectWithData:jsonLocalData
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:nil];
    
    // Date that JSON data was last modified
    NSString *fetchedDataLastModified = [NSString stringWithFormat:@"%@", [jsonLocalDataDict objectForKey:@"lastModified"]];
    DDLogVerbose(@"Data was last modified %@", fetchedDataLastModified);
    
    // Past events
    for (NSDictionary *pastEvent in [jsonLocalDataDict objectForKey:@"pastEvents"]) {
        //DDLogVerbose(@"Fetched event: %@", pastEvent);
        
        // Init vars to hold data
        NSString *fetchedEventYear = [NSString stringWithFormat:@"%@", [pastEvent objectForKey:@"year"]];
        NSMutableArray *fetchedEventGalleryUrls = [[NSMutableArray alloc] init];
        
        for (NSString *fetchedGalleryUrl in [pastEvent objectForKey:@"galleryUrls"]) {
            [fetchedEventGalleryUrls addObject:fetchedGalleryUrl];
        }
        
        NUSEvent *fetchedPastEvent = [[NUSEvent alloc] initWithYear:fetchedEventYear
                                                         andContent:[pastEvent objectForKey:@"content"]
                                                        andImageUrl:[pastEvent objectForKey:@"imageUrl"]
                                                andGalleryImageUrls:[NSArray arrayWithArray:fetchedEventGalleryUrls]
                                                           andTimes:nil
                                                     andIsPastEvent:YES];
        
        // Add to results array
        [pastEventsResults addObject:fetchedPastEvent];
    }
    
    // Social media links
    for (NSDictionary *socialLink in [jsonLocalDataDict objectForKey:@"socialMediaLinks"]) {
        //DDLogVerbose(@"%@", socialLink);
        
        NUSSocialLink *fetchedSocialLink = [[NUSSocialLink alloc] initWithTitle:[socialLink objectForKey:@"title"]
                                                                         andUrl:[socialLink objectForKey:@"url"]
                                                                    andImageUrl:[socialLink objectForKey:@"imageUrl"]];
        
        // Add to results array
        [socialMediaLinksResults addObject:fetchedSocialLink];
    }
    
    // Future events
    for (NSDictionary *futureEvent in [jsonLocalDataDict objectForKey:@"futureEvents"]) {
        //DDLogVerbose(@"%@", futureEvent);
        
        // Init vars to hold data
        NSString *fetchedEventYear = [NSString stringWithFormat:@"%@", [futureEvent objectForKey:@"year"]];
        NSMutableArray *fetchedEventTimes = [[NSMutableArray alloc] init];
        
        for (NSDictionary *futureTimes in [futureEvent objectForKey:@"eventTimes"]) {
            //DDLogVerbose(@"%@", futureTimes);
            [fetchedEventTimes addObject:futureTimes];
        }
        
        NUSEvent *fetchedFutureEvent = [[NUSEvent alloc] initWithYear:fetchedEventYear
                                                           andContent:[futureEvent objectForKey:@"content"]
                                                          andImageUrl:[futureEvent objectForKey:@"imageUrl"]
                                                  andGalleryImageUrls:nil
                                                             andTimes:[NSArray arrayWithArray:fetchedEventTimes]
                                                       andIsPastEvent:NO];
        
        [futureEventsResults addObject:fetchedFutureEvent];
    }
    
    // News items
    for (NSDictionary *newsItem in [jsonLocalDataDict objectForKey:@"newsItems"]) {
        NUSNewsItem *fetchedNewsItem = [[NUSNewsItem alloc] initWithId:[newsItem objectForKey:@"id"]
                                                              andTitle:[newsItem objectForKey:@"title"]
                                                            andContent:[newsItem objectForKey:@"content"]
                                                               andDate:[newsItem objectForKey:@"date"]];
        
        [newsItemsResults addObject:fetchedNewsItem];
    }
    
    // Save data arrays to NSUserDefaults
    NSData *pastEventsToSave = [NSKeyedArchiver archivedDataWithRootObject:pastEventsResults];
    [[NSUserDefaults standardUserDefaults] setObject:pastEventsToSave forKey:@"pastEventResults"];
    
    NSData *socialLinksToSave = [NSKeyedArchiver archivedDataWithRootObject:socialMediaLinksResults];
    [[NSUserDefaults standardUserDefaults] setObject:socialLinksToSave forKey:@"socialMediaLinksResults"];
    
    NSData *futureEventsToSave = [NSKeyedArchiver archivedDataWithRootObject:futureEventsResults];
    [[NSUserDefaults standardUserDefaults] setObject:futureEventsToSave forKey:@"futureEventResults"];
    
    NSData *newsItemsToSave = [NSKeyedArchiver archivedDataWithRootObject:newsItemsResults];
    [[NSUserDefaults standardUserDefaults] setObject:newsItemsToSave forKey:@"newsItemResults"];
    
    // Flag that first data fetch has happened
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstDataFetchDidHappen"];
    
    // Sync NSUserDefaults
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Post data fetch did happen NSNotification
    NSString *notificationName = @"NUSDataFetchDidHappen";
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil];
}

#pragma mark - Fetch Zombie JSON data

+ (void)downloadZombieJSONDataFileToDevice
{
    // Set isCurrentlyFetchingData flag in NSUserDefaults
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isCurrentlyFetchingData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Zombie data file URL to download
    NSURL *url = [NSURL URLWithString:@"http://leagueofevil.org/nus/zombie-data.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:[url lastPathComponent]];
    
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:path append:NO]];
    
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        DDLogVerbose(@"bytesRead: %u, totalBytesRead: %lld, totalBytesExpectedToRead: %lld", bytesRead, totalBytesRead, totalBytesExpectedToRead);
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        DDLogVerbose(@"dataStore: %@", [[[operation response] allHeaderFields] description]);
        
        NSError *error;
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:&error];
        
        if (error) {
            DDLogVerbose(@"dataStore: %@", [error description]);
        } else {
            DDLogVerbose(@"%@", fileAttributes);
            
            // Set isCurrentlyFetchingData flag in NSUserDefaults
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isCurrentlyFetchingData"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            // Parse the data that was just downloaded to device
            [self parseZombieJSONDataFileWithFilePath:path];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DDLogVerbose(@"dataStore: %@", [error description]);
    }];
    
    [operation start];
}

#pragma mark - Return filepaths for Zombie JSON data files

+ (NSString *)returnPathToLocalZombieJSONDataFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *localJsonDataFilePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"zombie-data.json"];
    
    return localJsonDataFilePath;
}

+ (NSString *)returnPathToLocalZombieJSONDataFileIncludedOnDevice
{
    NSString *jsonLocalUrl = [[NSBundle mainBundle] pathForResource:@"zombie-data" ofType:@"json"];
    
    return jsonLocalUrl;
}

#pragma mark - Preload gallery images

+ (void)preloadGalleryImagesForAllEvents
{
    // Set isCurrentlyPreloadingGalleryImages flag in NSUserDefaults
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isCurrentlyPreloadingGalleryImages"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSArray *resultsArray = [NSArray arrayWithArray:[NUSDataStore returnPastEventsFromCache]];
    
    NSMutableArray *prefetchUrls = [[NSMutableArray alloc] init];
    
    for (NUSEvent *eventItem in resultsArray) {
        
        // Gallery image URLs
        for (NSString *urlToPreload in eventItem.eventGalleryImageUrls) {
            NSString *urlString = urlToPreload;
            NSURL *urlToPrefetch = [NSURL URLWithString:urlString];
            [prefetchUrls addObject:urlToPrefetch];
        }
        
        // Event image URL
        NSURL *eventImageUrl = [NSURL URLWithString:eventItem.eventImageUrl];
        [prefetchUrls addObject:eventImageUrl];
    }
    
    // Cache URL with SDWebImage
    [[SDWebImagePrefetcher sharedImagePrefetcher] prefetchURLs:prefetchUrls
                                                      progress:nil
                                                     completed:^(NSUInteger finishedCount, NSUInteger skippedCount) {
                                                         DDLogVerbose(@"Prefetched images count: %d, skipped: %d", finishedCount, skippedCount);
                                                         
                                                         // Set isCurrentlyPreloadingGalleryImages flag in NSUserDefaults
                                                         [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isCurrentlyPreloadingGalleryImages"];
                                                         [[NSUserDefaults standardUserDefaults] synchronize];
    }];
}

#pragma mark - Init method

+ (instancetype)sharedStore
{
    static NUSDataStore *_sharedStore = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedStore = [[NUSDataStore alloc] init];
    });
    
    DDLogVerbose(@"Init NUSDataStore");
    
    return _sharedStore;
}

@end
