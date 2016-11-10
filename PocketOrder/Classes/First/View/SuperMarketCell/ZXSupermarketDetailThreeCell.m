//
//  ZXSupermarketDetailThreeCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/10.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXSupermarketDetailThreeCell.h"

@implementation ZXSupermarketDetailThreeCell

static NSString *supermarketDetailThreeCell = @"ZXSupermarketDetailThreeCell";

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    ZXSupermarketDetailThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:supermarketDetailThreeCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
