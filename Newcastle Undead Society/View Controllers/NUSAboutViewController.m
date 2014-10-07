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
    
    // Init UIScrollView
    UIScrollView *aboutContentScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    
    // Init imageView
    UIImageView *aboutImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, aboutContentScrollView.frame.size.width, 150)];
    
    // Set image
    [aboutImage setImageWithURL:[NSURL URLWithString:cellData.imageUrl]
               placeholderImage:nil
                      completed:^(UIImage *cellImage, NSError *error, SDImageCacheType cacheType) {
                          if (cellImage && !error) {
                              DDLogVerbose(@"About: did finish fetching image");
                          } else {
                              DDLogError(@"About: error fetching image for above About content: %@", [error localizedDescription]);
                              // TODO: implement fallback
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

#pragma mark - Init cellArray data source

- (void)initCellArrayDataSource
{
    cellArray = [NSMutableArray arrayWithArray:[NUSDataStore returnAboutSectionContent]];
}

@end
