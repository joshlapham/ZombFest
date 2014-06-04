//
//  NUSVideosViewController.m
//  Newcastle Undead Society
//
//  Created by jl on 4/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSVideosViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface NUSVideosViewController () {
    NSMutableArray *cellArray;
    NSMutableArray *videoEntries;
    NSMutableArray *otherVideos;
}

@end

@implementation NUSVideosViewController

#pragma mark - UITableViewDataSource delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            // Scream Screen section
            return [videoEntries count];
            break;
            
        case 1:
            // Other Videos section
            return [otherVideos count];
            break;
            
        default:
            // Return 1 by default
            return 1;
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            // Scream Screen section
            return @"Scream Screen Winners";
            break;
            
        case 1:
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
    
    // Init cell labels
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:101];
    UILabel *durationLabel = (UILabel *)[cell viewWithTag:102];
    UIImageView *cellImageView = (UIImageView *)[cell viewWithTag:103];
    
    // Ensure video title fits in label
    titleLabel.adjustsFontSizeToFitWidth = YES;
    
    switch (indexPath.section) {
        case 0:
            // Scream Screen section
            // Set video title and duration
            titleLabel.text = [[videoEntries objectAtIndex:indexPath.row] objectForKey:@"title"];
            durationLabel.text = [[videoEntries objectAtIndex:indexPath.row] objectForKey:@"duration"];
            
            // Set cell thumbnail using SDWebImage
            [cellImageView setImageWithURL:[NSURL URLWithString:[[videoEntries objectAtIndex:indexPath.row] objectForKey:@"thumbUrl"]]
                          placeholderImage:nil
                                 completed:^(UIImage *cellImage, NSError *error, SDImageCacheType cacheType) {
                                     if (cellImage && !error) {
                                         //DDLogVerbose(@"Fetched cell thumbnail image");
                                     } else {
                                         //DDLogError(@"Error fetching cell thumbnail image: %@", [error localizedDescription]);
                                         // TODO: implement fallback
                                     }
                                 }];
            
            break;
            
        case 1:
            // Other Videos section
            // Set video title and duration
            titleLabel.text = [[otherVideos objectAtIndex:indexPath.row] objectForKey:@"title"];
            durationLabel.text = [[otherVideos objectAtIndex:indexPath.row] objectForKey:@"duration"];
            
            // Set cell thumbnail using SDWebImage
            [cellImageView setImageWithURL:[NSURL URLWithString:[[otherVideos objectAtIndex:indexPath.row] objectForKey:@"thumbUrl"]]
                          placeholderImage:nil
                                 completed:^(UIImage *cellImage, NSError *error, SDImageCacheType cacheType) {
                                     if (cellImage && !error) {
                                         //DDLogVerbose(@"Fetched cell thumbnail image");
                                     } else {
                                         //DDLogError(@"Error fetching cell thumbnail image: %@", [error localizedDescription]);
                                         // TODO: implement fallback
                                     }
                                 }];
            
            break;
            
        default:
            break;
    }
    
    return cell;
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
    videoEntries = [[NSMutableArray alloc] init];
    otherVideos = [[NSMutableArray alloc] init];
    
    // Other Videos
    NSDictionary *videoItem1 = @{@"title" : @"Zombies In Newcastle", @"duration" : @"3:00", @"videoUrl" : @"https://www.youtube.com/watch?v=l0su0qTwsuA", @"thumbUrl" : @"http://img.youtube.com/vi/l0su0qTwsuA/default.jpg"};
    
    // Scream Screen
    NSDictionary *videoItem2 = @{@"title" : @"Ultimatum - 2013", @"duration" : @"3:00", @"videoUrl" : @"http://vimeo.com/79647932", @"thumbUrl" : @"http://i.vimeocdn.com/video/455392983_100x75.jpg"};
    NSDictionary *videoItem3 = @{@"title" : @"Unconsumed - 2011", @"duration" : @"3:00", @"videoUrl" : @"https://www.youtube.com/watch?v=pZw3igUKDJU", @"thumbUrl" : @"http://img.youtube.com/vi/pZw3igUKDJU/default.jpg"};
    
    // Scream Screen video entries
    [videoEntries addObject:videoItem2];
    [videoEntries addObject:videoItem3];
    
    // Other video entries
    [otherVideos addObject:videoItem1];
}

@end
