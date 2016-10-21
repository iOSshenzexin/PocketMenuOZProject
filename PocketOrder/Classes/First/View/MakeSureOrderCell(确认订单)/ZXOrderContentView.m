//
//  ZXOrderContentView.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXOrderContentView.h"

@implementation ZXOrderContentView

-(void)setOrderContentModel:(ZXOrderFoodsModel *)orderContentModel
{
    _orderContentModel = orderContentModel;
    self.nameLbl.text = orderContentModel.name;
    self.priceLbl.text = [NSString stringWithFormat:@"%ld",orderContentModel.min_price];
    self.amountLbl.text = [NSString stringWithFormat:@"x %ld",orderContentModel.orderCount];
}

@end
