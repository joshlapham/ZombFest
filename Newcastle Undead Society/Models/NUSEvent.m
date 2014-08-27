//
//  NUSEvent.m
//  Newcastle Undead Society
//
//  Created by jl on 5/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSEvent.h"

@implementation NUSEvent

@synthesize eventYear, eventDate, eventContent, eventImageUrl, eventGalleryImageUrls, eventTimes, isPastEvent;

#pragma mark - Init method

- (id)initWithYear:(NSString *)yearValue
           andDate:(NSString *)dateValue
        andContent:(NSString *)contentValue
       andImageUrl:(NSString *)imageUrlValue
andGalleryImageUrls:(NSArray *)galleryImageUrlsValue
          andTimes:(NSArray *)eventTimesValue
    andIsPastEvent:(BOOL)pastEventOrNot
{
    self = [super init];
    
    if (self) {
        eventYear = yearValue;
        eventDate = dateValue;
        eventContent = contentValue;
        eventImageUrl = imageUrlValue;
        eventGalleryImageUrls = galleryImageUrlsValue;
        eventTimes = eventTimesValue;
        isPastEvent = pastEventOrNot;
    }
    
    DDLogVerbose(@"Init event: %@, gallery URL count: %d, is past: %hhd, content: %@, imageUrl: %@, date: %@", eventYear, [eventGalleryImageUrls count], isPastEvent, eventContent, eventImageUrl, eventDate);
    
    return self;
}

#pragma mark - NSCoding delegate methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        eventYear = [aDecoder decodeObjectForKey:@"eventYear"];
        eventDate = [aDecoder decodeObjectForKey:@"eventDate"];
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
    [aCoder encodeObject:eventDate forKey:@"eventDate"];
    [aCoder encodeObject:eventContent forKey:@"eventContent"];
    [aCoder encodeObject:eventImageUrl forKey:@"eventImageUrl"];
    [aCoder encodeObject:eventGalleryImageUrls forKey:@"eventGalleryImageUrls"];
    [aCoder encodeObject:eventTimes forKey:@"eventTimes"];
    [aCoder encodeBool:isPastEvent forKey:@"isPastEvent"];
}

@end
