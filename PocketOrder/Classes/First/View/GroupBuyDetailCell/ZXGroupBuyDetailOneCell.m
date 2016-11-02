//
//  ZXGroupBuyDetailOneCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/2.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXGroupBuyDetailOneCell.h"

@implementation ZXGroupBuyDetailOneCell

static NSString *groupBuyDetailOneCell = @"ZXGroupBuyDetailOneCell";


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    ZXGroupBuyDetailOneCell *cell = [tableView dequeueReusableCellWithIdentifier:groupBuyDetailOneCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
