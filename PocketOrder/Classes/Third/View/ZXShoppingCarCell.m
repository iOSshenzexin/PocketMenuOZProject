//
//  ZXShoppingCarCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/20.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXShoppingCarCell.h"

@implementation ZXShoppingCarCell

static NSString *shoppingCarCell = @"ZXShoppingCarCell";

+(instancetype)cellWithTableView:(UITableView *)tableview
{
    ZXShoppingCarCell *cell = [tableview dequeueReusableCellWithIdentifier:shoppingCarCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.amount = [self.amountTxt.text intValue];
//    self.minus.hidden = YES;
//    self.plus.hidden = YES;
  
}


- (IBAction)plus:(id)sender {
    self.amount += 1;
    [self showOrderNumbers:self.amount];
}

- (IBAction)select:(UIButton *)sender {
    sender.selected = !sender.selected;
    
}

- (IBAction)minus:(id)sender {
    self.amount -= 1;
    [self showOrderNumbers:self.amount];
}

-(void)showOrderNumbers:(NSUInteger)count
{
    self.amountTxt.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.amount];
    if (self.amount > 0)
    {
        [self.minus setHidden:NO];
        //[self.orderCount setHidden:NO];
    }
    else
    {
        [self.minus setHidden:YES];
       // [self.orderCount setHidden:YES];
    }
}


- (void)setModel:(ZXGoodsModel *)model
{
    _model = model;
    self.selectBtn.selected = model.isSelect;
    self.amountTxt.text = model.goodsCount;
    self.goodsPriceLbl.text = [NSString stringWithFormat:@"$%.2f",model.goodsPrice.intValue / 100.0];
    self.goodsNameLbl.text = model.goodsTitle;
    
    self.minus.hidden = !model.isSelect;
    self.plus.hidden = !model.isSelect;
}

@end
