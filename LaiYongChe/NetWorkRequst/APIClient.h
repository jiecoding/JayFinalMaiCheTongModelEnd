//
//  APIClient.h
//  TestNetworkReqOrAES(NOGit)
//
//  Created by laiyongche on 16/4/30.
//  Copyright © 2016年 LYC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Response.h"
@interface APIClient : NSObject

+ (APIClient *)sharedManager;
//首页
- (void)netWorkGetBuyCarInfoPageNo:(NSString *)pageNo pageSize:(NSString *)pageSize carLevel:(NSString *)carLevel cityId:(NSString *)cityId success:(void (^) (Response *response))success failure:(void (^) (NSError *error))failure;
//搜索结果
- (void)netWorkGetSearchListPageNo:(NSString *)pageNo pageSize:(NSString *)pageSize wd:(NSString *)searchStr success:(void (^) (Response *response))success failure:(void (^) (NSError *error))failure;
//降价
- (void)netWorkGetCarPricePageNo:(NSString *)pageNo pageSize:(NSString *)pageSize carLevel:(NSString *)carLevel cityId:(NSString *)cityId success:(void (^) (Response *response))success failure:(void (^) (NSError *error))failure;


@end
