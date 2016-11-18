//
//  MyOrderDetailOneCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "MyOrderDetailOneCell.h"

@implementation MyOrderDetailOneCell

static NSString *orderDetailOneCell = @"MyOrderDetailOneCell";
+(instancetype)cellWithTableView:(UITableView *)tableview
{
    MyOrderDetailOneCell *cell = [tableview dequeueReusableCellWithIdentifier:orderDetailOneCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
