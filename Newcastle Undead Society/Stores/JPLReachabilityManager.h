//
//  JPLReachabilityManager.h
//
//  Created by jl on 7/05/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Reachability;

@interface JPLReachabilityManager : NSObject

@property (nonatomic, strong) Reachability *reachability;

#pragma mark - Shared manager

+ (JPLReachabilityManager *)sharedManager;

#pragma mark - Class methods

+ (BOOL)isReachable;
+ (BOOL)isUnreachable;
+ (BOOL)isReachableViaWWAN;
+ (BOOL)isReachableViaWiFi;

@end
