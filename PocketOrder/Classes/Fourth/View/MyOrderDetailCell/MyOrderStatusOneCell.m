//
//  MyOrderStatusOneCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "MyOrderStatusOneCell.h"

@implementation MyOrderStatusOneCell

static NSString *orderStatusOneCell = @"MyOrderStatusOneCell";
+(instancetype)cellWithTableView:(UITableView *)tableview
{
    MyOrderStatusOneCell *cell = [tableview dequeueReusableCellWithIdentifier:orderStatusOneCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


@end
