//
//  APIClient.m
//  TestNetworkReqOrAES(NOGit)
//
//  Created by laiyongche on 16/4/30.
//  Copyright © 2016年 LYC. All rights reserved.
//

#import "APIClient.h"
#import "NetTool.h"
#import "Urls.h"
@implementation APIClient

+ (APIClient *)sharedManager
{
    /*
     该函数接收一个dispatch_once用于检查该代码块是否已经被调度的谓词（是一个长整型，实际上作为BOOL使用）。它还接收一个希望在应用的生命周期内仅被调度一次的代码块，对于本例就用于shared实例的实例化。
     dispatch_once不仅意味着代码仅会被运行一次，而且还是线程安全的，这就意味着你不需要使用诸如@synchronized之类的来防止使用多个线程或者队列时不同步的问题.
     */
    static APIClient *manager = nil;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        if(manager == nil)
        {
            manager = [[APIClient alloc] init];
        }
    });
    
    return manager;
}


- (void)netWorkGetBuyCarInfoPageNo:(NSString *)pageNo pageSize:(NSString *)pageSize carLevel:(NSString *)carLevel cityId:(NSString *)cityId success:(void (^) (Response *response))success failure:(void (^) (NSError *error))failure
{
    
        NSDictionary *parmDic = [NSDictionary dictionaryWithObjectsAndKeys:pageNo,@"pageNo",pageSize,@"pageSize",carLevel,@"carLevel",cityId,@"cityId",nil];
   
        [[NetTool shareManager]httpGetRequest:Home_BuyCar withParameter:parmDic success:^(Response *response) {
            success(response);
    
        } failure:^(NSError *error) {
            failure(error);
    
        }];


}

- (void)netWorkGetSearchListPageNo:(NSString *)pageNo pageSize:(NSString *)pageSize wd:(NSString *)searchStr success:(void (^)(Response *))success failure:(void (^)(NSError *))failure
{
    NSDictionary *parmDic = [NSDictionary dictionaryWithObjectsAndKeys:pageNo,@"pageNo",pageSize,@"pageSize",searchStr,@"wd",nil];
    
    [[NetTool shareManager]httpGetRequest:Search_List withParameter:parmDic success:^(Response *response) {
        success(response);
        
    } failure:^(NSError *error) {
        failure(error);
        
    }];
    
    
}


- (void)netWorkGetCarPricePageNo:(NSString *)pageNo pageSize:(NSString *)pageSize carLevel:(NSString *)carLevel cityId:(NSString *)cityId success:(void (^) (Response *response))success failure:(void (^) (NSError *error))failure
{
    
    NSDictionary *parmDic = [NSDictionary dictionaryWithObjectsAndKeys:pageNo,@"pageNo",pageSize,@"pageSize",carLevel,@"carLevel",cityId,@"cityId",nil];
    
    [[NetTool shareManager]httpGetRequest:Cut_Price withParameter:parmDic success:^(Response *response) {
        success(response);
        
    } failure:^(NSError *error) {
        failure(error);
        
    }];
    
    
}




@end
