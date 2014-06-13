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

@interface NUSNewsFeedViewController () {
    NSMutableArray *cellArray;
}

@end

@implementation NUSNewsFeedViewController

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
    return 220;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"NewsFeedCell" forIndexPath:indexPath];
    
    NUSNewsItem *cellData = [cellArray objectAtIndex:indexPath.row];
    
    // Set cell background colour
    [cell setBackgroundColor:[UIColor whiteColor]];
    
    // Disable tapping of cells
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    // Init cell labels
    UILabel *titleLabel = titleLabel = (UILabel *)[cell viewWithTag:101];
    UILabel *contentLabel = (UILabel *)[cell viewWithTag:102];
    UILabel *dateLabel = (UILabel *)[cell viewWithTag:103];
    
    // Ensure content fits in label
    contentLabel.numberOfLines = 0;
    //contentLabel.adjustsFontSizeToFitWidth = YES;
    
    // Set text colour of title and date labels
    titleLabel.textColor = [UIColor colorWithRed:0.46 green:0.19 blue:0.18 alpha:1];
    dateLabel.textColor = [UIColor darkGrayColor];
    
    // Set font of titleLabel
    UIFont *titleFont = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20];
    titleLabel.font = titleFont;
    
    // Set label text
    titleLabel.text = cellData.title;
    contentLabel.text = cellData.content;
    dateLabel.text = cellData.date;
    
    return cell;
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
    
    // Remove seperator insets from tableView
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    // Set tableView background colour
    [self.tableView setBackgroundColor:[UIColor colorWithRed:0.76 green:0.76 blue:0.76 alpha:1]];
    
    // Init cellArray data source
    [self initCellArrayDataSource];
}

#pragma mark - Init cellArray data source

- (void)initCellArrayDataSource
{
    cellArray = [NSMutableArray arrayWithArray:[NUSDataStore returnNewsItemsFromCache]];
}

@end
