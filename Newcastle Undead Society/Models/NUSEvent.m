//
//  NUSEvent.m
//  Newcastle Undead Society
//
//  Created by jl on 5/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSEvent.h"

@implementation NUSEvent

@synthesize eventYear, eventContent, isPastEvent, eventImageUrl, eventGalleryImageUrls;

- (id)initWithYear:(NSString *)yearValue andContent:(NSString *)contentValue andImageUrl:(NSString *)imageUrlValue andGalleryImageUrls:(NSArray *)galleryImageUrlsValue andIsPastEvent:(BOOL)pastEventOrNot
{
    self = [super init];
    
    if (self) {
        eventYear = yearValue;
        eventContent = contentValue;
        eventImageUrl = imageUrlValue;
        eventGalleryImageUrls = galleryImageUrlsValue;
        isPastEvent = pastEventOrNot;
    }
    
    DDLogVerbose(@"init event: %@, content: %@, gallery url count: %d, is past or not: %hhd", eventYear, eventContent, [eventGalleryImageUrls count], isPastEvent);
    
    return self;
}

@end
