//
//  ZXPayResultStyleOneCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/28.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXPayResultStyleOneCell.h"

@implementation ZXPayResultStyleOneCell

static NSString *payResultStyleOneCell = @"ZXPayResultStyleOneCell";


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    ZXPayResultStyleOneCell *cell = [tableView dequeueReusableCellWithIdentifier:payResultStyleOneCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZXPayResultStyleOneCell class]) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
