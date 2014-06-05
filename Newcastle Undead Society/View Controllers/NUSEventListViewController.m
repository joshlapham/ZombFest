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
        sectionHeaderLabel.adjustsFontSizeToFitWidth = YES;
        sectionHeaderLabel.textAlignment = NSTextAlignmentCenter;
        sectionHeaderLabel.text = headerTitle;
        
        // Set header text colour
        sectionHeaderLabel.textColor = [UIColor colorWithRed:0.46 green:0.19 blue:0.18 alpha:1];
        
        // Set header font
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
    
    // Temp var to hold thumbnail before we convert to grayscale
    // TODO: remove this eventually, for testing only
    UIImageView *thumbImage = [[UIImageView alloc] init];
    
    // Set cell thumbnail using SDWebImage
    // TODO: run this method on cellImageView after removal of convert to grayscale method
    [thumbImage setImageWithURL:[NSURL URLWithString:cellData.eventImageUrl]
               placeholderImage:nil
                      completed:^(UIImage *cellImage, NSError *error, SDImageCacheType cacheType) {
                             if (cellImage && !error) {
                                 //DDLogVerbose(@"Fetched cell thumbnail image");
                                 
                                 // TODO: don't convert to gray scale every time here
                                 [cellImageView setImage:[self convertImageToGrayScale:cellImage]];
                             } else {
                                 //DDLogError(@"Error fetching cell thumbnail image: %@", [error localizedDescription]);
                                 // TODO: implement fallback
                             }
                         }];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *sectionContents = [cellArray objectAtIndex:indexPath.section];
    
    NUSEvent *cellData = [sectionContents objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:[[NUSEventDetailViewController alloc] initWithChosenEventItem:cellData] animated:YES];
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
    
    // NOTE - this adds some space to the top & bottom of the collectionView
    [self.collectionView setContentInset:UIEdgeInsetsMake(0, 0, 80, 0)];
    
    // Set collectionView background colour
    [self.collectionView setBackgroundColor:[UIColor colorWithRed:0.76 green:0.76 blue:0.76 alpha:1]];
    
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
    
    futureEvents = [NSMutableArray arrayWithArray:[NUSDataStore returnFutureEvents]];
    pastEvents = [NSMutableArray arrayWithArray:[NUSDataStore returnPastEvents]];
    
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

#pragma mark - Convert image to grayscale method

// TODO: remove this method eventually, for testing only
- (UIImage *)convertImageToGrayScale:(UIImage *)initialImage
{
    const int RED = 1;
    const int GREEN = 2;
    const int BLUE = 3;
    
    // Create image rectangle with current image width/height
    CGRect imageRect = CGRectMake(0, 0, initialImage.size.width * initialImage.scale, initialImage.size.height * initialImage.scale);
    
    int width = imageRect.size.width;
    int height = imageRect.size.height;
    
    // the pixels will be painted to this array
    uint32_t *pixels = (uint32_t *) malloc(width * height * sizeof(uint32_t));
    
    // clear the pixels so any transparency is preserved
    memset(pixels, 0, width * height * sizeof(uint32_t));
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // create a context with RGBA pixels
    CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, width * sizeof(uint32_t), colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    
    // paint the bitmap to our context which will fill in the pixels array
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [initialImage CGImage]);
    
    for(int y = 0; y < height; y++)
    {
        for(int x = 0; x < width; x++)
        {
            uint8_t *rgbaPixel = (uint8_t *) &pixels[y * width + x];
            
            //convert to grayscale using recommended method: http://en.wikipedia.org/wiki/Grayscale#Converting_color_to_grayscale
            
            uint32_t gray = 0.3 * rgbaPixel[RED] + 0.59 * rgbaPixel[GREEN] + 0.11 * rgbaPixel[BLUE];
            
            // set the pixels to gray
            rgbaPixel[RED] = gray;
            rgbaPixel[GREEN] = gray;
            rgbaPixel[BLUE] = gray;
        }
    }
    
    // create a new CGImageRef from our context with the modified pixels
    CGImageRef image = CGBitmapContextCreateImage(context);
    
    // we're done with the context, color space, and pixels
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(pixels);
    
    // make a new UIImage to return
    UIImage *resultUIImage = [UIImage imageWithCGImage:image
                                                 scale:initialImage.scale
                                           orientation:UIImageOrientationUp];
    
    return resultUIImage;
}

@end
