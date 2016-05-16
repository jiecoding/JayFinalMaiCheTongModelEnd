//
//  LYCPriceQuotationViewModel.m
//  LaiYongChe
//
//  Created by laiyongche on 16/5/10.
//  Copyright © 2016年 laiyongche. All rights reserved.
//

#import "LYCPriceQuotationViewModel.h"

#import "APIClient.h"

#import "LYCPriceQuotationModel.h"

@implementation LYCPriceQuotationViewModel


- (void)handleDataWithSuccess:(void (^) (NSArray * arr))success failure:(void (^) (NSError *err))failure
{
    [[APIClient sharedManager] netWorkGetCarPricePageNo:self.pageNo pageSize:self.pageSize carLevel:self.carLevel cityId:self.cityId success:^(Response *response) {
        NSLog(@".......降价respone.description : %@",response.description);
        //        if (response.status==kEnumServerStateSuccess) {
        NSLog(@"请求成功!");
        
        NSMutableArray *tmpArr=[NSMutableArray array];
        
        for (NSDictionary *subDic in (NSArray *)response) {
            
            LYCPriceQuotationModel *model=[[LYCPriceQuotationModel alloc]initWithDic:subDic];
            
            [tmpArr addObject:model];
            //            }
            
            
        }
        NSLog(@"tmpArrQQQq  %ld",tmpArr.count);
        
        success(tmpArr);
    } failure:^(NSError *error) {
        
        failure(error);
    }];
    
}


@end
