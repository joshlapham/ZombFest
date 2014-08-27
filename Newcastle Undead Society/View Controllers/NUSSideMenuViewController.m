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
    NSMutableArray *_cellArray;
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
    return [_cellArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell" forIndexPath:indexPath];
    
    // Set cell background colour
    [cell setBackgroundColor:[UIColor sidemenuItemColour]];
    
    // Init cell labels
    UILabel *menuItemTitle = (UILabel *)[self.view viewWithTag:101];
    UIImageView *menuItemImage = (UIImageView *)[self.view viewWithTag:102];
    
    // Set cell font and colour
    UIFont *cellFont = [UIFont sidebarMenuItemFont];
    menuItemTitle.font = cellFont;
    menuItemTitle.textColor = [UIColor sidemenuItemFontColour];
    
    // Set cell contents
    menuItemTitle.text = [_cellArray objectAtIndex:indexPath.row];
    
    // Set cell image
    [menuItemImage setTintColor:[UIColor newsFeedItemTitleColour]];
    menuItemImage.image = [self returnMenuItemImageForCellAtRow:indexPath.row];
    
    return cell;
}

- (UIImage *)returnMenuItemImageForCellAtRow:(NSInteger)row
{
    switch (row) {
        case 0:
            // News
            return [UIImage imageNamed:@"menu-news"];
            break;
            
        case 1:
            // About
            return [UIImage imageNamed:@"menu-about"];
            break;
            
        case 2:
            // Events
            return [UIImage imageNamed:@"menu-events"];
            break;
            
        case 3:
            // Videos
            return [UIImage imageNamed:@"menu-videos"];
            break;
            
        case 4:
            // Contact
            return [UIImage imageNamed:@"menu-contact"];
            break;
            
        default:
            break;
    }
    // Return nil if nothing found
    // TODO: review this
    return nil;
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
    
    // Turn off navbar translucency
    [self.navigationController.navigationBar setTranslucent:NO];
    
    // Set background colour of tableView
    [self.tableView setBackgroundColor:[UIColor sidemenuBackgroundColour]];
    [self.tableView setScrollEnabled:NO];
    
    // Set navbar colour
    [self.navigationController.navigationBar setBarTintColor:[UIColor sidemenuNavbarColour]];
    
    // Init cellArray data source
    [self initCellArrayDataSource];
}

#pragma mark - Init cellArray data source

- (void)initCellArrayDataSource
{
    _cellArray = [[NSMutableArray alloc] init];
    
    NSString *newsMenuItem = NSLocalizedString(@"News", nil);
    NSString *aboutMenuItem = NSLocalizedString(@"About", nil);
    NSString *eventsMenuItem = NSLocalizedString(@"Events", nil);
    NSString *videosMenuItem = NSLocalizedString(@"Videos", nil);
    NSString *contactMenuItem = NSLocalizedString(@"Contact", nil);
    
    [_cellArray addObject:newsMenuItem];
    [_cellArray addObject:aboutMenuItem];
    [_cellArray addObject:eventsMenuItem];
    [_cellArray addObject:videosMenuItem];
    [_cellArray addObject:contactMenuItem];
}

@end
