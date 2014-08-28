//
//  UIColor+NUSColours.m
//  Zombfest
//
//  Created by jl on 17/08/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "UIColor+NUSColours.h"

@implementation UIColor (NUSColours)

// Navbar
+ (UIColor *)navbarColour
{
    // Lynch
    return [UIColor colorWithRed:0.42 green:0.48 blue:0.54 alpha:1];
}

// Sidebar menu
+ (UIColor *)sidemenuNavbarColour
{
    // Lynch
    return [UIColor colorWithRed:0.42 green:0.48 blue:0.54 alpha:1];
}

+ (UIColor *)sidemenuBackgroundColour
{
    // Lynch
    return [UIColor colorWithRed:0.42 green:0.48 blue:0.54 alpha:1];
}

+ (UIColor *)sidemenuItemColour
{
    // Lynch
    return [UIColor colorWithRed:0.42 green:0.48 blue:0.54 alpha:1];
}

+ (UIColor *)sidemenuItemFontColour
{
    return [UIColor whiteColor];
}

// News feed
+ (UIColor *)newsFeedItemTitleColour
{
    // Dark Pastel Red
    return [UIColor colorWithRed:0.75 green:0.22 blue:0.17 alpha:1];
}

+ (UIColor *)newsFeedItemDateColour
{
    return [UIColor darkGrayColor];
}

// Background
+ (UIColor *)backgroundColorForMostViews
{
    // White (Gallery)
    return [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
}

// Header text
+ (UIColor *)headerTextColour
{
    // Dark Pastel Red
    return [UIColor colorWithRed:0.75 green:0.22 blue:0.17 alpha:1];
}

@end
