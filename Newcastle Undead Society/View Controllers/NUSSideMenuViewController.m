//
//  NUSSideMenuViewController.m
//  Newcastle Undead Society
//
//  Created by jl on 5/04/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSSideMenuViewController.h"
#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"
#import "NUSNewsFeedViewController.h"

@interface NUSSideMenuViewController () {
    NSArray *cellArray;
}

@end

@implementation NUSSideMenuViewController

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cellArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell" forIndexPath:indexPath];
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            // News was selected
            self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[NUSNewsFeedViewController alloc] init]];
            break;
            
        default:
            break;
    }
}

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = [cellArray objectAtIndex:indexPath.row];
}

#pragma mark - init methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Init cellArray
    cellArray = [NSArray arrayWithObjects:@"News", @"About", @"Past Events", @"Videos", @"Contact", nil];
    
    // Set background colour of menu to dark gray
    [self.tableView setBackgroundColor:[UIColor darkGrayColor]];
}

@end
