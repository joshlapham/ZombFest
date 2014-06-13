//
//  NUSEvent.m
//  Newcastle Undead Society
//
//  Created by jl on 5/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSEvent.h"

@implementation NUSEvent

@synthesize eventYear, eventContent, eventImageUrl, eventMapImageUrl, eventGalleryImageUrls, eventTimes, isPastEvent;

#pragma mark - Init method

- (id)initWithYear:(NSString *)yearValue
        andContent:(NSString *)contentValue
       andImageUrl:(NSString *)imageUrlValue
andGalleryImageUrls:(NSArray *)galleryImageUrlsValue
          andTimes:(NSArray *)eventTimesValue
    andIsPastEvent:(BOOL)pastEventOrNot
{
    self = [super init];
    
    if (self) {
        eventYear = yearValue;
        eventContent = contentValue;
        eventImageUrl = imageUrlValue;
        eventGalleryImageUrls = galleryImageUrlsValue;
        eventTimes = eventTimesValue;
        isPastEvent = pastEventOrNot;
        
        // TODO: don't hardcode this one map image for all event objects, change it up a bit
        eventMapImageUrl = @"http://leagueofevil.org/nus/img/map.jpg";
    }
    
    DDLogVerbose(@"Init event: %@, gallery URL count: %d, is past: %hhd, content: %@, imageUrl: %@", eventYear, [eventGalleryImageUrls count], isPastEvent, eventContent, eventImageUrl);
    
    return self;
}

#pragma mark - NSCoding delegate methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        eventYear = [aDecoder decodeObjectForKey:@"eventYear"];
        eventContent = [aDecoder decodeObjectForKey:@"eventContent"];
        eventImageUrl = [aDecoder decodeObjectForKey:@"eventImageUrl"];
        eventGalleryImageUrls = [aDecoder decodeObjectForKey:@"eventGalleryImageUrls"];
        eventTimes = [aDecoder decodeObjectForKey:@"eventTimes"];
        isPastEvent = [aDecoder decodeBoolForKey:@"isPastEvent"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:eventYear forKey:@"eventYear"];
    [aCoder encodeObject:eventContent forKey:@"eventContent"];
    [aCoder encodeObject:eventImageUrl forKey:@"eventImageUrl"];
    [aCoder encodeObject:eventGalleryImageUrls forKey:@"eventGalleryImageUrls"];
    [aCoder encodeObject:eventTimes forKey:@"eventTimes"];
    [aCoder encodeBool:isPastEvent forKey:@"isPastEvent"];
}

@end
