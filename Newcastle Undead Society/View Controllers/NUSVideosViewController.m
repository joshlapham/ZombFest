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
    headerLabel.textColor = [UIColor colorWithRed:0.46 green:0.19 blue:0.18 alpha:1];
    headerLabel.adjustsFontSizeToFitWidth = YES;
    headerLabel.textAlignment = NSTextAlignmentCenter;
    
    // Set header label font
    UIFont *headerLabelFont = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20];
    headerLabel.font = headerLabelFont;
    
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
    
    // Set author and year
    NSString *byString = NSLocalizedString(@"By", nil);
    authorLabel.text = [NSString stringWithFormat:@"%@ %@", byString, cellData.author];
    yearLabel.text = cellData.year;
    
    // Set cell thumbnail using SDWebImage
    [cellImageView setImageWithURL:[NSURL URLWithString:cellData.thumbUrl]
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
    
    NUSVideo *cellData = [sectionContents objectAtIndex:indexPath.row];
    
    // Init string with title of social link
    NSString *videoLinkTitle = cellData.title;
    
    // Init NSURL with video link URL from cellArray
    NSURL *videoLinkUrl = [NSURL URLWithString:cellData.videoUrl];
    
    // Initialize the web view controller and set its' URL
    PBWebViewController *webViewController = [[PBWebViewController alloc] init];
    webViewController.URL = videoLinkUrl;
    webViewController.title = videoLinkTitle;
    
    // Set back button of navbar to have no text
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    // Show web view controller with video link
    [self.navigationController pushViewController:webViewController animated:YES];
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
        
        // Set tableView background colour
        [self.tableView setBackgroundColor:[UIColor colorWithRed:0.76 green:0.76 blue:0.76 alpha:1]];
        
        // Set tableView to have a bit of padding at the top so section header looks right
        [self.tableView setContentInset:UIEdgeInsetsMake(20, 0, 0, 0)];
    }
    return self;
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
