//
//  ZXUnLoginHeaderView.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/19.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXUnLoginHeaderView.h"

@implementation ZXUnLoginHeaderView

+ (instancetype)awakFromNib{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}


@end
