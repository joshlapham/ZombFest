//
//  NUSGalleryViewController.m
//  Newcastle Undead Society
//
//  Created by jl on 4/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSGalleryViewController.h"

@interface NUSGalleryViewController () {
    NSMutableArray *cellArray;
}

@end

@implementation NUSGalleryViewController

#pragma mark - UITableViewDataSource

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
    return 110;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *titleToReturn;
    
    switch (section) {
        case 0:
            // First and only section
            titleToReturn = @"Past Events";
            break;
            
        default:
            titleToReturn = nil;
            break;
    }
    return titleToReturn;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GalleryTitleCell" forIndexPath:indexPath];
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:102];
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:101];
    
    titleLabel.text = [cellArray objectAtIndex:indexPath.row];
    
    NSLog(@"cell array: %@", [cellArray objectAtIndex:indexPath.row]);
    
    return cell;
}

#pragma mark - Init methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set title
    self.title = @"Gallery";
    
    // Register cell with tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"NUSGalleryTitleCell" bundle:nil] forCellReuseIdentifier:@"GalleryTitleCell"];
    
    // Init cellArray data source
    [self initCellArrayDataSource];
    
    //[self.tableView set]
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if (!self) {
        // Init code
    }
    return self;
}

#pragma mark - Init cellArray data source

- (void)initCellArrayDataSource
{
    cellArray = [[NSMutableArray alloc] init];
    
    [cellArray addObject:@"2013"];
    [cellArray addObject:@"2012"];
    [cellArray addObject:@"2011"];
    [cellArray addObject:@"2010"];
}

@end
