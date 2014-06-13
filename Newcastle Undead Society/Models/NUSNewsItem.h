//
//  NUSNewsItem.h
//  Newcastle Undead Society
//
//  Created by jl on 13/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NUSNewsItem : NSObject <NSCoding>

@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *date;

// Init method
- (id)initWithId:(NSString *)idValue
        andTitle:(NSString *)titleValue
      andContent:(NSString *)contentValue
         andDate:(NSString *)dateValue;

@end
