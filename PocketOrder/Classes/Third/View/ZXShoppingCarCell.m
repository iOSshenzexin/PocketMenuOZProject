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
    self.goodsImage.layer.cornerRadius = 3.0f;
    self.goodsImage.layer.masksToBounds = YES;
    self.goodsImage.clipsToBounds = YES;
}

- (IBAction)didClickDeleteCell:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didClickDeleteButtonDeleteCurrentCell:)]) {
        [self.delegate didClickDeleteButtonDeleteCurrentCell:self];
    }
}


//加
- (IBAction)plus:(id)sender {
    if (self.amount >= 99) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showErrorWithStatus:@"受不了了,宝贝不能再加了,"];
    }else{
       self.amount += 1;
    }
    [self showOrderNumbers:self.amount];
}

- (IBAction)select:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(shoppingCellDelegate:WithSelectButton:)])
    {
        [self.delegate shoppingCellDelegate:self WithSelectButton:sender];
    }
}

//减
- (IBAction)minus:(UIButton *)sender {
    if (self.amount <= 1) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showErrorWithStatus:@"受不了了,宝贝不能再少了,"];
    }else{
        self.amount -= 1;
    }
    [self showOrderNumbers:self.amount];
}

-(void)showOrderNumbers:(NSUInteger)count
{
    self.amountTxt.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.amount];
    self.model.goodsCount = [NSString stringWithFormat:@"%@",self.amountTxt.text];
}


- (void)setModel:(ZXGoodsModel *)model
{
    _model = model;
    self.amount =  self.model.goodsCount.intValue;
    self.selectBtn.selected = model.isSelect;
    self.amountTxt.text = [NSString stringWithFormat:@"%@",model.goodsCount];
    self.goodsPriceLbl.text = [NSString stringWithFormat:@"$%.2f",model.goodsPrice.intValue / 100.0];
    self.goodsNameLbl.text = model.goodsTitle;
    self.minus.hidden = !model.isHidden;
    self.plus.hidden = !model.isHidden;
}

@end
