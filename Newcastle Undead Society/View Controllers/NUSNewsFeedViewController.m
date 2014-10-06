//
//  NUSNewsFeedViewController.m
//  Newcastle Undead Society
//
//  Created by jl on 4/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSNewsFeedViewController.h"
#import "NUSDataStore.h"
#import "NUSNewsItem.h"
#import "PBWebViewController.h"

@interface NUSNewsFeedViewController () {
    NSMutableArray *_cellArray;
}

@property (nonatomic, strong) UITableViewCell *prototypeCell;

@end

@implementation NUSNewsFeedViewController

#pragma mark - UITableViewDataSource delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_cellArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.prototypeCell) {
        self.prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"NewsFeedCell"];
    }
    
    [self configureCell:self.prototypeCell forRowAtIndexPath:indexPath];
    
    [self.prototypeCell layoutIfNeeded];
    CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    // TODO:
    // Check if iOS 8 and add +1 to the height, as iOS 8 is removing -1 from the cell height
    // and screwing with the contentLabel text.
    // NOTE: this is pretty hacky, improve this!
    float osVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (osVersion >= 8.0) {
        // Running iOS 8 or higher, so add +1 to the cell height
        return size.height + 1;
    } else {
        // Running iOS 7, so just return the height normally
        return size.height;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"NewsFeedCell"];
    
    // Configure the cell
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NUSNewsItem *cellData = [_cellArray objectAtIndex:indexPath.row];
    
    // Set cell background colour
    [cell setBackgroundColor:[UIColor backgroundColorForMostViews]];
    
    // Init cell labels
    UILabel *titleLabel = titleLabel = (UILabel *)[cell viewWithTag:101];
    UILabel *contentLabel = (UILabel *)[cell viewWithTag:102];
    UILabel *dateLabel = (UILabel *)[cell viewWithTag:103];
    
    // Ensure content fits in label
    [contentLabel setNumberOfLines:0];
    [contentLabel setLineBreakMode:NSLineBreakByWordWrapping];
    //contentLabel.adjustsFontSizeToFitWidth = YES;
    
    // Ensure content fits in title label
    [titleLabel setAdjustsFontSizeToFitWidth:YES];
    
    // Set text colour of title and date labels
    titleLabel.textColor = [UIColor newsFeedItemTitleColour];
    dateLabel.textColor = [UIColor newsFeedItemDateColour];
    
    // Set font of titleLabel
    UIFont *titleFont = [UIFont newsFeedItemTitleFont];
    titleLabel.font = titleFont;
    
    // Set font of date and content labels
    UIFont *sharedDateAndContentFont = [UIFont newsFeedItemDateFont];
    dateLabel.font = sharedDateAndContentFont;
    contentLabel.font = sharedDateAndContentFont;
    
    // Set label text
    titleLabel.text = cellData.title;
    contentLabel.text = cellData.content;
    dateLabel.text = cellData.date;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NUSNewsItem *cellData = [_cellArray objectAtIndex:indexPath.row];
    
    // Init NSURL with social link URL from cellArray
    NSURL *newsLinkUrl = [NSURL URLWithString:cellData.url];
    
    // Initialize the web view controller and set its' URL and title
    PBWebViewController *webViewController = [[PBWebViewController alloc] init];
    webViewController.URL = newsLinkUrl;
    // TODO: what to use for title?
    //webViewController.title = @"News";
    
    // Set back button of navbar
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"News", nil) style:UIBarButtonItemStylePlain target:nil action:nil];
    
    // Show web view controller with social media link
    [self.navigationController pushViewController:webViewController animated:YES];
}

#pragma mark - Init method

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Turn off navbar translucency
    [self.navigationController.navigationBar setTranslucent:NO];
    
    // Set title
    self.title = NSLocalizedString(@"News", nil);
    
    // Register cell with tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"NUSNewsFeedCell" bundle:nil] forCellReuseIdentifier:@"NewsFeedCell"];
    
    // Make tableView seperator insets extend to edges
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    
    // Set tableView background colour
    [self.tableView setBackgroundColor:[UIColor backgroundColorForMostViews]];
    
    // Init cellArray data source
    [self initCellArrayDataSource];
}

#pragma mark - Init cellArray data source

- (void)initCellArrayDataSource
{
    _cellArray = [NSMutableArray arrayWithArray:[NUSDataStore returnNewsItemsFromCache]];
}

@end
