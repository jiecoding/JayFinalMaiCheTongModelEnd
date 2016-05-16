//
//  CityTableViewCell.h
//  CityDemo
//
//  Created by 李海瑞 on 16/4/18.
//  Copyright © 2016年 李海瑞. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DateCollectionViewCellDelegate <NSObject>

@optional

- (void)didSelectedTableview:(NSIndexPath *)index withcollecttion:(NSIndexPath *)collectionindex;

@end


@interface CityTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (assign, nonatomic) id<DateCollectionViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *Collayout;
@property (weak,nonatomic) IBOutlet UICollectionView *Citycollectionview;
@property (strong, nonatomic) NSIndexPath *index;
@end
