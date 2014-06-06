//
//  NUSDataStore.m
//  Newcastle Undead Society
//
//  Created by jl on 5/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSDataStore.h"
#import "NUSEvent.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SDWebImagePrefetcher.h"

@implementation NUSDataStore

#pragma mark - Preload gallery images

+ (void)preloadGalleryImagesForAllEvents
{
    NSArray *resultsArray = [NSArray arrayWithArray:[NUSDataStore returnPastEvents]];
    NSMutableArray *prefetchUrls = [[NSMutableArray alloc] init];
    
    for (NUSEvent *eventItem in resultsArray) {
        for (NSString *urlToPreload in eventItem.eventGalleryImageUrls) {
            NSString *urlString = urlToPreload;
            NSURL *urlToPrefetch = [NSURL URLWithString:urlString];
            [prefetchUrls addObject:urlToPrefetch];
        }
    }
    
    // Cache URL for SDWebImage
    [[SDWebImagePrefetcher sharedImagePrefetcher] prefetchURLs:prefetchUrls];
    [[SDWebImagePrefetcher sharedImagePrefetcher] prefetchURLs:prefetchUrls
                                                      progress:nil
                                                     completed:^(NSUInteger finishedCount, NSUInteger skippedCount) {
        DDLogVerbose(@"Prefetched images count: %d, skipped: %d", finishedCount, skippedCount);
    }];
}

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
    
    // 2013 (40 of 94 .. start at 41, which hasn't been added)
    NSArray *galleryUrls2013 = [NSArray arrayWithObjects:@"https://scontent-a-hkg.xx.fbcdn.net/hphotos-frc3/t1.0-9/p417x417/644503_658726610838925_2054274947_n.jpg", @"https://scontent-b-hkg.xx.fbcdn.net/hphotos-xap1/l/t1.0-9/1470227_658726814172238_412773222_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-frc3/t1.0-9/1001991_658726844172235_1053055451_n.jpg", @"https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/1453493_658726834172236_1271715398_n.jpg", @"https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-prn2/t1.0-9/960193_658726864172233_875513385_n.jpg", @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xpa1/t1.0-9/1441342_658726924172227_133349860_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-xpa1/t1.0-9/1470229_658726904172229_713178721_n.jpg", @"https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-xfp1/t1.0-9/1459198_658726954172224_922511634_n.jpg", @"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xpa1/t1.0-9/1460103_658726970838889_1897828654_n.jpg", @"https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-xap1/t1.0-9/1454883_658727014172218_1897750827_n.jpg", @"https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/1471201_658727024172217_1756746657_n.jpg", @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xpa1/t1.0-9/1456718_658727067505546_1416571087_n.jpg", @"https://scontent-b-hkg.xx.fbcdn.net/hphotos-frc3/t1.0-9/577523_658727110838875_245213284_n.jpg", @"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xfp1/t1.0-9/1465223_658727097505543_1259630137_n.jpg", @"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-ash2/t1.0-9/995242_658727157505537_2085360300_n.jpg", @"https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-prn2/t1.0-9/1450790_658727147505538_1373017093_n.jpg", @"https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-ash2/t1.0-9/1426155_658727187505534_2137094912_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-xfa1/t1.0-9/1454877_658727257505527_452669232_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-xap1/l/t1.0-9/1453469_658727284172191_2123690044_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-xfa1/t1.0-9/1424411_658727287505524_50947585_n.jpg", @"https://scontent-b-hkg.xx.fbcdn.net/hphotos-xfp1/t1.0-9/1450245_658727350838851_1836110931_n.jpg", @"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/1453319_658727357505517_726991827_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-xap1/t1.0-9/1452245_658727314172188_967968449_n.jpg", @"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-frc3/t1.0-9/580606_658727410838845_786534419_n.jpg", @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-ash2/t1.0-9/482446_658727397505513_2114159191_n.jpg", @"https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-prn1/t1.0-9/155745_658727447505508_368521615_n.jpg", @"https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-prn2/t1.0-9/1240365_658727464172173_195865743_n.jpg", @"https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/1450183_658727467505506_1148543885_n.jpg", @"https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-frc3/t1.0-9/599630_658727524172167_374652571_n.jpg", @"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xfp1/t1.0-9/1441349_658727550838831_1351743334_n.jpg", @"https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-frc3/t1.0-9/1459181_658727557505497_914619361_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-prn2/t1.0-9/1379581_658727607505492_1526079624_n.jpg", @"https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/1450325_658727637505489_1664082989_n.jpg", @"https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xfp1/t1.0-9/1465189_658727600838826_1048917457_n.jpg", @"https://scontent-b-hkg.xx.fbcdn.net/hphotos-ash2/t1.0-9/1441211_658727640838822_1863211710_n.jpg", @"https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-prn2/t1.0-9/1459141_658727664172153_1675596427_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-xap1/t1.0-9/1461695_658727720838814_1679867478_n.jpg", @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xpa1/t1.0-9/1463149_658727727505480_1799899054_n.jpg", @"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xap1/t1.0-9/1461777_658727710838815_1492904578_n.jpg", @"https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-frc3/t1.0-9/1441362_658727770838809_1656438786_n.jpg", nil];
    
    // 2012 (complete set)
    NSArray *galleryUrls2012 = [NSArray arrayWithObjects:@"https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xfp1/t1.0-9/197139_474541029257485_1479274320_n.jpg", @"https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/536510_474541059257482_983674892_n.jpg", @"https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/12754_474541069257481_1295992460_n.jpg", @"https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/311201_474541079257480_1322811521_n.jpg", @"https://scontent-b-hkg.xx.fbcdn.net/hphotos-ash2/t1.0-9/523517_474541085924146_72152023_n.jpg", @"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/602283_474541129257475_1402204124_n.jpg", @"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/536424_474541165924138_1749738981_n.jpg", @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/430622_474541185924136_504879683_n.jpg", @"https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-prn2/t1.0-9/544865_474541215924133_1480349061_n.jpg", @"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/527337_474541252590796_1222433944_n.jpg", @"https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/308732_474541282590793_1253268551_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-ash2/t1.0-9/521610_474541329257455_1688330422_n.jpg", @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/373979_474541345924120_1862540718_n.jpg", @"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/481856_474541375924117_1749079134_n.jpg", @"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/12744_474541392590782_1904462055_n.jpg", @"https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/483141_474541429257445_974655433_n.jpg", @"https://scontent-b-hkg.xx.fbcdn.net/hphotos-xfa1/t1.0-9/552296_474541449257443_1986354679_n.jpg", @"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xap1/t1.0-9/155910_474541495924105_982400299_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-xaf1/t1.0-9/480591_474541519257436_474156540_n.jpg", @"https://scontent-b-hkg.xx.fbcdn.net/hphotos-frc3/t1.0-9/523496_474541545924100_1046051396_n.jpg", @"https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/530998_474541569257431_529473308_n.jpg", @"https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-prn2/t1.0-9/534051_474541599257428_653786033_n.jpg", @"https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-xap1/t1.0-9/18307_474541622590759_1155122377_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-prn2/t1.0-9/523511_474541632590758_1526568418_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-xaf1/t1.0-9/305614_474541665924088_1133127826_n.jpg", @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-prn2/t1.0-9/521744_474541689257419_303269486_n.jpg", @"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/293774_474541719257416_331419592_n.jpg", @"https://scontent-b-hkg.xx.fbcdn.net/hphotos-xfa1/t1.0-9/527443_474541742590747_1025479708_n.jpg", @"https://scontent-b-hkg.xx.fbcdn.net/hphotos-xpa1/t1.0-9/32436_474541762590745_341100790_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-prn2/t1.0-9/536854_474541779257410_1193817245_n.jpg", @"https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/181997_474541792590742_1182388606_n.jpg", @"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xpa1/t1.0-9/66529_474541812590740_1144293032_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-xfp1/t1.0-9/69731_474541839257404_1791903715_n.jpg", @"https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/302701_474541895924065_2015377100_n.jpg", @"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/390170_474541922590729_1717772783_n.jpg", @"https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/318911_474541935924061_1645065212_n.jpg", @"https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/530762_474541962590725_1916542993_n.jpg", @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xfp1/t1.0-9/249351_474541992590722_1549464222_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-xaf1/t1.0-9/545308_474542009257387_2064069755_n.jpg", @"https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-prn2/t1.0-9/549059_474542022590719_657195628_n.jpg", @"https://scontent-b-hkg.xx.fbcdn.net/hphotos-xfa1/t1.0-9/417103_474542055924049_441438787_n.jpg", @"https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-xpa1/t1.0-9/59391_474542109257377_1184475742_n.jpg", @"https://scontent-b-hkg.xx.fbcdn.net/hphotos-xfa1/t1.0-9/533501_474542139257374_2142830627_n.jpg", nil];
    
    // 2011 (complete set)
    NSArray *galleryUrls2011 = [NSArray arrayWithObjects:@"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xfp1/t1.0-9/319688_259494454095478_2072311278_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-xaf1/t1.0-9/294675_259494257428831_1637965151_n.jpg", @"https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/315653_259494274095496_1390959723_n.jpg", @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xfp1/t1.0-9/314410_259494324095491_1617327961_n.jpg", @"https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/316466_259494357428821_1103980219_n.jpg", @"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/293602_259494384095485_814834832_n.jpg", @"https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/313346_259494397428817_1855415743_n.jpg", @"https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/297263_259494417428815_352752658_n.jpg", @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xfp1/t1.0-9/310444_259494430762147_1202425914_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-xfp1/t1.0-9/299354_259494480762142_1731947609_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-xaf1/l/t1.0-9/298044_259494504095473_1410369263_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-xfp1/t1.0-9/307794_259494520762138_705135410_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-xaf1/t1.0-9/302320_259494550762135_1388024899_n.jpg", @"https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/298927_259494584095465_1893010604_n.jpg", @"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/294420_259494607428796_39349928_n.jpg", @"https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/300423_259494640762126_689454997_n.jpg", @"https://scontent-b-hkg.xx.fbcdn.net/hphotos-xfa1/t1.0-9/296280_259494667428790_695398632_n.jpg", @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/295974_259494687428788_546325604_n.jpg", @"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/298895_259494714095452_1678449349_n.jpg", @"https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/292020_259494734095450_438244375_n.jpg", @"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/310935_259494744095449_1110651768_n.jpg", @"https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/292079_259494760762114_1069542988_n.jpg", @"https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/314531_259494797428777_1168780318_n.jpg", @"https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/303823_259494817428775_668312727_n.jpg", @"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/305362_259494854095438_227431200_n.jpg", @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/291985_259494880762102_1772322044_n.jpg", @"https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/310230_259494910762099_171386192_n.jpg", @"https://scontent-b-hkg.xx.fbcdn.net/hphotos-xpf1/t1.0-9/297479_259494930762097_2043109839_n.jpg", @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/295945_259494960762094_194884698_n.jpg", @"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xfp1/t1.0-9/298578_259494990762091_545269337_n.jpg", @"https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/306370_259495017428755_424861506_n.jpg", @"https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xpa1/t1.0-9/308592_259495040762086_1582294109_n.jpg", @"https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/307592_259495094095414_1210832871_n.jpg", @"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/297106_259495120762078_22599286_n.jpg", @"https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/308072_259495147428742_725249255_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-xfp1/t1.0-9/293351_259495177428739_1003780156_n.jpg", @"https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/296176_259495190762071_126392883_n.jpg", @"https://scontent-b-hkg.xx.fbcdn.net/hphotos-xfa1/t1.0-9/314953_259495214095402_1822148605_n.jpg", @"https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/321197_259495247428732_527984511_n.jpg", @"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/310150_259495267428730_719739235_n.jpg", @"https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/313674_259495277428729_1017821635_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-xaf1/t1.0-9/300182_259495320762058_180744858_n.jpg", @"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/297038_259495337428723_1488695384_n.jpg", @"https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/312168_259495360762054_1460715490_n.jpg", @"https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/298538_259495394095384_1550894762_n.jpg", @"https://scontent-b-hkg.xx.fbcdn.net/hphotos-xpf1/t1.0-9/314490_259495410762049_726833977_n.jpg", @"https://scontent-b-hkg.xx.fbcdn.net/hphotos-xfa1/t1.0-9/295799_259495437428713_1049184420_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-xaf1/t1.0-9/314917_259495464095377_207642496_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-xaf1/t1.0-9/294279_259495497428707_37018649_n.jpg", @"https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xfp1/t1.0-9/309082_259495544095369_74338998_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-xfp1/t1.0-9/302568_259495524095371_525427749_n.jpg", @"https://scontent-b-hkg.xx.fbcdn.net/hphotos-xfa1/t1.0-9/307356_259495560762034_1163230771_n.jpg", @"https://scontent-b-hkg.xx.fbcdn.net/hphotos-xpf1/t1.0-9/302287_259495590762031_515768322_n.jpg", @"https://scontent-b-hkg.xx.fbcdn.net/hphotos-xpf1/t1.0-9/297285_259495620762028_2117984914_n.jpg", @"https://scontent-b-hkg.xx.fbcdn.net/hphotos-xfa1/t1.0-9/314095_259495647428692_511591278_n.jpg", @"https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xfp1/t1.0-9/297337_259495690762021_1809421141_n.jpg", @"https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/320943_259495720762018_1356739380_n.jpg", @"https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/296962_259495734095350_1190101787_n.jpg", @"https://scontent-b-hkg.xx.fbcdn.net/hphotos-xpf1/t1.0-9/296478_259495770762013_1947466332_n.jpg", @"https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/310356_259495797428677_1858331401_n.jpg", @"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/317544_259495820762008_1994358932_n.jpg", @"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xfp1/t1.0-9/311385_259495834095340_1426472995_n.jpg", @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xfp1/t1.0-9/291838_259495857428671_1447354627_n.jpg", @"https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xfp1/t1.0-9/311411_259495897428667_1979734613_n.jpg", @"https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/297996_259495930761997_910907827_n.jpg", @"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/318335_259495964095327_2052922815_n.jpg", @"https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/302509_259495987428658_1264009755_n.jpg", @"https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/316068_259496014095322_518332585_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-xaf1/t1.0-9/298845_259496034095320_1502058815_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-xaf1/t1.0-9/299175_259496070761983_1748278648_n.jpg", @"https://scontent-a-hkg.xx.fbcdn.net/hphotos-xaf1/t1.0-9/300239_259496100761980_1380145404_n.jpg", @"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/314590_259496134095310_1205506029_n.jpg", @"https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/300086_259496164095307_1940558332_n.jpg", @"https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/308368_259496180761972_1456626134_n.jpg", @"https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/316467_259496200761970_728803004_n.jpg", @"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/313757_259496227428634_1393166590_n.jpg", @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/321144_259496254095298_659435042_n.jpg", @"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/310984_259496744095249_194639935_n.jpg", @"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/303780_259496290761961_1339317479_n.jpg", @"https://scontent-b-hkg.xx.fbcdn.net/hphotos-xfa1/l/t1.0-9/320801_259496760761914_384805806_n.jpg", @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/309636_259496454095278_1531503563_n.jpg", @"https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/321088_259496320761958_1623459956_n.jpg", @"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/315710_259496494095274_1257647121_n.jpg", @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/298080_259496727428584_1980249306_n.jpg", @"https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/296631_259496557428601_1855735063_n.jpg", @"https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/309473_259496570761933_923193293_n.jpg", @"https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/317208_259496584095265_582375636_n.jpg", @"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/299714_259496610761929_901637363_n.jpg", @"https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/299479_259496640761926_565452939_n.jpg", @"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/298026_259496677428589_2059582934_n.jpg", @"https://scontent-b-hkg.xx.fbcdn.net/hphotos-xfa1/t1.0-9/300679_259496694095254_890477112_n.jpg", @"https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/303832_259496707428586_1825609810_n.jpg", @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xfp1/t1.0-9/296317_259496620761928_1820657199_n.jpg", @"https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/309615_259496394095284_1259814864_n.jpg", @"https://scontent-b-hkg.xx.fbcdn.net/hphotos-xpf1/t1.0-9/300828_259496380761952_353596143_n.jpg", @"https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/303970_259496350761955_1222486043_n.jpg", @"https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/302005_259494230762167_1314042552_n.jpg", @"https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xfp1/t1.0-9/293459_259496420761948_88618434_n.jpg", @"https://scontent-b-hkg.xx.fbcdn.net/hphotos-xpf1/t1.0-9/307766_259496790761911_712084264_n.jpg", nil];
    
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
