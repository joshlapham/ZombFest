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
    
    NUSEvent *futureEvent2014 = [[NUSEvent alloc] initWithYear:@"2014" andContent:@"This is some info about the 2014 event" andImageUrl:@"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xap1/t1.0-9/1185656_658729170838669_745513690_n.jpg" andGalleryImageUrls:nil andIsPastEvent:NO];
    
    [tmpArray addObject:futureEvent2014];
    
    return [NSArray arrayWithArray:tmpArray];
}

+ (NSArray *)returnPastEvents
{
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    
    // TODO: implement
    
    // NOTE: this is just test data
    
    // sample gallery url data (2013)
    NSArray *galleryUrls = [NSArray arrayWithObjects:@"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xpa1/t1.0-9/p417x417/1453336_658728950838691_951320878_n.jpg", @"https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/p417x417/1470333_658728917505361_240039718_n.jpg", @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xfp1/t1.0-9/1466197_658728507505402_2105441027_n.jpg", nil];
    
    NUSEvent *pastEvent2009 = [[NUSEvent alloc] initWithYear:@"2009" andContent:@"This is some info about the 2009 event" andImageUrl:@"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/33518_127658320612426_6225652_n.jpg" andGalleryImageUrls:galleryUrls andIsPastEvent:YES];
    
    NUSEvent *pastEvent2010 = [[NUSEvent alloc] initWithYear:@"2010" andContent:@"This is some info about the 2010 event" andImageUrl:@"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/262887_224862680891989_6260150_n.jpg" andGalleryImageUrls:galleryUrls andIsPastEvent:YES];
    
    NUSEvent *pastEvent2011 = [[NUSEvent alloc] initWithYear:@"2011" andContent:@"This is some info about the 2011 event" andImageUrl:@"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/315710_259496494095274_1257647121_n.jpg" andGalleryImageUrls:galleryUrls andIsPastEvent:YES];
    
    NUSEvent *pastEvent2012 = [[NUSEvent alloc] initWithYear:@"2012" andContent:@"This is some info about the 2012 event" andImageUrl:@"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/536424_474541165924138_1749738981_n.jpg" andGalleryImageUrls:galleryUrls andIsPastEvent:YES];
    
    NUSEvent *pastEvent2013 = [[NUSEvent alloc] initWithYear:@"2013" andContent:@"This is some info about the 2013 event" andImageUrl:@"https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/1453493_658726834172236_1271715398_n.jpg" andGalleryImageUrls:galleryUrls andIsPastEvent:YES];
    
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
