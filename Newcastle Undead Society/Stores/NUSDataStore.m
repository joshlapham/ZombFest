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
    
    NSString *loremIpsumShort = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ut sapien sit amet magna fringilla posuere. Maecenas quis nibh sem. Integer mollis erat vel ultricies sollicitudin. Mauris porta eros nec lacus vestibulum rhoncus. Donec suscipit dictum nisl, eu facilisis neque elementum quis. Nullam at placerat magna.";
    
    // 2014 event times
    NSDictionary *firstTime = @{@"locationName": @"Museum", @"startTime" : @"14:00"};
    NSDictionary *secondTime = @{@"locationName": @"Honeysuckle", @"startTime" : @"17:00"};
    NSDictionary *thirdTime = @{@"locationName": @"Tower Cinemas", @"startTime" : @"18:00"};
    
    NSMutableArray *eventTimes2014 = [[NSMutableArray alloc] init];
    [eventTimes2014 addObject:firstTime];
    [eventTimes2014 addObject:secondTime];
    [eventTimes2014 addObject:thirdTime];
    
    NUSEvent *futureEvent2014 = [[NUSEvent alloc] initWithYear:@"2014"
                                                    andContent:loremIpsumShort
                                                   andImageUrl:@"http://leagueofevil.org/nus-img/2014.jpg"
                                           andGalleryImageUrls:nil
                                                      andTimes:eventTimes2014
                                                andIsPastEvent:NO];
    
    [tmpArray addObject:futureEvent2014];
    
    return [NSArray arrayWithArray:tmpArray];
}

