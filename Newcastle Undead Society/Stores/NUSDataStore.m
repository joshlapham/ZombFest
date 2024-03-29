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
#import "NUSAboutContent.h"
#import "NUSVideo.h"
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
    NSArray *newsItemsArray = [NSKeyedUnarchiver unarchiveObjectWithData:newsItemData];
    
    // Sort news items by date, with the latest being at the top
    NSSortDescriptor *dateSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:dateSortDescriptor];
    NSArray *sortedArray = [newsItemsArray sortedArrayUsingDescriptors:sortDescriptors];
    
    DDLogVerbose(@"Return news items count, sorted by date: %lu", [sortedArray count]);
    
    return sortedArray;
}

// About section content
+ (NSArray *)returnAboutSectionContent
{
    NSData *aboutSectionData = [[NSUserDefaults standardUserDefaults] objectForKey:@"aboutSectionResults"];
    NSArray *arrayToReturn = [NSKeyedUnarchiver unarchiveObjectWithData:aboutSectionData];
    
    DDLogVerbose(@"Return About section count: %lu", (unsigned long)[arrayToReturn count]);
    
    return arrayToReturn;
}

// Past events
+ (NSArray *)returnPastEventsFromCache
{
    NSData *pastEventsData = [[NSUserDefaults standardUserDefaults] objectForKey:@"pastEventResults"];
    NSArray *arrayToReturn = [NSKeyedUnarchiver unarchiveObjectWithData:pastEventsData];
    
    DDLogVerbose(@"Return past events count: %lu", (unsigned long)[arrayToReturn count]);
    
    // TODO: implement this better using NSSortDescriptor to sort by year,
    // rather than just reversing the array
    NSArray *reversedArray = [[arrayToReturn reverseObjectEnumerator] allObjects];
    
    //return arrayToReturn;
    return reversedArray;
}

// Future events
+ (NSArray *)returnFutureEventsFromCache
{
    NSData *futureEventsData = [[NSUserDefaults standardUserDefaults] objectForKey:@"futureEventResults"];
    NSArray *arrayToReturn = [NSKeyedUnarchiver unarchiveObjectWithData:futureEventsData];
    
    DDLogVerbose(@"Return future events count: %lu", (unsigned long)[arrayToReturn count]);
    
    return arrayToReturn;
}

// Videos
+ (NSArray *)returnAllVideosFromCache
{
    NSData *videoData = [[NSUserDefaults standardUserDefaults] objectForKey:@"videoResults"];
    NSArray *arrayToReturn = [NSKeyedUnarchiver unarchiveObjectWithData:videoData];
    
    DDLogVerbose(@"Return all videos count: %lu", (unsigned long)[arrayToReturn count]);
    
    return arrayToReturn;
}

+ (NSArray *)returnWinningVideosFromCache
{
    NSData *videoData = [[NSUserDefaults standardUserDefaults] objectForKey:@"videoResults"];
    NSArray *allVideos = [NSKeyedUnarchiver unarchiveObjectWithData:videoData];
    
    NSMutableArray *videosArray = [[NSMutableArray alloc] init];
    
    for (NUSVideo *video in allVideos) {
        if (video.isWinner == YES) {
            [videosArray addObject:video];
        }
    }
    
    // Sort videos by year, with the latest being at the top
    NSSortDescriptor *yearSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"year" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:yearSortDescriptor];
    NSArray *sortedArray = [videosArray sortedArrayUsingDescriptors:sortDescriptors];
    
    DDLogVerbose(@"Return winning videos count: %lu, sorted by year", (unsigned long)[sortedArray count]);
    
    return sortedArray;
}

+ (NSArray *)returnEntrantVideosFromCache
{
    NSData *videoData = [[NSUserDefaults standardUserDefaults] objectForKey:@"videoResults"];
    NSArray *allVideos = [NSKeyedUnarchiver unarchiveObjectWithData:videoData];
    
    NSMutableArray *videosArray = [[NSMutableArray alloc] init];
    
    for (NUSVideo *video in allVideos) {
        if (video.isEntrant == YES) {
            [videosArray addObject:video];
        }
    }
    
    // Sort videos by year, with the latest being at the top
    NSSortDescriptor *yearSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"year" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:yearSortDescriptor];
    NSArray *sortedArray = [videosArray sortedArrayUsingDescriptors:sortDescriptors];
    
    DDLogVerbose(@"Return entrant videos count: %lu, sorted by year", (unsigned long)[sortedArray count]);
    
    return sortedArray;
}

