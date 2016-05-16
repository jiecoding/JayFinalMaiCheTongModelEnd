//
//  LYCShoppingGuideViewModel.m
//  LaiYongChe
//
//  Created by laiyongche on 16/5/11.
//  Copyright © 2016年 laiyongche. All rights reserved.
//

#import "LYCShoppingGuideViewModel.h"

#import "APIClient.h"

#import "LYCShowpingModel.h"

@implementation LYCShoppingGuideViewModel

- (void)handleDataWithSuccess:(void (^) (NSArray * arr))success failure:(void (^) (NSError *err))failure
{
    [[APIClient sharedManager] netWorkGetCarPricePageNo:self.pageNo pageSize:self.pageSize carLevel:self.carLevel cityId:self.cityId success:^(Response *response) {
        NSLog(@".......新车导购respone.description : %@",response.description);
        //        if (response.status==kEnumServerStateSuccess) {
        NSLog(@"请求成功!");
        
        NSMutableArray *tmpArr=[NSMutableArray array];
        
        for (NSDictionary *subDic in (NSArray *)response) {
            
            LYCShowpingModel *model=[[LYCShowpingModel alloc]initWithDic:subDic];
            
            [tmpArr addObject:model];
            //            }
            
            
        }
        NSLog(@"tmpArr新车导购  %ld",tmpArr.count);
        
        success(tmpArr);
    } failure:^(NSError *error) {
        
        failure(error);
    }];
    
}


@end
