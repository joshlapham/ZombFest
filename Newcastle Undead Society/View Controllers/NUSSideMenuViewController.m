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
#import "NUSEventListViewController.h"
#import "NUSAboutViewController.h"
#import "NUSContactViewController.h"
#import "NUSVideosViewController.h"

@interface NUSSideMenuViewController () {
    NSMutableArray *cellArray;
}

@end

@implementation NUSSideMenuViewController

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
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell" forIndexPath:indexPath];
    
    // Set cell background colour
    // Lynch
    [cell setBackgroundColor:[UIColor colorWithRed:0.42 green:0.48 blue:0.54 alpha:1]];
    
    // Set cell font
    UIFont *cellFont = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20];
    cell.textLabel.font = cellFont;
    
    cell.textLabel.text = [cellArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Deselect so menu item doesn't stay selected
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
            // Events was selected
            self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[NUSEventListViewController alloc] init]];
            break;
            
        case 3:
            // Videos was selected
            self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[NUSVideosViewController alloc] init]];
            break;
            
        case 4:
            // Contact was selected
            self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[NUSContactViewController alloc] init]];
            break;
            
        default:
            break;
    }
}

#pragma mark - init methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set title
    //self.title = NSLocalizedString(@"Menu", nil);
    //self.title = NSLocalizedString(@"Newcastle Undead Society", @"Name of the organization");
    
    // Turn off navbar translucency
    [self.navigationController.navigationBar setTranslucent:NO];
    
    // Set background colour of tableView
    // Lynch
    [self.tableView setBackgroundColor:[UIColor colorWithRed:0.42 green:0.48 blue:0.54 alpha:1]];
    
    [self.tableView setScrollEnabled:NO];
    
    // Set navbar colour
    // Lynch
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.42 green:0.48 blue:0.54 alpha:1]];
    
    // Init cellArray data source
    [self initCellArrayDataSource];
}

#pragma mark - Init cellArray data source

- (void)initCellArrayDataSource
{
    cellArray = [[NSMutableArray alloc] init];
    
    NSString *newsMenuItem = NSLocalizedString(@"News", nil);
    NSString *aboutMenuItem = NSLocalizedString(@"About", nil);
    NSString *eventsMenuItem = NSLocalizedString(@"Events", nil);
    NSString *videosMenuItem = NSLocalizedString(@"Videos", nil);
    NSString *contactMenuItem = NSLocalizedString(@"Contact", nil);
    
    [cellArray addObject:newsMenuItem];
    [cellArray addObject:aboutMenuItem];
    [cellArray addObject:eventsMenuItem];
    [cellArray addObject:videosMenuItem];
    [cellArray addObject:contactMenuItem];
}

@end
