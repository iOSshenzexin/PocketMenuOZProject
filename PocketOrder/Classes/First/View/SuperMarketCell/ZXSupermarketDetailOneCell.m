//
//  ZXSupermarketDetailOneCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/9.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXSupermarketDetailOneCell.h"

@implementation ZXSupermarketDetailOneCell

static NSString *supermarketDetailOneCell = @"ZXSupermarketDetailOneCell";



+(instancetype)cellWithTableView:(UITableView *)tableView
{
    ZXSupermarketDetailOneCell *cell = [tableView dequeueReusableCellWithIdentifier:supermarketDetailOneCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
