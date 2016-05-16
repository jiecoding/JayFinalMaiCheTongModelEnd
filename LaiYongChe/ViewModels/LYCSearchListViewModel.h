//
//  LYCSearchListViewModel.h
//  LaiYongChe
//
//  Created by laiyongche on 16/5/9.
//  Copyright © 2016年 laiyongche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYCSearchListViewModel : NSObject

@property (nonatomic,strong)NSString *pageSize;
@property (nonatomic,strong)NSString *pageNo;
@property (nonatomic,strong)NSString *searchStr;

- (void)handleDataWithSuccess: (void (^) (NSArray * arr))success failure:(void (^) (NSError *err))failure;

@end
