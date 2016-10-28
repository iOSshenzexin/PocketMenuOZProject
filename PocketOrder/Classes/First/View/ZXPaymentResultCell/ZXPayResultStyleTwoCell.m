//
//  ZXPayResultStyleTwoCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/28.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXPayResultStyleTwoCell.h"

@implementation ZXPayResultStyleTwoCell

static NSString *payResultStyleTwoCell = @"ZXPayResultStyleTwoCell";


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    ZXPayResultStyleTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:payResultStyleTwoCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZXPayResultStyleTwoCell class]) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
@end
