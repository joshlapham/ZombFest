//
//  NUSContactViewController.m
//  Newcastle Undead Society
//
//  Created by jl on 4/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSContactViewController.h"
#import "PBWebViewController.h"

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
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell" forIndexPath:indexPath];
    
    // Init cell labels
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:101];
    UIImageView *iconImage = (UIImageView *)[cell viewWithTag:102];
    
    // Set cell text and image
    titleLabel.text = [[cellArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    iconImage.image = [UIImage imageNamed:[[cellArray objectAtIndex:indexPath.row] objectForKey:@"image"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Init string with title of social link
    NSString *socialLinkTitle = [[cellArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    // Init NSURL with social link URL from cellArray
    NSURL *socialLinkUrl = [NSURL URLWithString:[[cellArray objectAtIndex:indexPath.row] objectForKey:@"url"]];
    
    // Initialize the web view controller and set its' URL
    PBWebViewController *webViewController = [[PBWebViewController alloc] init];
    webViewController.URL = socialLinkUrl;
    webViewController.title = socialLinkTitle;
    
    // Set back button of navbar to have no text
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    // Show web view controller with social media link
    [self.navigationController pushViewController:webViewController animated:YES];
}

#pragma mark - Init methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set title
    self.title = NSLocalizedString(@"Contact", nil);
    
    // Register cell with tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"NUSContactCell" bundle:nil] forCellReuseIdentifier:@"ContactCell"];
    
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
        //[self.tableView setSeparatorColor:[UIColor clearColor]];
        //[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        // Set tableView background colour
        [self.tableView setBackgroundColor:[UIColor colorWithRed:0.76 green:0.76 blue:0.76 alpha:1]];
        
        // Set tableView to have a bit of padding at the top so section header looks right
        [self.tableView setContentInset:UIEdgeInsetsMake(20, 0, 0, 0)];
        
        // Disable scrolling on tableView
        [self.tableView setScrollEnabled:NO];
    }
    return self;
}

#pragma mark - Init cellArray data source

- (void)initCellArrayDataSource
{
    cellArray = [[NSMutableArray alloc] init];
    
    NSDictionary *socialLink1 = @{@"title" : @"Facebook", @"url" : @"https://www.facebook.com/NewcastleUndeadSociety", @"image" : @"facebook-128-black.png"};
    NSDictionary *socialLink2 = @{@"title" : @"Twitter", @"url" : @"https://twitter.com/undeadsociety", @"image" : @"twitter-128-black.png"};
    NSDictionary *socialLink3 = @{@"title" : @"Tumblr", @"url" : @"http://newcastleundeadsociety.tumblr.com/", @"image" : @"tumblr-128-black.png"};
    
    [cellArray addObject:socialLink1];
    [cellArray addObject:socialLink2];
    [cellArray addObject:socialLink3];
}

@end