+ (NSArray *)returnPastEvents
{
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    
    // TODO: implement
    
    // NOTE: this is just test data
    
    NSString *loremIpsumShort = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ut sapien sit amet magna fringilla posuere. Maecenas quis nibh sem. Integer mollis erat vel ultricies sollicitudin. Mauris porta eros nec lacus vestibulum rhoncus. Donec suscipit dictum nisl, eu facilisis neque elementum quis. Nullam at placerat magna.";
    
    // 2013
    NSArray *galleryUrls2013 = [NSArray arrayWithObjects:@"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xap1/t1.0-9/1479200_659097387468514_59617760_n.jpg", @"https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-frc3/t1.0-9/575383_659097037468549_1719938071_n.jpg", @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xpa1/t1.0-9/p417x417/1453336_658728950838691_951320878_n.jpg", @"https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/p417x417/1470333_658728917505361_240039718_n.jpg", @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xfp1/t1.0-9/1466197_658728507505402_2105441027_n.jpg", nil];
    
    // 2012
    NSArray *galleryUrls2012 = [NSArray arrayWithObjects:@"https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xfp1/t1.0-9/197139_474541029257485_1479274320_n.jpg", @"https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/536510_474541059257482_983674892_n.jpg", @"https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/12754_474541069257481_1295992460_n.jpg", @"https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/311201_474541079257480_1322811521_n.jpg", @"https://scontent-b-hkg.xx.fbcdn.net/hphotos-ash2/t1.0-9/523517_474541085924146_72152023_n.jpg", @"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/602283_474541129257475_1402204124_n.jpg", @"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/536424_474541165924138_1749738981_n.jpg", @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/430622_474541185924136_504879683_n.jpg", @"https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-prn2/t1.0-9/544865_474541215924133_1480349061_n.jpg", @"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/527337_474541252590796_1222433944_n.jpg", @"https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/308732_474541282590793_1253268551_n.jpg", nil];
    
    // 2011
    NSArray *galleryUrls2011 = [NSArray arrayWithObjects:@"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xfp1/t1.0-9/319688_259494454095478_2072311278_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-xaf1/t1.0-9/294675_259494257428831_1637965151_n.jpg", @"https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/315653_259494274095496_1390959723_n.jpg", @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xfp1/t1.0-9/314410_259494324095491_1617327961_n.jpg", @"https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/316466_259494357428821_1103980219_n.jpg", @"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/293602_259494384095485_814834832_n.jpg", @"https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/313346_259494397428817_1855415743_n.jpg", @"https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/297263_259494417428815_352752658_n.jpg", nil];
    
    // 2010 (complete set)
    NSArray *galleryUrls2010 = [NSArray arrayWithObjects:@"https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/206221_224870534224537_1948041_n.jpg", @"https://scontent-b-hkg.xx.fbcdn.net/hphotos-xpf1/t1.0-9/283447_224870564224534_1805456_n.jpg", @"https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/198817_224870587557865_787121_n.jpg", @"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/215163_224870610891196_2309528_n.jpg", @"https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/185223_224870637557860_956418_n.jpg", @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/284589_224870657557858_6075727_n.jpg", @"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/263313_224870687557855_560639_n.jpg", @"https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/281520_224870704224520_6294104_n.jpg", @"https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xfp1/t1.0-9/249206_224870724224518_5165048_n.jpg", @"https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-xap1/t1.0-9/250272_224870750891182_1752925_n.jpg", @"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/250146_224870787557845_3381696_n.jpg", nil];
    
    // 2009 (complete set)
    NSArray *galleryUrls2009 = [NSArray arrayWithObjects:@"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/38594_127658297279095_5506223_n.jpg", @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/33518_127658320612426_6225652_n.jpg", @"https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/33518_127658323945759_7556546_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-xaf1/t1.0-9/33518_127658327279092_4202832_n.jpg", @"https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/283221_224862480892009_368697_n.jpg", @"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/284297_224862550892002_4649073_n.jpg", @"https://scontent-b-hkg.xx.fbcdn.net/hphotos-xfa1/t1.0-9/254783_224862607558663_5292104_n.jpg", @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/262887_224862680891989_6260150_n.jpg", @"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/223757_224862714225319_4613198_n.jpg", @"https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-ash2/t1.0-9/229634_224862764225314_3442915_n.jpg", @"https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/251465_224862820891975_3789710_n.jpg", @"https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/185581_224862860891971_2074352_n.jpg", @"https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/285203_224862880891969_6412251_n.jpg", @"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/185332_224862950891962_6094013_n.jpg", nil];
    
    NUSEvent *pastEvent2009 = [[NUSEvent alloc] initWithYear:@"2009"
                                                  andContent:loremIpsumShort
                                                 andImageUrl:@"http://leagueofevil.org/nus-img/2009.jpg"
                                         andGalleryImageUrls:galleryUrls2009
                                                    andTimes:nil
                                              andIsPastEvent:YES];
    
    NUSEvent *pastEvent2010 = [[NUSEvent alloc] initWithYear:@"2010"
                                                  andContent:loremIpsumShort
                                                 andImageUrl:@"http://leagueofevil.org/nus-img/2010.jpg"
                                         andGalleryImageUrls:galleryUrls2010
                                                    andTimes:nil
                                              andIsPastEvent:YES];
    
    NUSEvent *pastEvent2011 = [[NUSEvent alloc] initWithYear:@"2011"
                                                  andContent:loremIpsumShort
                                                 andImageUrl:@"http://leagueofevil.org/nus-img/2011.jpg"
                                         andGalleryImageUrls:galleryUrls2011
                                                    andTimes:nil
                                              andIsPastEvent:YES];
    
    NUSEvent *pastEvent2012 = [[NUSEvent alloc] initWithYear:@"2012"
                                                  andContent:loremIpsumShort
                                                 andImageUrl:@"http://leagueofevil.org/nus-img/2012.jpg"
                                         andGalleryImageUrls:galleryUrls2012
                                                    andTimes:nil
                                              andIsPastEvent:YES];
    
    NUSEvent *pastEvent2013 = [[NUSEvent alloc] initWithYear:@"2013"
                                                  andContent:loremIpsumShort
                                                 andImageUrl:@"http://leagueofevil.org/nus-img/2013.jpg"
                                         andGalleryImageUrls:galleryUrls2013
                                                    andTimes:nil
                                              andIsPastEvent:YES];
    
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
