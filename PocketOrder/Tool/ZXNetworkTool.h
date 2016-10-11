//
//  ZXNetworkTool.h
//  PocketOrder
//
//  Created by 杨晓婧 on 16/7/5.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXNetworkTool : NSObject

+ (void)byAFNPost:(NSString *)URLString
        parameters:(id)parameters
           success:(void (^)(id responseObject))success
           failure:(void (^)(NSError *error))failure;

+ (void)byAFNGet:(NSString *)URLString
       parameters:(id)parameters
          success:(void (^)(id responseObject))success
          failure:(void (^)(NSError *error))failure;
@end
