//
//  ZXSelectAddressOneCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/17.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXSelectAddressOneCell.h"

@implementation ZXSelectAddressOneCell

static NSString *selectAddressOneCell = @"ZXSelectAddressOneCell";
+(instancetype)cellWithTableView:(UITableView *)tableview
{
    ZXSelectAddressOneCell *cell = [tableview dequeueReusableCellWithIdentifier:selectAddressOneCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZXSelectAddressOneCell class]) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
