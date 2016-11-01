//
//  ZXCollectGoodsCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/1.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXCollectGoodsCell.h"

@implementation ZXCollectGoodsCell

static NSString *collectGoodsCell = @"ZXCollectGoodsCell";

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    ZXCollectGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:collectGoodsCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


@end
