//
//  ZXShopCarAddressOneCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/22.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXShopCarAddressOneCell.h"

@implementation ZXShopCarAddressOneCell

static NSString *shopCarAddressOneCell = @"ZXShopCarAddressOneCell";

+(instancetype)cellWithTableView:(UITableView *)tableview
{
    ZXShopCarAddressOneCell *cell = [tableview dequeueReusableCellWithIdentifier:shopCarAddressOneCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
