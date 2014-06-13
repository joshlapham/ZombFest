//
//  NUSSocialLink.m
//  Newcastle Undead Society
//
//  Created by jl on 9/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSSocialLink.h"

@implementation NUSSocialLink

@synthesize linkTitle, linkUrl, linkImageUrl;

#pragma mark - Init method

- (id)initWithTitle:(NSString *)linkTitleValue
             andUrl:(NSString *)linkUrlValue
        andImageUrl:(NSString *)linkImageUrlValue
{
    self = [super init];
    
    if (self) {
        linkTitle = linkTitleValue;
        linkUrl = linkUrlValue;
        linkImageUrl = linkImageUrlValue;
    }
    
    DDLogVerbose(@"Init social link: %@ - %@", linkTitle, linkUrl);
    
    return self;
}

#pragma mark - NSCoding delegate methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        linkTitle = [aDecoder decodeObjectForKey:@"linkTitle"];
        linkUrl = [aDecoder decodeObjectForKey:@"linkUrl"];
        linkImageUrl = [aDecoder decodeObjectForKey:@"linkImageUrl"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:linkTitle forKey:@"linkTitle"];
    [aCoder encodeObject:linkUrl forKey:@"linkUrl"];
    [aCoder encodeObject:linkImageUrl forKey:@"linkImageUrl"];
}

@end
