//
//  NUSAboutViewController.m
//  Newcastle Undead Society
//
//  Created by jl on 4/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSAboutViewController.h"

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
    
    // Disable tapping of cells
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    // Init cell labels
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:101];
    UILabel *contentLabel = (UILabel *)[cell viewWithTag:102];
    
    // Ensure title and content fit in their respective labels
    titleLabel.adjustsFontSizeToFitWidth = YES;
    contentLabel.numberOfLines = 0;
    
    // Set cell text
    titleLabel.text = @"About Newcastle Undead Society";
    contentLabel.text = [cellArray objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Init method

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set title
    self.title = @"About";
    
    // Register cell with tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"NUSAboutCell" bundle:nil] forCellReuseIdentifier:@"AboutCell"];
    
    // Init cellArray data source
    [self initCellArrayDataSource];
}

#pragma mark - Init cellArray data source

- (void)initCellArrayDataSource
{
    cellArray = [[NSMutableArray alloc] init];
    
    NSString *firstPara = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sagittis urna semper faucibus fermentum. Nulla ligula augue, cursus a adipiscing id, luctus eu orci. Duis vitae leo lacus. Donec hendrerit orci eu nibh convallis consectetur. Pellentesque ullamcorper gravida orci, at dapibus nulla tincidunt quis. Proin vestibulum vel leo sed rhoncus. Curabitur eleifend nunc dui, in sagittis tellus dapibus eu. Suspendisse interdum vulputate dui, eget semper dui viverra at. \r\rUt faucibus congue nibh eget mollis. Pellentesque sed est in turpis iaculis facilisis. Cras volutpat, felis in semper pharetra, dui eros tempus mauris, a tristique quam leo vel tortor. Donec accumsan a nibh at ultricies. Etiam et feugiat arcu. Praesent at auctor mauris. In ipsum felis, egestas eu lacus quis, dictum dignissim leo.";
    
    [cellArray addObject:firstPara];
}

@end
