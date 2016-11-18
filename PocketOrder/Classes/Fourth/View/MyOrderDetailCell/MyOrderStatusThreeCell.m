//
//  MyOrderStatusThreeCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "MyOrderStatusThreeCell.h"

@implementation MyOrderStatusThreeCell

static NSString *orderStatusThreeCell = @"MyOrderStatusThreeCell";
+(instancetype)cellWithTableView:(UITableView *)tableview
{
    MyOrderStatusThreeCell *cell = [tableview dequeueReusableCellWithIdentifier:orderStatusThreeCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
