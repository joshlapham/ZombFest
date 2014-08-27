//
//  UIFont+NUSFonts.m
//  Zombfest
//
//  Created by jl on 17/08/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "UIFont+NUSFonts.h"

@implementation UIFont (NUSFonts)

// Navigation bar
+ (UIFont *)navbarFont
{
    return [self customTitleFontOfSize:20];
}

+ (UIFont *)navbarButtonFont
{
    return [self customFontOfSize:18];
}

// Sidebar menu
+ (UIFont *)sidebarMenuItemFont
{
    return [self customTitleFontOfSize:20];
}

// Newsfeed
+ (UIFont *)newsFeedItemTitleFont
{
    return [self customTitleFontOfSize:20];
}

+ (UIFont *)newsFeedItemDateFont
{
    return [self customFontOfSize:18];
}

// About section
+ (UIFont *)aboutContentFont
{
    return [self customFontOfSize:18];
}

// Private methods
+ (UIFont *)customFontOfSize:(NSInteger)size
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:size];
}

+ (UIFont *)customTitleFontOfSize:(NSInteger)size
{
    return [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:size];
}

@end
