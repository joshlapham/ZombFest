//
//  NUSVideosViewController.m
//  Newcastle Undead Society
//
//  Created by jl on 4/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSVideosViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "PBWebViewController.h"

@interface NUSVideosViewController () {
    NSMutableArray *cellArray;
    NSMutableArray *videoEntries;
    NSMutableArray *videoWinners;
    NSMutableArray *otherVideos;
}

@end

@implementation NUSVideosViewController

#pragma mark - UITableViewDataSource delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [cellArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionContents = [cellArray objectAtIndex:section];
    
    return [sectionContents count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            // Scream Screen winners
            return @"Scream Screen Winners";
            break;
            
        case 1:
            // Scream Screen entries
            return @"Scream Screen Entries";
            break;
            
        case 2:
            // Other Videos section
            return @"Other Videos";
            break;
            
        default:
            return nil;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoCell" forIndexPath:indexPath];
    
    NSArray *sectionContents = [cellArray objectAtIndex:indexPath.section];
    
    // Init cell labels
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:101];
    UILabel *durationLabel = (UILabel *)[cell viewWithTag:102];
    UIImageView *cellImageView = (UIImageView *)[cell viewWithTag:103];
    
    // TODO: cell label for author, year
    
    // Ensure video title fits in label
    titleLabel.adjustsFontSizeToFitWidth = YES;
    
    // Set video title and duration
    titleLabel.text = [[sectionContents objectAtIndex:indexPath.row] objectForKey:@"title"];
    durationLabel.text = [[sectionContents objectAtIndex:indexPath.row] objectForKey:@"duration"];
    
    // Set cell thumbnail using SDWebImage
    [cellImageView setImageWithURL:[NSURL URLWithString:[[sectionContents objectAtIndex:indexPath.row] objectForKey:@"thumbUrl"]]
                  placeholderImage:nil
                         completed:^(UIImage *cellImage, NSError *error, SDImageCacheType cacheType) {
                             if (cellImage && !error) {
                                 //DDLogVerbose(@"Fetched cell thumbnail image");
                             } else {
                                 //DDLogError(@"Error fetching cell thumbnail image: %@", [error localizedDescription]);
                                 // TODO: implement fallback
                             }
                         }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *sectionContents = [cellArray objectAtIndex:indexPath.section];
    
    // Init string with title of social link
    NSString *videoLinkTitle = [[sectionContents objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    // Init NSURL with social link URL from cellArray
    NSURL *videoLinkUrl = [NSURL URLWithString:[[sectionContents objectAtIndex:indexPath.row] objectForKey:@"videoUrl"]];
    
    // Initialize the web view controller and set its' URL
    PBWebViewController *webViewController = [[PBWebViewController alloc] init];
    webViewController.URL = videoLinkUrl;
    webViewController.title = videoLinkTitle;
    
    // Set back button of navbar to have no text
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    // Show web view controller with social media link
    [self.navigationController pushViewController:webViewController animated:YES];
}

#pragma mark - Init methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Turn off navbar translucency
    [self.navigationController.navigationBar setTranslucent:NO];
    
    // Set title
    self.title = @"Videos";
    
    // Register cell with tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"NUSVideoCell" bundle:nil] forCellReuseIdentifier:@"VideoCell"];
    
    // Init cellArray data source
    [self initCellArrayDataSource];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    // Init with grouped table style
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if (self) {
        // Remove seperator insets from tableView
        //[self.tableView setSeparatorColor:[UIColor clearColor]];
        //[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return self;
}

#pragma mark - Init cellArray data source

- (void)initCellArrayDataSource
{
    // Init arrays
    cellArray = [[NSMutableArray alloc] init];
    videoEntries = [[NSMutableArray alloc] init];
    videoWinners = [[NSMutableArray alloc] init];
    otherVideos = [[NSMutableArray alloc] init];
    
    // TODO: add author, year to data source
    
    // Other Videos
    NSDictionary *videoItem1 = @{@"title" : @"Zombies In Newcastle", @"duration" : @"3:00", @"videoUrl" : @"https://www.youtube.com/watch?v=l0su0qTwsuA", @"thumbUrl" : @"http://img.youtube.com/vi/l0su0qTwsuA/default.jpg"};
    
    // Scream Screen
    NSDictionary *videoItem2 = @{@"title" : @"Ultimatum - 2013", @"duration" : @"3:00", @"videoUrl" : @"http://vimeo.com/79647932", @"thumbUrl" : @"http://i.vimeocdn.com/video/455392983_100x75.jpg"};
    
    NSDictionary *videoItem3 = @{@"title" : @"Unconsumed - 2011", @"duration" : @"3:00", @"videoUrl" : @"https://www.youtube.com/watch?v=pZw3igUKDJU", @"thumbUrl" : @"http://img.youtube.com/vi/pZw3igUKDJU/default.jpg"};
    
    NSDictionary *videoItem4 = @{@"title" : @"One Foot In The Grave", @"duration" : @"3:00", @"videoUrl" : @"https://www.youtube.com/watch?v=fHthaXXFNEA", @"thumbUrl" : @"http://img.youtube.com/vi/fHthaXXFNEA/default.jpg"};
    
    // Author: Arf Power
    NSDictionary *videoItem5 = @{@"title" : @"A Zombie Film", @"duration" : @"3:00", @"videoUrl" : @"https://www.youtube.com/watch?v=neszLIKQb_o", @"thumbUrl" : @"http://img.youtube.com/vi/neszLIKQb_o/default.jpg"};
    
    // Scream Screen video winners
    [videoWinners addObject:videoItem2];
    [videoWinners addObject:videoItem3];
    
    // Scream Screen video entries
    [videoEntries addObject:videoItem4];
    [videoEntries addObject:videoItem5];
    
    // Other video entries
    [otherVideos addObject:videoItem1];
    
    // Temp array to hold our different arrays of data
    NSMutableArray *tmpAllArray = [[NSMutableArray alloc] init];
    [tmpAllArray addObject:videoWinners];
    [tmpAllArray addObject:videoEntries];
    [tmpAllArray addObject:otherVideos];
    
    // Init cellArray with all this data
    [cellArray setArray:tmpAllArray];
}

@end
