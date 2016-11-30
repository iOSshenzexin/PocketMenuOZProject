//
//  ZXStoreTypeModel.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/30.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXStoreTypeModel : NSObject
/*
 "class_id" = 0;
 "class_name" = "";
 "s_type_id" = 1;
 "s_type_name" = "美食";
 "s_type_sort" = 1;
 */
@property (nonatomic,copy) NSString *class_id;

@property (nonatomic,copy) NSString *class_name;

@property (nonatomic,copy) NSString *s_type_id;

@property (nonatomic,copy) NSString *s_type_name;

@property (nonatomic,copy) NSString *s_type_sort;

@end
