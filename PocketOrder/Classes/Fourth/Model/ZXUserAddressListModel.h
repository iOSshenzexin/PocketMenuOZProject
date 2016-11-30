//
//  ZXUserAddressListModel.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/30.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXUserAddressListModel : NSObject
/*
 {
 data =     (
 {
 address = "\U6df1\U5733\U8def 888";
 "address_id" = 25;
 "area_id" = 0;
 "area_info" = 266000;
 "city_id" = "<null>";
 "dlyp_id" = 0;
 "is_default" = 1;
 "member_id" = 21;
 "mob_phone" = 15192712512;
 prefixes = "<null>";
 "tel_phone" = "<null>";
 "true_name" = "\U6c88\U6cfd\U65b0";
 "zip_code" = "<null>";
 }
 );
 */
@property (nonatomic,copy) NSString *address;

@property (nonatomic,copy) NSString *address_id;

@property (nonatomic,copy) NSString *area_id;

@property (nonatomic,copy) NSString *area_info;

//@property (nonatomic,copy) NSString *city_id;

@property (nonatomic,copy) NSString *dlyp_id;

@property (nonatomic,copy) NSString *is_default;

@property (nonatomic,copy) NSString *member_id;

@property (nonatomic,assign) NSInteger mob_phone;

@property (nonatomic,copy) NSString *prefixes;

@property (nonatomic,copy) NSString *tel_phone;

@property (nonatomic,copy) NSString *true_name;

//@property (nonatomic,copy) NSString *zip_code;
@end
