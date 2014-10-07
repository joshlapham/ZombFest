//
//  NUSContainerCellView.m
//  Newcastle Undead Society
//
//  Created by jl on 5/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSContainerCellView.h"
#import "NUSArticleCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface NUSContainerCellView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *collectionData;

@end

@implementation NUSContainerCellView

#pragma mark - UICollectionViewDataSource delegate methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.collectionData count];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Pass indexPath to notification so MWPhotoBrowser can start on photo that was just tapped
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectItemFromCollectionView" object:indexPath];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NUSArticleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ArticleCollectionViewCell" forIndexPath:indexPath];
    
    // Set cell image using SDWebImage
    [cell.articleImage sd_setImageWithURL:[NSURL URLWithString:[self.collectionData objectAtIndex:indexPath.row]]
                         placeholderImage:[UIImage imageNamed:@"gallery-image-placeholder"]
                                  options:SDWebImageRetryFailed
                                completed:^(UIImage *cellImage, NSError *error, SDImageCacheType cacheType, NSURL *imageUrl) {
                                    if (error) {
                                        DDLogError(@"Gallery: error fetching cell thumbnail image: %@", [error localizedDescription]);
                                    }
    }];
    
    return cell;
}

#pragma mark - Init methods

- (void)awakeFromNib
{
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setItemSize:CGSizeMake(130, 150)];
    
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    // Set gallery cells to have a little gap at the start and end
    [self.collectionView setContentInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    
    // Set background colour
    // White (Gallery)
    [self.collectionView setBackgroundColor:[UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1]];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ArticleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ArticleCollectionViewCell"];
}

- (void)setCollectionData:(NSArray *)collectionData
{
    _collectionData = collectionData;
    // NOTE - have disabled this as it resets the gallery pictures back to the
    // first one (losing the user's place), and also resets the contentInset
    //[self.collectionView setContentOffset:CGPointZero animated:NO];
    [self.collectionView reloadData];
}

@end
