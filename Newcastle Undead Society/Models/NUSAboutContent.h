//
//  NUSAboutContent.h
//  Newcastle Undead Society
//
//  Created by jl on 13/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NUSAboutContent : NSObject <NSCoding>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *imageUrl;

// Init method
- (id)initWithTitle:(NSString *)titleValue
         andContent:(NSString *)contentValue
        andImageUrl:(NSString *)imageUrlValue;

@end
