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
    DDLogVerbose(@"%s", __FUNCTION__);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NUSArticleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ArticleCollectionViewCell" forIndexPath:indexPath];
    
    // Set cell image using SDWebImage
    [cell.articleImage setImageWithURL:[NSURL URLWithString:[self.collectionData objectAtIndex:indexPath.row]]
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

#pragma mark - Init methods

- (void)awakeFromNib
{
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setItemSize:CGSizeMake(130, 150)];
    
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ArticleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ArticleCollectionViewCell"];
}

- (void)setCollectionData:(NSArray *)collectionData
{
    _collectionData = collectionData;
    [self.collectionView setContentOffset:CGPointZero animated:NO];
    [self.collectionView reloadData];
}

@end
