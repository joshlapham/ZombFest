//
//  NUSContactViewController.m
//  Newcastle Undead Society
//
//  Created by jl on 4/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSContactViewController.h"
#import "PBWebViewController.h"
#import "NUSDataStore.h"
#import "NUSSocialLink.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface NUSContactViewController () {
    NSMutableArray *cellArray;
}

@end

@implementation NUSContactViewController

#pragma mark - UITableViewDataSource delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cellArray count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // Since we only have one section, we can skip checking the section index
    NSString *headerText = NSLocalizedString(@"Social Media", nil);
    
    // Init custom header view
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 20)];
    
    // Init header label
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:headerView.bounds];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.adjustsFontSizeToFitWidth = YES;
    headerLabel.textAlignment = NSTextAlignmentCenter;
    
    // Set header label font colour
    // Dark Pastel Red
    headerLabel.textColor = [UIColor colorWithRed:0.75 green:0.22 blue:0.17 alpha:1];
    
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
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell" forIndexPath:indexPath];
    
    // Set cell background colour
    // White (Gallery)
    [cell setBackgroundColor:[UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1]];
    
    // Init cell labels
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:101];
    UIImageView *iconImage = (UIImageView *)[cell viewWithTag:102];
    
    NUSSocialLink *cellData = [cellArray objectAtIndex:indexPath.row];
    
    // Set link title font
    UIFont *titleFont = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18];
    titleLabel.font = titleFont;
    
    // Set cell text
    titleLabel.text = cellData.linkTitle;
    
    // Determine the placeholder image based on the link title
    UIImage *placeholderImage;
    
    if ([cellData.linkTitle isEqualToString:@"Facebook"]) {
        placeholderImage = [UIImage imageNamed:@"contact-facebook"];
    } else if ([cellData.linkTitle isEqualToString:@"Twitter"]) {
        placeholderImage = [UIImage imageNamed:@"contact-twitter"];
    } else if ([cellData.linkTitle isEqualToString:@"Tumblr"]) {
        placeholderImage = [UIImage imageNamed:@"contact-tumblr"];
    } else {
        placeholderImage = nil;
    }
    
    // Set cell thumbnail using SDWebImage
    [iconImage sd_setImageWithURL:[NSURL URLWithString:cellData.linkImageUrl]
                 placeholderImage:placeholderImage
                          options:SDWebImageRetryFailed
                        completed:^(UIImage *cellImage, NSError *error, SDImageCacheType cacheType, NSURL *imageUrl) {
                            if (error) {
                                DDLogError(@"Contact: error fetching cell thumbnail image: %@", [error localizedDescription]);
                            }
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NUSSocialLink *cellData = [cellArray objectAtIndex:indexPath.row];
    
    // Init NSURL with social link URL from cellArray
    NSURL *socialLinkUrl = [NSURL URLWithString:cellData.linkUrl];
    
    // Initialize the web view controller and set its' URL and title
    PBWebViewController *webViewController = [[PBWebViewController alloc] init];
    webViewController.URL = socialLinkUrl;
    webViewController.title = cellData.linkTitle;
    
    // Set back button text
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Contact", nil) style:UIBarButtonItemStylePlain target:nil action:nil];
    
    // Show web view controller with social media link
    [self.navigationController pushViewController:webViewController animated:YES];
}

#pragma mark - Data fetch did happen NSNotifcation method

- (void)dataFetchDidHappen
{
    DDLogVerbose(@"Contact VC: was notified that data fetch did happen");
    
    // Reload cellArray data source
    [self initCellArrayDataSource];
    
    // Reload tableView with new data
    [self.tableView reloadData];
}

#pragma mark - Init methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set title
    self.title = NSLocalizedString(@"Contact", nil);
    
    // Register cell with tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"NUSContactCell" bundle:nil] forCellReuseIdentifier:@"ContactCell"];
    
    // Make tableView seperator insets extend to edges
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    
    // Register for data fetch did happen NSNotification
    NSString *notificationName = @"NUSDataFetchDidHappen";
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dataFetchDidHappen)
                                                 name:notificationName
                                               object:nil];
    
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
        // Set tableView background colour
        // White (Gallery)
        [self.tableView setBackgroundColor:[UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1]];
        
        // Set tableView to have a bit of padding at the top so section header looks right
        [self.tableView setContentInset:UIEdgeInsetsMake(20, 0, 0, 0)];
        
        // Disable scrolling on tableView
        [self.tableView setScrollEnabled:NO];
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
    cellArray = [[NSMutableArray alloc] initWithArray:[NUSDataStore returnSocialMediaLinksFromCache]];
}

@end
