//
//  NUSAboutContent.m
//  Newcastle Undead Society
//
//  Created by jl on 13/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSAboutContent.h"

@implementation NUSAboutContent

@synthesize title, content, imageUrl;

#pragma mark - Init method

- (id)initWithTitle:(NSString *)titleValue
         andContent:(NSString *)contentValue
        andImageUrl:(NSString *)imageUrlValue
{
    self = [super init];
    
    if (self) {
        title = titleValue;
        content = contentValue;
        imageUrl = imageUrlValue;
    }
    
    DDLogVerbose(@"Init About content");
    
    return self;
}

#pragma mark - NSCoding delegate methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        title = [aDecoder decodeObjectForKey:@"aboutTitle"];
        content = [aDecoder decodeObjectForKey:@"aboutContent"];
        imageUrl = [aDecoder decodeObjectForKey:@"aboutImageUrl"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:title forKey:@"aboutTitle"];
    [aCoder encodeObject:content forKey:@"aboutContent"];
    [aCoder encodeObject:imageUrl forKey:@"aboutImageUrl"];
}

@end
