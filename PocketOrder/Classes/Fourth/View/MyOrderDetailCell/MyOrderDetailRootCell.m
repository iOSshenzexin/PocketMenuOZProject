//
//  MyOrderDetailRootCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "MyOrderDetailRootCell.h"

@implementation MyOrderDetailRootCell


+(instancetype)cellWithTableView:(UITableView *)tableview cell:(MyOrderDetailRootCell *)cell cellIdentifier:(NSString *)identifier
{
    cell = [tableview dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}



@end
