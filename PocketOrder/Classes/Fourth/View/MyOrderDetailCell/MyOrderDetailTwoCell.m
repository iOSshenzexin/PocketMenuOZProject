//
//  MyOrderDetailTwoCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "MyOrderDetailTwoCell.h"

@implementation MyOrderDetailTwoCell

static NSString *orderDetailTwoCell = @"MyOrderDetailTwoCell";
+(instancetype)cellWithTableView:(UITableView *)tableview
{
    MyOrderDetailTwoCell *cell = [tableview dequeueReusableCellWithIdentifier:orderDetailTwoCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
