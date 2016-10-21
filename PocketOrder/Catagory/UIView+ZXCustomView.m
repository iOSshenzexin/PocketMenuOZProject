//
//  UIView+ZXCustomView.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "UIView+ZXCustomView.h"

@implementation UIView (ZXCustomView)

+ (instancetype)szx_viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

@end
