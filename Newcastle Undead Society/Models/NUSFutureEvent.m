//
//  NUSFutureEvent.m
//  Newcastle Undead Society
//
//  Created by jl on 5/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSFutureEvent.h"

@implementation NUSFutureEvent

@synthesize eventYear, eventContent, isPastEvent, eventImageUrl;

- (id)initWithYear:(NSString *)yearValue andContent:(NSString *)contentValue andImageUrl:(NSString *)imageUrlValue
{
    self = [super init];
    
    if (self) {
        eventYear = yearValue;
        eventContent = contentValue;
        eventImageUrl = imageUrlValue;
        
        // Set this for every future event by default
        isPastEvent = NO;
    }
    
    DDLogVerbose(@"init event: %@, content: %@, img url: %@", eventYear, eventContent, eventImageUrl);
    
    return self;
}

@end
