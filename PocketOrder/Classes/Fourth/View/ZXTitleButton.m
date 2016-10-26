//
//  ZXTitleButton.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/26.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXTitleButton.h"

@implementation ZXTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        [self setTitleColor:RGB(64, 64, 64) forState:UIControlStateNormal];
        [self setTitleColor:AppThemeColor forState:UIControlStateSelected];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{ // 只要重写了这个方法，按钮就无法进入highlighted状态
    
}

@end