+ (NSArray *)returnOtherVideosFromCache
{
    NSData *videoData = [[NSUserDefaults standardUserDefaults] objectForKey:@"videoResults"];
    NSArray *allVideos = [NSKeyedUnarchiver unarchiveObjectWithData:videoData];
    
    NSMutableArray *videosArray = [[NSMutableArray alloc] init];
    
    for (NUSVideo *video in allVideos) {
        if (video.isOther == YES) {
            [videosArray addObject:video];
        }
    }
    
    // Sort videos by year, with the latest being at the top
    NSSortDescriptor *yearSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"year" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:yearSortDescriptor];
    NSArray *sortedArray = [videosArray sortedArrayUsingDescriptors:sortDescriptors];
    
    DDLogVerbose(@"Return other videos count: %lu, sorted by year", (unsigned long)[sortedArray count]);
    
    return sortedArray;
}

+ (NSArray *)returnAllVideosFromCacheForYear:(NSString *)eventYear
{
    NSData *videoData = [[NSUserDefaults standardUserDefaults] objectForKey:@"videoResults"];
    NSArray *allVideos = [NSKeyedUnarchiver unarchiveObjectWithData:videoData];
    
    NSMutableArray *videosArray = [[NSMutableArray alloc] init];
    
    for (NUSVideo *video in allVideos) {
        if ([video.year isEqualToString:eventYear]) {
            [videosArray addObject:video];
        }
    }
    
    // Sort results by winner
    NSSortDescriptor *winnerSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"isWinner" ascending:NO];
    // Additionally, sort results by entrant
    // All this sorting means that 'isOther' videos are at the very bottom
    NSSortDescriptor *entrantSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"isEntrant" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:winnerSortDescriptor, entrantSortDescriptor, nil];
    NSArray *sortedArray = [videosArray sortedArrayUsingDescriptors:sortDescriptors];
    
    DDLogVerbose(@"Return videos for event year %@ count: %lu, sorted by winners and entrants", eventYear, (unsigned long)[sortedArray count]);
    
    return sortedArray;
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
    DDLogVerbose(@"dataStore: parsing fetched JSON data ..");
    
    // Init results arrays
    NSMutableArray *newsItemsResults = [[NSMutableArray alloc] init];
    NSMutableArray *aboutSectionResults = [[NSMutableArray alloc] init];
    NSMutableArray *pastEventsResults = [[NSMutableArray alloc] init];
    NSMutableArray *futureEventsResults = [[NSMutableArray alloc] init];
    NSMutableArray *videoResults = [[NSMutableArray alloc] init];
    NSMutableArray *socialMediaLinksResults = [[NSMutableArray alloc] init];
    NSMutableArray *allArticlesResults = [[NSMutableArray alloc] init];
    
    // Init data source
    NSData *jsonLocalData = [NSData dataWithContentsOfFile:pathToJsonDataFile
                                                   options:NSDataReadingMappedIfSafe
                                                     error:nil];
    
    NSDictionary *jsonLocalDataDict = [NSJSONSerialization JSONObjectWithData:jsonLocalData
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:nil];
    
    // Date that JSON data was last modified
    // TODO: implement this in the back end
    NSString *fetchedDataLastModified = [NSString stringWithFormat:@"%@", [jsonLocalDataDict objectForKey:@"lastModified"]];
    DDLogVerbose(@"Data was last modified %@", fetchedDataLastModified);
    
    // Articles
    for (NSDictionary *fetchedArticle in [jsonLocalDataDict objectForKey:@"articles"]) {
        DDLogVerbose(@"ARTICLE: %@", fetchedArticle);
        [allArticlesResults addObject:fetchedArticle];
    }
    
    DDLogVerbose(@"ALL ARTICLES COUNT: %lu", (unsigned long)[allArticlesResults count]);
    
    // Past events
    for (NSDictionary *pastEvent in [jsonLocalDataDict objectForKey:@"pastEvents"]) {
        //DDLogVerbose(@"Fetched event: %@", pastEvent);
        
        // Init vars to hold data
        NSString *fetchedEventYear = [NSString stringWithFormat:@"%@", [pastEvent objectForKey:@"year"]];
        NSMutableArray *fetchedEventGalleryUrls = [[NSMutableArray alloc] init];
        
        for (NSString *fetchedGalleryUrl in [pastEvent objectForKey:@"galleryUrls"]) {
            [fetchedEventGalleryUrls addObject:fetchedGalleryUrl];
        }
        
        // Articles
        NSMutableArray *tmpArticlesArray = [[NSMutableArray alloc] init];
        // Loop over existing articles to see if any match the year we're currently looping on
        for (NSDictionary *article in allArticlesResults) {
            if ([[article objectForKey:@"year"] isEqualToString:[pastEvent objectForKey:@"year"]]) {
                [tmpArticlesArray addObject:article];
            }
        }
        
        NUSEvent *fetchedPastEvent = [[NUSEvent alloc] initWithYear:fetchedEventYear
                                                            andDate:[pastEvent objectForKey:@"date"]
                                                         andContent:[pastEvent objectForKey:@"content"]
                                                        andImageUrl:[pastEvent objectForKey:@"imageUrl"]
                                                andGalleryImageUrls:[NSArray arrayWithArray:fetchedEventGalleryUrls]
                                                           andTimes:nil
                                                        andArticles:[NSArray arrayWithArray:tmpArticlesArray]
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
        
        // NOTE - we don't need gallery image URLs or articles for future events, so passing nil
        NUSEvent *fetchedFutureEvent = [[NUSEvent alloc] initWithYear:fetchedEventYear
                                                              andDate:[futureEvent objectForKey:@"date"]
                                                           andContent:[futureEvent objectForKey:@"content"]
                                                          andImageUrl:[futureEvent objectForKey:@"imageUrl"]
                                                  andGalleryImageUrls:nil
                                                             andTimes:[NSArray arrayWithArray:fetchedEventTimes]
                                                          andArticles:nil
                                                       andIsPastEvent:NO];
        
        [futureEventsResults addObject:fetchedFutureEvent];
    }
    
    // News items
    for (NSDictionary *newsItem in [jsonLocalDataDict objectForKey:@"newsItems"]) {
        NUSNewsItem *fetchedNewsItem = [[NUSNewsItem alloc] initWithId:[newsItem objectForKey:@"id"]
                                                              andTitle:[newsItem objectForKey:@"title"]
                                                            andContent:[newsItem objectForKey:@"content"]
                                                               andDate:[newsItem objectForKey:@"date"]
                                                                andURL:[newsItem objectForKey:@"url"]];
        
        [newsItemsResults addObject:fetchedNewsItem];
    }
    
    // About section
    for (NSDictionary *aboutContent in [jsonLocalDataDict objectForKey:@"aboutContent"]) {
        
        NUSAboutContent *fetchedAboutContent = [[NUSAboutContent alloc] initWithTitle:[aboutContent objectForKey:@"title"] andContent:[aboutContent objectForKey:@"content"] andImageUrl:[aboutContent objectForKey:@"imageUrl"]];
        
        [aboutSectionResults addObject:fetchedAboutContent];
    }
    
    // Videos
    for (NSDictionary *video in [jsonLocalDataDict objectForKey:@"videos"]) {
        BOOL isWinner;
        BOOL isEntrant;
        BOOL isOther;
        
        //DDLogVerbose(@"WINNER: %@, ENTRANT: %@, OTHER: %@", [video objectForKey:@"isWinner"], [video objectForKey:@"isEntrant"], [video objectForKey:@"isOther"]);
        
        isWinner = [[video objectForKey:@"isWinner"] boolValue];
        isEntrant = [[video objectForKey:@"isEntrant"] boolValue];
        isOther = [[video objectForKey:@"isOther"] boolValue];
        
        NUSVideo *fetchedVideo = [[NUSVideo alloc] initWithId:[video objectForKey:@"id"]
                                                     andTitle:[video objectForKey:@"title"]
                                                    andAuthor:[video objectForKey:@"author"]
                                                      andYear:[video objectForKey:@"year"]
                                                  andDuration:[video objectForKey:@"duration"]
                                                       andUrl:[video objectForKey:@"videoUrl"]
                                                  andThumbUrl:[video objectForKey:@"thumbUrl"]
                                                     isWinner:isWinner
                                                    isEntrant:isEntrant
                                                      isOther:isOther];
        
        [videoResults addObject:fetchedVideo];
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
    
    NSData *aboutContentToSave = [NSKeyedArchiver archivedDataWithRootObject:aboutSectionResults];
    [[NSUserDefaults standardUserDefaults] setObject:aboutContentToSave forKey:@"aboutSectionResults"];
    
    NSData *videosToSave = [NSKeyedArchiver archivedDataWithRootObject:videoResults];
    [[NSUserDefaults standardUserDefaults] setObject:videosToSave forKey:@"videoResults"];
    
    // TODO: review this key name and sync of NSUserDefaults
    // Flag that first data fetch has happened
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstDataFetchDidHappen"];
    
    // Sync NSUserDefaults
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Post NSNotification that data fetch did happen
    [self postNotificationThatDataFetchDidHappen];
}

#pragma mark - Post NSNotification that data fetch did happen method

+ (void)postNotificationThatDataFetchDidHappen
{
    DDLogVerbose(@"dataStore: posting notification that data fetch did happen");
    
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
    // PRODUCTION
    NSURL *url = [NSURL URLWithString:@"http://zombies.leagueofevil.org/api/data.json"];
    // DEVELOPMENT
    //NSURL *url = [NSURL URLWithString:@"http://192.168.1.15:3000/api/data.json"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // Path to downloaded JSON file
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:[url lastPathComponent]];
    
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:path append:NO]];
    
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        DDLogVerbose(@"bytesRead: %lu, totalBytesRead: %lld, totalBytesExpectedToRead: %lld", (unsigned long)bytesRead, totalBytesRead, totalBytesExpectedToRead);
    }];
    
    // Set completion block for download operation
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        DDLogVerbose(@"dataStore: %@", [[[operation response] allHeaderFields] description]);
        
        NSError *error;
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:&error];
        
        if (error) {
            
            // Download was NOT successful
            
            DDLogError(@"dataStore: %@", [error description]);
            
            // Hide network activity indicator
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        } else {
            
            // Download was successful
            
            DDLogVerbose(@"%@", fileAttributes);
            
            // Set isCurrentlyFetchingData flag in NSUserDefaults
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isCurrentlyFetchingData"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            // Hide network activity indicator
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            DDLogVerbose(@"dataStore: finished fetching JSON data, now parsing ..");
            
            // Parse the data that was just downloaded to device
            [self parseZombieJSONDataFileWithFilePath:path];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DDLogError(@"dataStore: %@", [error description]);
        
        // Hide network activity indicator
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
    
    // Show network activity indicator
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // Start the download
    [operation start];
}

