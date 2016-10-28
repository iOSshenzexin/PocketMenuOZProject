//
//  ZXPayResultStyleLineCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/28.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXPayResultStyleLineCell.h"

@implementation ZXPayResultStyleLineCell

static NSString *payResultStyleLineCell = @"ZXPayResultStyleLineCell";


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    ZXPayResultStyleLineCell *cell = [tableView dequeueReusableCellWithIdentifier:payResultStyleLineCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZXPayResultStyleLineCell class]) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
