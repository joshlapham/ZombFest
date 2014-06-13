//
//  NUSSocialLink.h
//  Newcastle Undead Society
//
//  Created by jl on 9/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NUSSocialLink : NSObject <NSCoding>

@property (nonatomic, strong) NSString *linkTitle;
@property (nonatomic, strong) NSString *linkUrl;
@property (nonatomic, strong) NSString *linkImageUrl;

// Init method
- (id)initWithTitle:(NSString *)linkTitleValue
             andUrl:(NSString *)linkUrlValue
        andImageUrl:(NSString *)linkImageUrlValue;

@end
