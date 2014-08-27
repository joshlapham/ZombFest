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

#pragma mark - Init method

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Turn off navbar translucency
    [self.navigationController.navigationBar setTranslucent:NO];
    
    // Set title
    self.title = NSLocalizedString(@"About", nil);
    
    // Init cellArray data source
    [self initCellArrayDataSource];
    NUSAboutContent *cellData = [cellArray firstObject];
    
    // Init UITextView
    UITextView *aboutContentView = [[UITextView alloc] initWithFrame:self.view.frame];
    [aboutContentView setFont:[UIFont aboutContentFont]];
    [aboutContentView setEditable:NO];
    [aboutContentView setSelectable:NO];
    // top, left, bottom, right
    [aboutContentView setTextContainerInset:UIEdgeInsetsMake(10, 10, 80, 10)];
    // Set text
    [aboutContentView setText:cellData.content];
    
    // Set background colours
    [self.view setBackgroundColor:[UIColor backgroundColorForMostViews]];
    [aboutContentView setBackgroundColor:[UIColor backgroundColorForMostViews]];
    
    // Add aboutContentView to view
    [self.view addSubview:aboutContentView];
}

#pragma mark - Init cellArray data source

- (void)initCellArrayDataSource
{
    cellArray = [NSMutableArray arrayWithArray:[NUSDataStore returnAboutSectionContent]];
}

@end
