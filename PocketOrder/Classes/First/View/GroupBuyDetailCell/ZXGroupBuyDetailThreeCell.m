//
//  ZXGroupBuyDetailThreeCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/3.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXGroupBuyDetailThreeCell.h"

@implementation ZXGroupBuyDetailThreeCell

static NSString *groupBuyDetailThreeCell = @"ZXGroupBuyDetailThreeCell";


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    ZXGroupBuyDetailThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:groupBuyDetailThreeCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
