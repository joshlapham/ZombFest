//
//  NUSAboutViewController.m
//  Newcastle Undead Society
//
//  Created by jl on 4/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSAboutViewController.h"
#import "NUSDataStore.h"
#import "NUSAboutContent.h"

@interface NUSAboutViewController () {
    NSMutableArray *cellArray;
}

@end

@implementation NUSAboutViewController

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
    return 600;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AboutCell" forIndexPath:indexPath];
    
    NUSAboutContent *cellData = [cellArray objectAtIndex:indexPath.row];
    
    // Set cell background colour
    // White (Gallery)
    [cell setBackgroundColor:[UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1]];
    
    // Disable tapping of cells
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    // Init cell labels
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:101];
    UILabel *contentLabel = (UILabel *)[cell viewWithTag:102];
    
    // Ensure title and content fit in their respective labels
    titleLabel.adjustsFontSizeToFitWidth = YES;
    contentLabel.numberOfLines = 0;
    
    // Set font colour of titleLabel
    // Dark Pastel Red
    titleLabel.textColor = [UIColor colorWithRed:0.75 green:0.22 blue:0.17 alpha:1];
    
    // Set font of titleLabel
    UIFont *titleFont = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20];
    titleLabel.font = titleFont;
    
    // Set font of content label
    UIFont *contentFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    contentLabel.font = contentFont;
    
    // Set cell text
    // TODO: localize content for About section
    titleLabel.text = cellData.title;
    contentLabel.text = cellData.content;
    
    return cell;
}

#pragma mark - Init method

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Turn off navbar translucency
    [self.navigationController.navigationBar setTranslucent:NO];
    
    // Set title
    self.title = NSLocalizedString(@"About", nil);
    
    // Register cell with tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"NUSAboutCell" bundle:nil] forCellReuseIdentifier:@"AboutCell"];
    
    // Remove seperator insets from tableView
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    // Set tableView background colour
    // White (Gallery)
    [self.tableView setBackgroundColor:[UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1]];
    
    // Init cellArray data source
    [self initCellArrayDataSource];
}

#pragma mark - Init cellArray data source

- (void)initCellArrayDataSource
{
    cellArray = [NSMutableArray arrayWithArray:[NUSDataStore returnAboutSectionContent]];
}

@end
