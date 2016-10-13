//
//  ZXDishesCell.m
//  PocketOrder
//
//  Created by 杨晓婧 on 16/8/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXDishesCell.h"

@implementation ZXDishesCell
static NSString *dishCell = @"ZXDishesCell";

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.amount = 0;
    self.foodImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.foodImageView.layer.cornerRadius = 5;
    self.foodImageView.layer.masksToBounds = YES;
    [self.minus setHidden:YES];
    [self.orderCount setHidden:YES];
}

- (IBAction)minus:(id)sender {
    self.amount -= 1;
     self.plusBlock(self.amount,NO);
    [self showOrderNumbers:self.amount];

}

- (IBAction)plus:(id)sender {
    self.amount += 1;
     self.plusBlock(self.amount,YES);
    [self showOrderNumbers:self.amount];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self showOrderNumbers:self.amount];
    
}


-(void)showOrderNumbers:(NSUInteger)count
{
    self.orderCount.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.amount];
    if (self.amount > 0)
    {
        [self.minus setHidden:NO];
        [self.orderCount setHidden:NO];
    }
    else
    {
        [self.minus setHidden:YES];
        [self.orderCount setHidden:YES];
    }
}

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}


+(instancetype)cellWithTableView:(UITableView *)tableview
{
    ZXDishesCell *cell = [tableview dequeueReusableCellWithIdentifier:dishCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZXDishesCell class]) owner:nil options:nil] lastObject];
    }
    return cell;
}



@end
