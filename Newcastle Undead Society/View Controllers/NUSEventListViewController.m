//
//  NUSEventListViewController.m
//  Newcastle Undead Society
//
//  Created by jl on 4/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSEventListViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

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
    return CGSizeMake(320, 44);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    NSString *headerTitle;
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        switch (indexPath.section) {
            case 0:
                // Future Events
                headerTitle = NSLocalizedString(@"Future Events", nil);
                break;
                
            case 1:
                // Past Events
                headerTitle = NSLocalizedString(@"Past Events", nil);
                break;
                
            default:
                break;
        }
        
        reusableView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SectionHeader" forIndexPath:indexPath];
        
        // Init section header label
        UILabel *sectionHeaderLabel = [[UILabel alloc] initWithFrame:reusableView.bounds];
        sectionHeaderLabel.backgroundColor = [UIColor clearColor];
        sectionHeaderLabel.textColor = [UIColor colorWithRed:0.46 green:0.19 blue:0.18 alpha:1];
        sectionHeaderLabel.adjustsFontSizeToFitWidth = YES;
        sectionHeaderLabel.textAlignment = NSTextAlignmentCenter;
        sectionHeaderLabel.text = headerTitle;
        
        UIFont *headerLabelFont = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20];
        sectionHeaderLabel.font = headerLabelFont;
        
        [reusableView addSubview:sectionHeaderLabel];
    }
    return reusableView;
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
    
    // Set cell title
    titleLabel.text = [[sectionContents objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    // Set cell thumbnail using SDWebImage
    [cellImageView setImageWithURL:[NSURL URLWithString:[[sectionContents objectAtIndex:indexPath.row] objectForKey:@"imageUrl"]]
                  placeholderImage:nil
                         completed:^(UIImage *cellImage, NSError *error, SDImageCacheType cacheType) {
                             if (cellImage && !error) {
                                 //DDLogVerbose(@"Fetched cell thumbnail image");
                             } else {
                                 //DDLogError(@"Error fetching cell thumbnail image: %@", [error localizedDescription]);
                                 // TODO: implement fallback
                             }
                         }];
    
    return cell;
}

#pragma mark - Init method

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set title
    self.title = NSLocalizedString(@"Events", nil);
    
    // Turn off navbar translucency
    [self.navigationController.navigationBar setTranslucent:NO];
    
    // Init collectionView
    [self initCollectionView];
    
    // Init cellArray data source
    [self initCellArrayDataSource];
}

#pragma mark - Init collectionView

- (void)initCollectionView
{
    // Init collectionView flow layout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(320, 110)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setMinimumInteritemSpacing:0];
    [flowLayout setMinimumLineSpacing:0];
    
    // Init collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    // NOTE - this adds some space to the bottom of the collectionView
    [self.collectionView setContentInset:UIEdgeInsetsMake(0, 0, 80, 0)];
    
    // Set collectionView background colour
    [self.collectionView setBackgroundColor:[UIColor colorWithRed:0.76 green:0.76 blue:0.76 alpha:1]];
    
    // Register cell with collectionView
    [self.collectionView registerNib:[UINib nibWithNibName:@"NUSEventListCell" bundle:nil] forCellWithReuseIdentifier:@"EventListCell"];
    
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
    
    NSDictionary *galleryItem1 = @{@"title" : @"2013", @"imageUrl" : @"https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/1453493_658726834172236_1271715398_n.jpg"};
    NSDictionary *galleryItem2 = @{@"title" : @"2012", @"imageUrl" : @"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/536424_474541165924138_1749738981_n.jpg"};
    NSDictionary *galleryItem3 = @{@"title" : @"2011", @"imageUrl" : @"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/315710_259496494095274_1257647121_n.jpg"};
    // NOTE - actually using a 2009 image for 2010
    NSDictionary *galleryItem4 = @{@"title" : @"2010", @"imageUrl" : @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/262887_224862680891989_6260150_n.jpg"};
    NSDictionary *galleryItem5 = @{@"title" : @"2009", @"imageUrl" : @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/33518_127658320612426_6225652_n.jpg"};
    
    NSDictionary *futureEvent = @{@"title" : @"2014", @"imageUrl" : @"https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/1453493_658726834172236_1271715398_n.jpg"};
    
    [pastEvents addObject:galleryItem1];
    [pastEvents addObject:galleryItem2];
    [pastEvents addObject:galleryItem3];
    [pastEvents addObject:galleryItem4];
    [pastEvents addObject:galleryItem5];
    
    [futureEvents addObject:futureEvent];
    
    // Temp array to hold our different arrays of data
    NSMutableArray *tmpAllArray = [[NSMutableArray alloc] init];
    // NOTE - add futureEvents first so it's at the top
    [tmpAllArray addObject:futureEvents];
    [tmpAllArray addObject:pastEvents];
    
    // Init cellArray with all this data
    [cellArray setArray:tmpAllArray];
    
    // Reload collectionView with data
    [self.collectionView reloadData];
}

@end
