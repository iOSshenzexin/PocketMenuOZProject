//
//  ZXSupermarketDetailTwoCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/9.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXSupermarketDetailTwoCell.h"

@implementation ZXSupermarketDetailTwoCell

static NSString *supermarketDetailTwoCell = @"ZXSupermarketDetailTwoCell";

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    ZXSupermarketDetailTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:supermarketDetailTwoCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
