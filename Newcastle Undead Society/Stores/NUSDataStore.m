//
//  NUSDataStore.m
//  Newcastle Undead Society
//
//  Created by jl on 5/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSDataStore.h"
#import "NUSEvent.h"

@implementation NUSDataStore

#pragma mark - Return future and past events methods

+ (NSArray *)returnFutureEvents
{
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    
    // TODO: implement
    
    // NOTE: this is just test data
    
    NUSEvent *futureEvent2014 = [[NUSEvent alloc] initWithYear:@"2014" andContent:@"This is some info about the 2014 event" andImageUrl:@"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xap1/t1.0-9/1185656_658729170838669_745513690_n.jpg" andIsPastEvent:NO];
    
    [tmpArray addObject:futureEvent2014];
    
    return [NSArray arrayWithArray:tmpArray];
}

+ (NSArray *)returnPastEvents
{
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    
    // TODO: implement
    
    // NOTE: this is just test data
    
    NUSEvent *pastEvent2009 = [[NUSEvent alloc] initWithYear:@"2009" andContent:@"This is some info about the 2009 event" andImageUrl:@"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/33518_127658320612426_6225652_n.jpg" andIsPastEvent:YES];
    NUSEvent *pastEvent2010 = [[NUSEvent alloc] initWithYear:@"2010" andContent:@"This is some info about the 2010 event" andImageUrl:@"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/262887_224862680891989_6260150_n.jpg" andIsPastEvent:YES];
    NUSEvent *pastEvent2011 = [[NUSEvent alloc] initWithYear:@"2011" andContent:@"This is some info about the 2011 event" andImageUrl:@"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/315710_259496494095274_1257647121_n.jpg" andIsPastEvent:YES];
    NUSEvent *pastEvent2012 = [[NUSEvent alloc] initWithYear:@"2012" andContent:@"This is some info about the 2012 event" andImageUrl:@"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/536424_474541165924138_1749738981_n.jpg" andIsPastEvent:YES];
    NUSEvent *pastEvent2013 = [[NUSEvent alloc] initWithYear:@"2013" andContent:@"This is some info about the 2013 event" andImageUrl:@"https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/1453493_658726834172236_1271715398_n.jpg"andIsPastEvent:YES];
    
    [tmpArray addObject:pastEvent2013];
    [tmpArray addObject:pastEvent2012];
    [tmpArray addObject:pastEvent2011];
    [tmpArray addObject:pastEvent2010];
    [tmpArray addObject:pastEvent2009];
    
    return [NSArray arrayWithArray:tmpArray];
}

#pragma mark - Fetch data method

+ (void)fetchData
{
    DDLogVerbose(@"%s", __FUNCTION__);
    
    // TODO: implement this method
}

#pragma mark - Init method

+ (instancetype)sharedStore
{
    static NUSDataStore *_sharedStore = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedStore = [[NUSDataStore alloc] init];
    });
    
    DDLogVerbose(@"Init NUSDataStore");
    
    return _sharedStore;
}

@end
