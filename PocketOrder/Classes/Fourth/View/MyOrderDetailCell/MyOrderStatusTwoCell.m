//
//  MyOrderStatusTwoCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "MyOrderStatusTwoCell.h"

@implementation MyOrderStatusTwoCell

static NSString *orderStatusTwoCell = @"MyOrderStatusTwoCell";
+(instancetype)cellWithTableView:(UITableView *)tableview
{
    MyOrderStatusTwoCell *cell = [tableview dequeueReusableCellWithIdentifier:orderStatusTwoCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
