//
//  ZXLoginController.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/14.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CellClickBlock)(BOOL login);
@interface ZXLoginController : UIViewController


@property (nonatomic,copy) CellClickBlock block;

@end
