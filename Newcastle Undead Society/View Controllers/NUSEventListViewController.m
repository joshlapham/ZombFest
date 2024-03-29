//
//  NUSEventListViewController.m
//  Newcastle Undead Society
//
//  Created by jl on 4/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSEventListViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NUSDataStore.h"
#import "NUSEvent.h"
#import "NUSEventDetailViewController.h"
#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"

@interface NUSEventListViewController () {
    NSMutableArray *cellArray;
    NSMutableArray *pastEvents;
    NSMutableArray *futureEvents;
}

@end

@implementation NUSEventListViewController

#pragma mark - UICollectionViewDataSource delegate methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [cellArray count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *sectionContents = [cellArray objectAtIndex:section];
    
    return [sectionContents count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(320, 110);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    // NOTE - this is set to height 60 to align with other tableView-based VCs
    return CGSizeMake(320, 60);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView;
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        reusableView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SectionHeader" forIndexPath:indexPath];
        
        // Configure header label text
        [self updateSectionHeader:reusableView forIndexPath:indexPath];
    }
    
    return reusableView;
}

- (void)updateSectionHeader:(UICollectionReusableView *)header forIndexPath:(NSIndexPath *)indexPath
{
    // Clear out old header text labels so they don't stack up
    // NOTE - this was to fix a bug where that happened
    [[header subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // Init header title text
    NSString *headerTitle;
    
    switch (indexPath.section) {
        case 0:
            
            // Check if there are any future events and set header text accordingly
            if ([cellArray count] > 1) {
                // More than one means there ARE future events
                headerTitle = NSLocalizedString(@"Future Events", nil);
            } else {
                // There are NO future events
                headerTitle = NSLocalizedString(@"Past Events", nil);
            }
            
            break;
            
        case 1:
            // Past Events
            headerTitle = NSLocalizedString(@"Past Events", nil);
            break;
            
        default:
            break;
    }
    
    // Set text of header label
    // Init section header label
    UILabel *sectionHeaderLabel = [[UILabel alloc] initWithFrame:header.bounds];
    sectionHeaderLabel.backgroundColor = [UIColor clearColor];
    sectionHeaderLabel.adjustsFontSizeToFitWidth = YES;
    sectionHeaderLabel.textAlignment = NSTextAlignmentCenter;
    sectionHeaderLabel.text = headerTitle;
    
    // Set header text colour
    // Dark Pastel Red
    sectionHeaderLabel.textColor = [UIColor colorWithRed:0.75 green:0.22 blue:0.17 alpha:1];
    
    // Set header font
    UIFont *headerLabelFont = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20];
    sectionHeaderLabel.font = headerLabelFont;
    
    [header addSubview:sectionHeaderLabel];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EventListCell" forIndexPath:indexPath];
    
    NSArray *sectionContents = [cellArray objectAtIndex:indexPath.section];
    
    // Init cell labels
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:102];
    UIImageView *cellImageView = (UIImageView *)[cell viewWithTag:101];
    
    // Scale image to fill cell
    cellImageView.contentMode = UIViewContentModeScaleToFill;
    
    // Is a future event
    NUSEvent *cellData = [sectionContents objectAtIndex:indexPath.row];
    
    // Set cell title
    titleLabel.text = cellData.eventYear;
    
    // Set title label text colour
    titleLabel.textColor = [UIColor whiteColor];
    
    // Add shadow to title label text
    titleLabel.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    titleLabel.shadowOffset = CGSizeMake(0, 1);
    
    // Set title label font
    UIFont *titleLabelFont = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:44];
    titleLabel.font = titleLabelFont;
    
    // Set placeholder image
    UIImage *placeholderImage = [NUSDataStore returnEventImageForEventYear:cellData.eventYear];
    
    // Set cell thumbnail using SDWebImage
    [cellImageView sd_setImageWithURL:[NSURL URLWithString:cellData.eventImageUrl]
                     placeholderImage:placeholderImage
                            completed:^(UIImage *cellImage, NSError *error, SDImageCacheType cacheType, NSURL *imageUrl) {
                                if (error) {
                                    DDLogError(@"Events: error fetching cell thumbnail image: %@", [error localizedDescription]);
                                }
    }];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *sectionContents = [cellArray objectAtIndex:indexPath.section];
    
    NUSEvent *cellData = [sectionContents objectAtIndex:indexPath.row];
    
    // Set back button text
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Events", nil) style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self.navigationController pushViewController:[[NUSEventDetailViewController alloc] initWithChosenEventItem:cellData] animated:YES];
}

#pragma mark - Data fetch did happen NSNotifcation method

- (void)dataFetchDidHappen
{
    DDLogVerbose(@"Event List VC: was notified that data fetch did happen");
    
    // Reload cellArray data source
    [self initCellArrayDataSource];
    
    // NOTE: no need to reload collectionView here,
    // as this is done in the initCellArrayDataSource method
}

#pragma mark - Init methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set title
    self.title = NSLocalizedString(@"Events", nil);
    
    // Turn off navbar translucency
    [self.navigationController.navigationBar setTranslucent:NO];
    
    // Register for dataFetchDidHappen NSNotification
    NSString *notificationName = @"NUSDataFetchDidHappen";
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dataFetchDidHappen)
                                                 name:notificationName
                                               object:nil];
    
    // Init collectionView
    [self initCollectionView];
    
    // Init cellArray data source
    [self initCellArrayDataSource];
}

- (void)dealloc
{
    // Remove NSNotification observers
    NSString *notificationName = @"NUSDataFetchDidHappen";
    [[NSNotificationCenter defaultCenter] removeObserver:self name:notificationName object:nil];
}

#pragma mark - Init collectionView

- (void)initCollectionView
{
    // Init collectionView flow layout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(320, 110)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    // Remove spacing
    [flowLayout setMinimumInteritemSpacing:0.0f];
    [flowLayout setMinimumLineSpacing:0.0f];
    
    // Init collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    // NOTE - this adds some space to the top & bottom of the collectionView
    [self.collectionView setContentInset:UIEdgeInsetsMake(0, 0, 80, 0)];
    
    // Set collectionView background colour
    // White (Gallery)
    [self.collectionView setBackgroundColor:[UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1]];
    
    
    // Register cell with collectionView
    [self.collectionView registerNib:[UINib nibWithNibName:@"NUSEventListCell" bundle:nil] forCellWithReuseIdentifier:@"EventListCell"];
    
    // Register header view cell with collectionView
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SectionHeader"];
    
    // Add collectionView to view
    [self.view addSubview:self.collectionView];
}

#pragma mark - Init cellArray data source

- (void)initCellArrayDataSource
{
    cellArray = [[NSMutableArray alloc] init];
    pastEvents = [[NSMutableArray alloc] init];
    futureEvents = [[NSMutableArray alloc] init];
    
    futureEvents = [NSMutableArray arrayWithArray:[NUSDataStore returnFutureEventsFromCache]];
    pastEvents = [NSMutableArray arrayWithArray:[NUSDataStore returnPastEventsFromCache]];
    
    // Check if there are any future events and add to cellArray if there are any
    // NOTE - adding futureEvents first so it's at the top
    if ([futureEvents count] > 0) {
        [cellArray addObject:futureEvents];
    }
    [cellArray addObject:pastEvents];
    
    // Reload collectionView with data
    [self.collectionView reloadData];
}

@end
