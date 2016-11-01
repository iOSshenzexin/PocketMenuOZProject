//
//  ZXCollectStoreCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/31.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXCollectStoreCell.h"

@implementation ZXCollectStoreCell

static NSString *collectStoreCell = @"ZXCollectStoreCell";

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    ZXCollectStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:collectStoreCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZXCollectStoreCell class]) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
