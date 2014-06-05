//
//  NUSDataStore.h
//  Newcastle Undead Society
//
//  Created by jl on 5/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NUSDataStore : NSObject

// Init method
+ (NUSDataStore *)sharedStore;

// Class methods
+ (void)fetchData;

@end
