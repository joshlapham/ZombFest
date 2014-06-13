//
//  NUSNewsItem.m
//  Newcastle Undead Society
//
//  Created by jl on 13/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSNewsItem.h"

@implementation NUSNewsItem

@synthesize itemId, title, content, date;

#pragma mark - Init method

- (id)initWithId:(NSString *)idValue
        andTitle:(NSString *)titleValue
      andContent:(NSString *)contentValue
         andDate:(NSString *)dateValue
{
    self = [super init];
    
    if (self) {
        itemId = idValue;
        title = titleValue;
        content = contentValue;
        date = dateValue;
    }
    
    DDLogVerbose(@"Init news item: %@, date: %@", title, date);
    
    return self;
}

#pragma mark - NSCoding delegate methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        itemId = [aDecoder decodeObjectForKey:@"newsItemId"];
        title = [aDecoder decodeObjectForKey:@"newsItemTitle"];
        content = [aDecoder decodeObjectForKey:@"newsItemContent"];
        date = [aDecoder decodeObjectForKey:@"newsItemDate"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:itemId forKey:@"newsItemId"];
    [aCoder encodeObject:title forKey:@"newsItemTitle"];
    [aCoder encodeObject:content forKey:@"newsItemContent"];
    [aCoder encodeObject:date forKey:@"newsItemDate"];
}

@end
