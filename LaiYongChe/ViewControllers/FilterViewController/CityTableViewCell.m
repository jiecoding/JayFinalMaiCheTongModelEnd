//
//  CityTableViewCell.m
//  CityDemo
//
//  Created by 李海瑞 on 16/4/18.
//  Copyright © 2016年 李海瑞. All rights reserved.
//

#import "CityTableViewCell.h"
#import "PlaceCell.h"
#define CellID @"PlaceCell"
@implementation CityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.Citycollectionview.delegate=self;
    self.Citycollectionview.dataSource=self;
    [self.Citycollectionview registerNib:[UINib nibWithNibName:CellID bundle:nil] forCellWithReuseIdentifier:CellID];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PlaceCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    cell.placelabel.text=[NSString stringWithFormat:@"第%ld部分 第%ld个",self.index.section,indexPath.row];
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(100, 60);
    
    return size;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate!=nil &&[self.delegate respondsToSelector:@selector(didSelectedTableview:withcollecttion:)]) {
        [self.delegate didSelectedTableview:self.index withcollecttion:indexPath];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
