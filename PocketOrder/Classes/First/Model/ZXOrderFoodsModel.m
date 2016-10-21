//
//  ZXOrderFoodsModel.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXOrderFoodsModel.h"

@implementation ZXOrderFoodsModel


- (CGFloat)cellHeight
{
    // 如果已经计算过，就直接返回
    if (_cellHeight) return _cellHeight;
    // 文字的Y值
    _cellHeight += 35;
    
//    // 文字的高度
//    CGSize textMaxSize = CGSizeMake(XMGScreenW - 2 * XMGMarin, MAXFLOAT);
//    _cellHeight += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + XMGMarin;
//    
//
//    _cellHeight += 35 + XMGMarin;
    
    return _cellHeight;
}
@end
