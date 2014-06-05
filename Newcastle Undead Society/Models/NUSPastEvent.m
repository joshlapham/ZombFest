//
//  NUSPastEvent.m
//  Newcastle Undead Society
//
//  Created by jl on 5/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSPastEvent.h"

@implementation NUSPastEvent

@synthesize eventYear, eventContent, isPastEvent, eventImageUrl;

- (id)initWithYear:(NSString *)yearValue andContent:(NSString *)contentValue andImageUrl:(NSString *)imageUrlValue
{
    self = [super init];
    
    if (self) {
        eventYear = yearValue;
        eventContent = contentValue;
        
        // Set this for every past event by default
        isPastEvent = YES;
    }
    
    DDLogVerbose(@"init event: %@, content: %@", eventYear, eventContent);
    
    return self;
}

@end
