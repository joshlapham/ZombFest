//
//  NUSGalleryViewController.m
//  Newcastle Undead Society
//
//  Created by jl on 4/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSGalleryViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface NUSGalleryViewController () {
    NSMutableArray *cellArray;
}

@end

@implementation NUSGalleryViewController

#pragma mark - UITableViewDataSource delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cellArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Past Events";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GalleryTitleCell" forIndexPath:indexPath];
    
    // Init cell labels
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:102];
    UIImageView *cellImageView = (UIImageView *)[cell viewWithTag:101];
    
    // Scale image to fill cell
    cellImageView.contentMode = UIViewContentModeScaleToFill;
    
    // Set cell title
    titleLabel.text = [[cellArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    // Set cell thumbnail using SDWebImage
    [cellImageView setImageWithURL:[NSURL URLWithString:[[cellArray objectAtIndex:indexPath.row] objectForKey:@"imageUrl"]]
                                             placeholderImage:nil
                                                    completed:^(UIImage *cellImage, NSError *error, SDImageCacheType cacheType) {
                                                        if (cellImage && !error) {
                                                            //DDLogVerbose(@"Comix: fetched comic thumbnail image");
                                                        } else {
                                                            //DDLogError(@"Comix: error fetching comic thumbnail image: %@", [error localizedDescription]);
                                                        // TODO: implement fallback
                                                        }
                                                    }];
    
    return cell;
}

#pragma mark - Init methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set title
    self.title = @"Gallery";
    
    // Register cell with tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"NUSGalleryTitleCell" bundle:nil] forCellReuseIdentifier:@"GalleryTitleCell"];
    
    // Init cellArray data source
    [self initCellArrayDataSource];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    // Turn off navbar translucency
    [self.navigationController.navigationBar setTranslucent:NO];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    // Init with grouped table style
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if (self) {
        // Remove seperator insets from tableView
        // TODO - IS working, but images have a line in-between?
        [self.tableView setSeparatorColor:[UIColor clearColor]];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return self;
}

#pragma mark - Init cellArray data source

- (void)initCellArrayDataSource
{
    cellArray = [[NSMutableArray alloc] init];
    
    NSDictionary *galleryItem1 = @{@"title" : @"2013", @"imageUrl" : @"https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/1453493_658726834172236_1271715398_n.jpg"};
    NSDictionary *galleryItem2 = @{@"title" : @"2012", @"imageUrl" : @"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/536424_474541165924138_1749738981_n.jpg"};
    NSDictionary *galleryItem3 = @{@"title" : @"2011", @"imageUrl" : @"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/315710_259496494095274_1257647121_n.jpg"};
    // NOTE - actually using a 2009 image for 2010
    NSDictionary *galleryItem4 = @{@"title" : @"2010", @"imageUrl" : @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/262887_224862680891989_6260150_n.jpg"};
    NSDictionary *galleryItem5 = @{@"title" : @"2009", @"imageUrl" : @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/33518_127658320612426_6225652_n.jpg"};
    
    [cellArray addObject:galleryItem1];
    [cellArray addObject:galleryItem2];
    [cellArray addObject:galleryItem3];
    [cellArray addObject:galleryItem4];
    [cellArray addObject:galleryItem5];
}

@end
