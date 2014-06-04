//
//  NUSSideMenuViewController.m
//  Newcastle Undead Society
//
//  Created by jl on 5/04/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSSideMenuViewController.h"

@interface NUSSideMenuViewController () {
    NSArray *cellArray;
}

@end

@implementation NUSSideMenuViewController

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MenuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //if (cell == nil)  {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
        
        cell.textLabel.text = [cellArray objectAtIndex:indexPath.row];
    //}
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return cellArray.count;
}

#pragma mark - init methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // init cellArray
    cellArray = [NSArray arrayWithObjects:@"Events", @"About", @"Gallery", @"Videos", @"Contact", nil];
}

@end
