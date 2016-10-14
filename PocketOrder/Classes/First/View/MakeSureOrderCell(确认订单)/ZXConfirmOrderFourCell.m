//
//  ZXConfirmOrderFourCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/14.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXConfirmOrderFourCell.h"

@implementation ZXConfirmOrderFourCell

static NSString *confirmOrderFourCell = @"ZXConfirmOrderFourCell";
+(instancetype)cellWithTableView:(UITableView *)tableview
{
    ZXConfirmOrderFourCell *cell = [tableview dequeueReusableCellWithIdentifier:confirmOrderFourCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZXConfirmOrderFourCell class]) owner:nil options:nil] lastObject];
    }
    
    return cell;
}


@end
