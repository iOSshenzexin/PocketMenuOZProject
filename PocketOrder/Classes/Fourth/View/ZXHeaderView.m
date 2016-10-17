//
//  ZXHeaderView.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/17.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXHeaderView.h"

@implementation ZXHeaderView

+ (instancetype)awakFromNib{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}


@end
