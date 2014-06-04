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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Social Media";
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
    
    // Show web view controller with social media link
    [self.navigationController pushViewController:webViewController animated:YES];
}

#pragma mark - Init methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set title
    self.title = @"Contact";
    
    // Register cell with tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"NUSContactCell" bundle:nil] forCellReuseIdentifier:@"ContactCell"];
    
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
