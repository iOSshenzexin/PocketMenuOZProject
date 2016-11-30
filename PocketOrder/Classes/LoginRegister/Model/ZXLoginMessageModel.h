//
//  ZXLoginMessageModel.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/30.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXLoginMessageModel : NSObject


@property (nonatomic,strong) NSString *member_email;
@property (nonatomic,assign) NSInteger member_id;
@property (nonatomic,strong) NSString * member_mobile;
@property (nonatomic,strong) NSString *member_name;
@property (nonatomic,strong) NSString *member_old_login_time;


@end
