//
//  NUSVideo.h
//  Newcastle Undead Society
//
//  Created by jl on 13/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NUSVideo : NSObject

@property (nonatomic, strong) NSString *videoId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSString *videoUrl;
@property (nonatomic, strong) NSString *thumbUrl;
@property (nonatomic) BOOL isWinner;
@property (nonatomic) BOOL isEntrant;
@property (nonatomic) BOOL isOther;

// Init method
- (id)initWithId:(NSString *)idValue
        andTitle:(NSString *)titleValue
       andAuthor:(NSString *)authorValue
         andYear:(NSString *)yearValue
     andDuration:(NSString *)durationValue
          andUrl:(NSString *)videoUrlValue
     andThumbUrl:(NSString *)thumbUrlValue
        isWinner:(BOOL)isWinnerValue
       isEntrant:(BOOL)isEntrantValue
         isOther:(BOOL)isOtherValue;

@end
