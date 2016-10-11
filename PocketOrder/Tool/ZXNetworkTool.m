//
//  ZXNetworkTool.m
//  PocketOrder
//
//  Created by 杨晓婧 on 16/7/5.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXNetworkTool.h"
#import "AFNetworking.h"
@implementation ZXNetworkTool

+ (void)byAFNPost:(NSString *)URLString
        parameters:(id)parameters
           success:(void (^)(id responseObject))success
           failure:(void (^)(NSError *error))failure{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
         // 这里可以获取到目前的数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)byAFNGet:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer =  [AFJSONResponseSerializer serializer];
    [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
         // 这里可以获取到目前的数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