#pragma mark - Return filepaths for Zombie JSON data files

+ (NSString *)returnPathToLocalZombieJSONDataFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *localJsonDataFilePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"data.json"];
    
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
    
    // Show network activity indicator
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // Cache URL with SDWebImage
    [[SDWebImagePrefetcher sharedImagePrefetcher] prefetchURLs:prefetchUrls
                                                      progress:nil
                                                     completed:^(NSUInteger finishedCount, NSUInteger skippedCount) {
                                                         DDLogVerbose(@"Prefetched images count: %lu, skipped: %lu", (unsigned long)finishedCount, (unsigned long)skippedCount);
                                                         
                                                         // Set isCurrentlyPreloadingGalleryImages flag in NSUserDefaults
                                                         [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isCurrentlyPreloadingGalleryImages"];
                                                         [[NSUserDefaults standardUserDefaults] synchronize];
                                                         
                                                         // Hide network activity indicator
                                                         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
}

#pragma mark - Return event image for event year method

+ (UIImage *)returnEventImageForEventYear:(NSString *)eventYearToGet
{
    UIImage *imageToReturn;
    
    if ([eventYearToGet isEqualToString:@"2009"]) {
        imageToReturn = [UIImage imageNamed:@"event-image-2009"];
        
    } else if ([eventYearToGet isEqualToString:@"2010"]) {
        imageToReturn = [UIImage imageNamed:@"event-image-2010"];
        
    } else if ([eventYearToGet isEqualToString:@"2011"]) {
        imageToReturn = [UIImage imageNamed:@"event-image-2011"];
        
    } else if ([eventYearToGet isEqualToString:@"2012"]) {
        imageToReturn = [UIImage imageNamed:@"event-image-2012"];
        
    } else if ([eventYearToGet isEqualToString:@"2013"]) {
        imageToReturn = [UIImage imageNamed:@"event-image-2013"];
        
    } else if ([eventYearToGet isEqualToString:@"2014"]) {
        imageToReturn = [UIImage imageNamed:@"event-image-2014"];
    }
    
    return imageToReturn;
}

#pragma mark - Show network unreachable UIAlertView

+ (void)showNetworkUnreachableAlertView
{
    // Init text for alert view
    NSString *alertViewTitle = NSLocalizedString(@"No Network Connectivity", @"Title of alert to user when no network is available");
    NSString *alertViewMessage = NSLocalizedString(@"A network connection is required.", @"Message shown to user in alert when no network is available");
    NSString *alertViewCancelButtonText = NSLocalizedString(@"Okay", @"Title of dismiss button shown in alert when no network is available");
    
    // Init alert view
    UIAlertView *noNetworkAlertView = [[UIAlertView alloc] initWithTitle:alertViewTitle
                                                                 message:alertViewMessage
                                                                delegate:self
                                                       cancelButtonTitle:alertViewCancelButtonText
                                                       otherButtonTitles:nil,
                                       nil];
    
    // Show alert view
    [noNetworkAlertView show];
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
