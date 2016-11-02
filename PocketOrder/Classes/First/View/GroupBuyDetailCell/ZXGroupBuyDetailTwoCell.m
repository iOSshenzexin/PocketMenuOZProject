//
//  ZXGroupBuyDetailTwoCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/2.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXGroupBuyDetailTwoCell.h"

@implementation ZXGroupBuyDetailTwoCell


static NSString *groupBuyDetailTwoCell = @"ZXGroupBuyDetailTwoCell";


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    ZXGroupBuyDetailTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:groupBuyDetailTwoCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
