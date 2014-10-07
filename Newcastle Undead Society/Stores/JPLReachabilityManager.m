//
//  JPLReachabilityManager.m
//
//  Created by jl on 7/05/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "JPLReachabilityManager.h"
#import "Reachability.h"

@implementation JPLReachabilityManager

#pragma mark - Default manager

+ (JPLReachabilityManager *)sharedManager
{
    static JPLReachabilityManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    //DDLogVerbose(@"Init JPLReachabilityManager");
    
    return _sharedManager;
}

#pragma mark - Memory management

- (void)dealloc
{
    // Stop notifier
    if (_reachability) {
        [_reachability stopNotifier];
    }
}

#pragma mark - Class methods

+ (BOOL)isReachable {
    return [[[JPLReachabilityManager sharedManager] reachability] isReachable];
}

+ (BOOL)isUnreachable {
    return ![[[JPLReachabilityManager sharedManager] reachability] isReachable];
}

+ (BOOL)isReachableViaWWAN {
    return [[[JPLReachabilityManager sharedManager] reachability] isReachableViaWWAN];
}

+ (BOOL)isReachableViaWiFi {
    return [[[JPLReachabilityManager sharedManager] reachability] isReachableViaWiFi];
}

#pragma mark - Private init

- (id)init
{
    self = [super init];
    
    if (self) {
        // Init Reachability
        self.reachability = [Reachability reachabilityWithHostname:@"www.duckduckgo.com"];
        
//        // Reachable block
//        self.reachability.reachableBlock = ^(Reachability *reach) {
//        };
//        
//        // Unreachable block
//        self.reachability.unreachableBlock = ^(Reachability *reach) {
//        };
        
        // Start monitoring
        [self.reachability startNotifier];
    }
    return self;
}

@end
