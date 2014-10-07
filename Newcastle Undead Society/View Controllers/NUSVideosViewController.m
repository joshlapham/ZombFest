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
#import "NUSDataStore.h"
#import "NUSVideo.h"

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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *headerText;
    
    switch (section) {
        case 0:
            // Scream Screen winners
            headerText = NSLocalizedString(@"Scream Screen Winners", nil);
            break;
            
        case 1:
            // Scream Screen entries
            headerText = NSLocalizedString(@"Scream Screen Entrants", nil);
            break;
            
        case 2:
            // Other Videos section
            headerText = NSLocalizedString(@"Other Videos", nil);
            break;
            
        default:
            headerText = nil;
            break;
    }
    
    // Init custom header view
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 20)];
    
    // Init header label
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:headerView.bounds];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.adjustsFontSizeToFitWidth = YES;
    headerLabel.textAlignment = NSTextAlignmentCenter;
    
    // Set header label font
    UIFont *headerLabelFont = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20];
    headerLabel.font = headerLabelFont;
    
    // Set colour of header label font
    // Dark Pastel Red
    headerLabel.textColor = [UIColor colorWithRed:0.75 green:0.22 blue:0.17 alpha:1];
    
    // Set header label text
    headerLabel.text = headerText;
    
    [headerView addSubview:headerLabel];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoCell" forIndexPath:indexPath];
    
    // Set cell background colour
    // White (Gallery)
    [cell setBackgroundColor:[UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1]];
    
    NSArray *sectionContents = [cellArray objectAtIndex:indexPath.section];
    
    NUSVideo *cellData = [sectionContents objectAtIndex:indexPath.row];
    
    // Init cell labels
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:101];
    UILabel *durationLabel = (UILabel *)[cell viewWithTag:102];
    UIImageView *cellImageView = (UIImageView *)[cell viewWithTag:103];
    UILabel *authorLabel = (UILabel *)[cell viewWithTag:104];
    UILabel *yearLabel = (UILabel *)[cell viewWithTag:105];
    
    // Ensure things fit in labels
    titleLabel.adjustsFontSizeToFitWidth = YES;
    authorLabel.adjustsFontSizeToFitWidth = YES;
    
    // Set video title and duration
    titleLabel.text = cellData.title;
    durationLabel.text = cellData.duration;
    
    // Set video title font
    UIFont *titleFont = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18];
    titleLabel.font = titleFont;
    
    // Set video author font
    UIFont *authorFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    authorLabel.font = authorFont;
    
    // Set year and duration font
    UIFont *sharedYearAndDurationFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    yearLabel.font = sharedYearAndDurationFont;
    durationLabel.font = sharedYearAndDurationFont;
    
    // Set author and year
    NSString *byString = NSLocalizedString(@"By", nil);
    authorLabel.text = [NSString stringWithFormat:@"%@ %@", byString, cellData.author];
    yearLabel.text = cellData.year;
    
    // Set cell thumbnail using SDWebImage
    [cellImageView sd_setImageWithURL:[NSURL URLWithString:cellData.thumbUrl]
                     placeholderImage:[UIImage imageNamed:@"video-thumb-placeholder"]
                              options:SDWebImageRetryFailed
                            completed:^(UIImage *cellImage, NSError *error, SDImageCacheType cacheType, NSURL *imageUrl) {
                                if (error) {
                                    DDLogError(@"Videos: error fetching cell thumbnail image: %@", [error localizedDescription]);
                                }
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *sectionContents = [cellArray objectAtIndex:indexPath.section];
    
    NUSVideo *cellData = [sectionContents objectAtIndex:indexPath.row];
    
    // Init string with title of social link
    NSString *videoLinkTitle = cellData.title;
    
    // Init NSURL with video link URL from cellArray
    NSURL *videoLinkUrl = [NSURL URLWithString:cellData.videoUrl];
    
    // Initialize the web view controller and set its' URL
    PBWebViewController *webViewController = [[PBWebViewController alloc] init];
    webViewController.URL = videoLinkUrl;
    webViewController.title = videoLinkTitle;
    
    // Set back button text
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Videos", nil) style:UIBarButtonItemStylePlain target:nil action:nil];
    
    // Show web view controller with video link
    [self.navigationController pushViewController:webViewController animated:YES];
}

#pragma mark - Data fetch did happen NSNotifcation method

- (void)dataFetchDidHappen
{
    DDLogVerbose(@"Videos VC: was notified that data fetch did happen");
    
    // Reload cellArray data source
    [self initCellArrayDataSource];
    
    // Reload tableView with new data
    [self.tableView reloadData];
}

#pragma mark - Init methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Turn off navbar translucency
    [self.navigationController.navigationBar setTranslucent:NO];
    
    // Set title
    self.title = NSLocalizedString(@"Videos", nil);
    
    // Register cell with tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"NUSVideoCell" bundle:nil] forCellReuseIdentifier:@"VideoCell"];
    
    // Make tableView seperator insets extend to edges
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    
    // Register for dataFetchDidHappen NSNotification
    NSString *notificationName = @"NUSDataFetchDidHappen";
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dataFetchDidHappen)
                                                 name:notificationName
                                               object:nil];
    
    // Init cellArray data source
    [self initCellArrayDataSource];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    // Init with grouped table style
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if (self) {
        // Set tableView background colour
        // White (Gallery)
        [self.tableView setBackgroundColor:[UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1]];
        
        // Set tableView to have a bit of padding at the top so section header looks right
        [self.tableView setContentInset:UIEdgeInsetsMake(20, 0, 0, 0)];
    }
    return self;
}

- (void)dealloc
{
    // Remove NSNotification observers
    NSString *notificationName = @"NUSDataFetchDidHappen";
    [[NSNotificationCenter defaultCenter] removeObserver:self name:notificationName object:nil];
}

#pragma mark - Init cellArray data source

- (void)initCellArrayDataSource
{
    // Init arrays
    cellArray = [[NSMutableArray alloc] init];
    videoEntries = [NSMutableArray arrayWithArray:[NUSDataStore returnEntrantVideosFromCache]];
    videoWinners = [NSMutableArray arrayWithArray:[NUSDataStore returnWinningVideosFromCache]];
    otherVideos = [NSMutableArray arrayWithArray:[NUSDataStore returnOtherVideosFromCache]];
    
    [cellArray addObject:videoWinners];
    [cellArray addObject:videoEntries];
    [cellArray addObject:otherVideos];
}

@end
