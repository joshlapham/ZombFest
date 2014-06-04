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
#import "NUSGalleryViewController.h"
#import "NUSAboutViewController.h"
#import "NUSContactViewController.h"

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
            
        case 1:
            // About was selected
            self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[NUSAboutViewController alloc] init]];
            break;
            
        case 2:
            // Gallery was selected
            self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[NUSGalleryViewController alloc] init]];
            break;
            
        case 3:
            // Videos was selected
            // Code here ..
            break;
            
        case 4:
            // Contact was selected
            self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[NUSContactViewController alloc] init]];
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
    cellArray = [NSArray arrayWithObjects:@"News", @"About", @"Gallery", @"Videos", @"Contact", nil];
    
    // Set background colour of menu to dark gray
    [self.tableView setBackgroundColor:[UIColor darkGrayColor]];
}

@end
