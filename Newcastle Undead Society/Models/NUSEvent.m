//
//  NUSEvent.m
//  Newcastle Undead Society
//
//  Created by jl on 5/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSEvent.h"

@implementation NUSEvent

@synthesize eventYear, eventDate, eventContent, eventImageUrl, eventGalleryImageUrls, eventTimes, eventArticles, isPastEvent;

#pragma mark - Init method

- (id)initWithYear:(NSString *)yearValue
           andDate:(NSString *)dateValue
        andContent:(NSString *)contentValue
       andImageUrl:(NSString *)imageUrlValue
andGalleryImageUrls:(NSArray *)galleryImageUrlsValue
          andTimes:(NSArray *)eventTimesValue
       andArticles:(NSArray *)eventArticlesValue
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
        eventArticles = eventArticlesValue;
        isPastEvent = pastEventOrNot;
    }
    
    DDLogVerbose(@"Init event: %@, gallery URL count: %lu, is past: %hhd, content: %@, imageUrl: %@, articles count: %lu, date: %@", eventYear, [eventGalleryImageUrls count], isPastEvent, eventContent, eventImageUrl, (unsigned long)[eventArticles count], eventDate);
    
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
        eventArticles = [aDecoder decodeObjectForKey:@"eventArticles"];
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
    [aCoder encodeObject:eventArticles forKey:@"eventArticles"];
    [aCoder encodeBool:isPastEvent forKey:@"isPastEvent"];
}

@end
