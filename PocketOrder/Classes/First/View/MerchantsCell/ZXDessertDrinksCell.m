//
//  ZXDessertDrinksCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/1.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXDessertDrinksCell.h"

@implementation ZXDessertDrinksCell

static NSString *dessertDrinksCell = @"ZXDessertDrinksCell";

-(void)setFrame:(CGRect)frame{
    frame.size.height -= 10;
    [super setFrame:frame];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.deliveryFeeLabel.hidden = YES;
    [self.deliveryAreaLabel removeFromSuperview];
    self.verticalLength.constant = 6;
}


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    ZXDessertDrinksCell *cell = [tableView dequeueReusableCellWithIdentifier:dessertDrinksCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZXDessertDrinksCell class]) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
