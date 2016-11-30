//
//  ZXSquareCell.m
//  PocketOrder
//
//  Created by 杨晓婧 on 16/9/12.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXSquareCell.h"

@implementation ZXSquareCell

-(void)setTypeModel:(ZXStoreTypeModel *)typeModel
{
    _typeModel = typeModel;
    self.titleLabel.text = typeModel.s_type_name;
}

@end
