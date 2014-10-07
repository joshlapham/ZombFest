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
#import <SDWebImage/UIImageView+WebCache.h>

@interface NUSAboutViewController () {
    NSMutableArray *cellArray;
}

@end

@implementation NUSAboutViewController

#pragma mark - Data fetch did happen NSNotifcation method

- (void)dataFetchDidHappen
{
    // NOTE: this method currently does nothing except the below log message
    
    DDLogVerbose(@"About VC: was notified that data fetch did happen");
    
    // TODO: reload view with newly fetched data,
    // which will require a refactor of viewDidLoad
    
    // Reload cellArray data source
    //[self initCellArrayDataSource];
}

#pragma mark - Init methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Turn off navbar translucency
    [self.navigationController.navigationBar setTranslucent:NO];
    
    // Set title
    self.title = NSLocalizedString(@"About", nil);
    
    // Register for dataFetchDidHappen NSNotification
    NSString *notificationName = @"NUSDataFetchDidHappen";
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dataFetchDidHappen)
                                                 name:notificationName
                                               object:nil];
    
    // Init cellArray data source
    [self initCellArrayDataSource];
    NUSAboutContent *cellData = [cellArray firstObject];
    
    // Init UIScrollView
    UIScrollView *aboutContentScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    
    // Init imageView
    UIImageView *aboutImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, aboutContentScrollView.frame.size.width, 150)];
    
    // Set placeholder image
    UIImage *placeholderImage = [UIImage imageNamed:@"about_section_image"];
    
    // Set image
    [aboutImage sd_setImageWithURL:[NSURL URLWithString:cellData.imageUrl]
                  placeholderImage:placeholderImage
                           options:SDWebImageRetryFailed
                         completed:^(UIImage *cellImage, NSError *error, SDImageCacheType cacheType, NSURL *imageUrl) {
                             if (error) {
                                 DDLogError(@"About: error fetching image for About content: %@", [error localizedDescription]);
                             }
    }];
    
    // Init UITextView
    UITextView *aboutContentView = [[UITextView alloc] initWithFrame:aboutContentScrollView.frame];
    [aboutContentView setFont:[UIFont aboutContentFont]];
    [aboutContentView setEditable:NO];
    [aboutContentView setSelectable:NO];
    [aboutContentView setScrollEnabled:NO];
    // top, left, bottom, right
    [aboutContentView setTextContainerInset:UIEdgeInsetsMake(160, 10, 0, 10)];
    // Set text
    [aboutContentView setText:cellData.content];
    // So that everything fits nicely
    [aboutContentView sizeToFit];
    
    // Set background colours
    [self.view setBackgroundColor:[UIColor backgroundColorForMostViews]];
    [aboutContentView setBackgroundColor:[UIColor backgroundColorForMostViews]];
    [aboutContentScrollView setBackgroundColor:[UIColor backgroundColorForMostViews]];
    
    // Configure scroll view
    // TODO: review this, don't hardcode -60 to calculate contentSize
    [aboutContentScrollView setContentSize:CGSizeMake(self.view.frame.size.width, (aboutImage.frame.size.height + aboutContentView.frame.size.height)-60)];
    [aboutContentScrollView setScrollEnabled:YES];
    
    // Add everything to the view
    [aboutContentScrollView addSubview:aboutContentView];
    [aboutContentScrollView addSubview:aboutImage];
    [self.view addSubview:aboutContentScrollView];
}

- (void)dealloc
{
    // Remove NSNotification observers
    NSString *notificationName = @"NUSDataFetchDidHappen";
    [[NSNotificationCenter defaultCenter] removeObserver:self name:notificationName object:nil];
}

#pragma mark - Init cellArray data source

- (void)initCellArrayDataSource
{
    cellArray = [NSMutableArray arrayWithArray:[NUSDataStore returnAboutSectionContent]];
}

@end
