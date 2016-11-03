//
//  ZXSupermarketListCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/3.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXSupermarketListCell.h"

@implementation ZXSupermarketListCell

static NSString *supermarketListCell = @"ZXSupermarketListCell";


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    ZXSupermarketListCell *cell = [tableView dequeueReusableCellWithIdentifier:supermarketListCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
