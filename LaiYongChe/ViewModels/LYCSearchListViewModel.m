//
//  LYCSearchListViewModel.m
//  LaiYongChe
//
//  Created by laiyongche on 16/5/9.
//  Copyright © 2016年 laiyongche. All rights reserved.
//

#import "LYCSearchListViewModel.h"
#import "APIClient.h"
#import "LYCSearchListModel.h"
@implementation LYCSearchListViewModel
- (void)handleDataWithSuccess:(void (^) (NSArray * arr))success failure:(void (^) (NSError *err))failure
{
    [[APIClient sharedManager] netWorkGetSearchListPageNo:self.pageNo pageSize:self.pageSize  wd:self.searchStr success:^(Response *response) {
        NSLog(@".......搜索 respone.description : %@",response.description);
        //        if (response.status==kEnumServerStateSuccess) {
        NSLog(@"请求成功!");
        NSMutableArray *tmpArr=[NSMutableArray array];

        for (NSDictionary *subDic in (NSArray *)(NSMutableArray *)response) {
            
            LYCSearchListModel *model=[[LYCSearchListModel alloc]initWithDic:subDic];
            
            [tmpArr addObject:model];
            //            }
            
        }
        
        
 
        success(tmpArr);
    } failure:^(NSError *error) {
        
        failure(error);
    }];
    
}

@end
