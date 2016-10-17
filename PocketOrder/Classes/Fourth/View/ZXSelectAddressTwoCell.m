//
//  ZXSelectAddressTwoCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/17.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXSelectAddressTwoCell.h"

@implementation ZXSelectAddressTwoCell

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}


static NSString *selectAddressTwoCell = @"ZXSelectAddressTwoCell";
+(instancetype)cellWithTableView:(UITableView *)tableview
{
    ZXSelectAddressTwoCell *cell = [tableview dequeueReusableCellWithIdentifier:selectAddressTwoCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZXSelectAddressTwoCell class]) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
