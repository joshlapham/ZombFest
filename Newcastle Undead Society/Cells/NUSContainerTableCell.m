//
//  NUSContainerTableCell.m
//  Newcastle Undead Society
//
//  Created by jl on 5/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSContainerTableCell.h"
#import "NUSContainerCellView.h"

@interface NUSContainerTableCell ()

@property (nonatomic, strong) NUSContainerCellView *collectionView;

@end

@implementation NUSContainerTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setFrame:CGRectMake(0, 0, 320, 170)];
        
        _collectionView = [[NSBundle mainBundle] loadNibNamed:@"NUSContainerCellView" owner:self options:nil][0];
        _collectionView.frame = self.bounds;
        
        [self.contentView addSubview:_collectionView];
    }
    return self;
}

- (void)setCollectionData:(NSArray *)collectionData
{
    [_collectionView setCollectionData:collectionData];
}

@end
