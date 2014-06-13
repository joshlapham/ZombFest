//
//  NUSVideo.m
//  Newcastle Undead Society
//
//  Created by jl on 13/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSVideo.h"

@implementation NUSVideo

@synthesize videoId, title, author, year, duration, videoUrl, thumbUrl, isWinner, isEntrant, isOther;

#pragma mark - Init method

- (id)initWithId:(NSString *)idValue
        andTitle:(NSString *)titleValue
       andAuthor:(NSString *)authorValue
         andYear:(NSString *)yearValue
     andDuration:(NSString *)durationValue
          andUrl:(NSString *)videoUrlValue
     andThumbUrl:(NSString *)thumbUrlValue
        isWinner:(BOOL)isWinnerValue
       isEntrant:(BOOL)isEntrantValue
         isOther:(BOOL)isOtherValue
{
    self = [super init];
    
    if (self) {
        videoId = idValue;
        title = titleValue;
        author = authorValue;
        year = yearValue;
        duration = durationValue;
        videoUrl = videoUrlValue;
        thumbUrl = thumbUrlValue;
        isWinner = isWinnerValue;
        isEntrant = isEntrantValue;
        isOther = isOtherValue;
    }
    
    DDLogVerbose(@"Init Video: %@, winner: %hhd, entrant: %hhd, other: %hhd", title, isWinner, isEntrant, isOther);
    
    return self;
}

#pragma mark - NSCoding delegate methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        videoId = [aDecoder decodeObjectForKey:@"videoId"];
        title = [aDecoder decodeObjectForKey:@"title"];
        author = [aDecoder decodeObjectForKey:@"author"];
        year = [aDecoder decodeObjectForKey:@"year"];
        duration = [aDecoder decodeObjectForKey:@"duration"];
        videoUrl = [aDecoder decodeObjectForKey:@"videoUrl"];
        thumbUrl = [aDecoder decodeObjectForKey:@"thumbUrl"];
        isWinner = [aDecoder decodeBoolForKey:@"isWinner"];
        isEntrant = [aDecoder decodeBoolForKey:@"isEntrant"];
        isOther = [aDecoder decodeBoolForKey:@"isOther"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:videoId forKey:@"videoId"];
    [aCoder encodeObject:title forKey:@"title"];
    [aCoder encodeObject:author forKey:@"author"];
    [aCoder encodeObject:year forKey:@"year"];
    [aCoder encodeObject:duration forKey:@"duration"];
    [aCoder encodeObject:videoUrl forKey:@"videoUrl"];
    [aCoder encodeObject:thumbUrl forKey:@"thumbUrl"];
    [aCoder encodeBool:isWinner forKey:@"isWinner"];
    [aCoder encodeBool:isEntrant forKey:@"isEntrant"];
    [aCoder encodeBool:isOther forKey:@"isOther"];
}

@end
