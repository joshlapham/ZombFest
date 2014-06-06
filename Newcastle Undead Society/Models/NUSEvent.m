//
//  NUSEvent.m
//  Newcastle Undead Society
//
//  Created by jl on 5/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSEvent.h"

@implementation NUSEvent

@synthesize eventYear, eventContent, eventImageUrl, eventGalleryImageUrls, eventTimes, isPastEvent;

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
    }
    
    DDLogVerbose(@"Init event: %@, gallery URL count: %d, is past: %hhd", eventYear, [eventGalleryImageUrls count], isPastEvent);
    
    return self;
}

@end
