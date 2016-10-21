//
//  ZXConfirmOrderTwoCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/13.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXConfirmOrderTwoCell.h"

@implementation ZXConfirmOrderTwoCell

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    [super setFrame:frame];
}



static NSString *confirmOrderTwoCell = @"ZXConfirmOrderTwoCell";
+(instancetype)cellWithTableView:(UITableView *)tableview
{
    ZXConfirmOrderTwoCell *cell = [tableview dequeueReusableCellWithIdentifier:confirmOrderTwoCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZXConfirmOrderTwoCell class]) owner:nil options:nil] lastObject];
            }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

@end
