//
//  ZXSupermarketProductCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/7.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXSupermarketProductCell.h"

@implementation ZXSupermarketProductCell


static NSString *supermarketProductCell = @"ZXSupermarketProductCell";

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 5;
    [super setFrame:frame];
}


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    ZXSupermarketProductCell *cell = [tableView dequeueReusableCellWithIdentifier:supermarketProductCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


- (IBAction)didClickAddGoodsToShoppingCar:(id)sender {
    if (self.didClickAddBtnHandle) {
        self.didClickAddBtnHandle();
    }
}



@end
