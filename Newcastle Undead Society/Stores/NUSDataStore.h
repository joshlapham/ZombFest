//
//  NUSDataStore.h
//  Newcastle Undead Society
//
//  Created by jl on 5/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NUSDataStore : NSObject

// Init method
+ (NUSDataStore *)sharedStore;

// Class methods
+ (void)preloadGalleryImagesForAllEvents;
+ (NSArray *)returnNewsItemsFromCache;
+ (NSArray *)returnAboutSectionContent;
+ (NSArray *)returnPastEventsFromCache;
+ (NSArray *)returnFutureEventsFromCache;
+ (NSArray *)returnAllVideosFromCache;
+ (NSArray *)returnWinningVideosFromCache;
+ (NSArray *)returnEntrantVideosFromCache;
+ (NSArray *)returnOtherVideosFromCache;
+ (NSArray *)returnSocialMediaLinksFromCache;
+ (BOOL)hasFirstDataFetchHappened;
+ (void)downloadZombieJSONDataFileToDevice;
+ (NSString *)returnPathToLocalZombieJSONDataFile;
+ (NSString *)returnPathToLocalZombieJSONDataFileIncludedOnDevice;
+ (void)parseZombieJSONDataFileWithFilePath:(NSString *)pathToJsonDataFile;
+ (BOOL)isCurrentlyFetchingZombieJSONDataFile;
+ (BOOL)isCurrentlyPreloadingGalleryImages;

@end
