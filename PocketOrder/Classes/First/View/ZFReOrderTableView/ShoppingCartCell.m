//
//  ShoppingCartCell.m
//  ZFShoppingCart
//
//  Created by macOne on 15/11/17.
//  Copyright © 2015年 WZF. All rights reserved.
//

#import "ShoppingCartCell.h"

@implementation ShoppingCartCell

 static NSString *cellID = @"ShoppingCartCell";
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    ShoppingCartCell *cell = (ShoppingCartCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:nil options:nil] lastObject];
    }
    cell.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}







- (IBAction)minus:(id)sender {
    
    self.number -= 1;

    [self showNumber:self.number];
    self.operationBlock(self.number,NO);
}

- (IBAction)plus:(id)sender {
    
    self.number += 1;
    [self showNumber:self.number];
    self.operationBlock(self.number,YES);
}

-(void)showNumber:(NSUInteger)count
{
    self.numberLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.number];
    if (self.number > 0)
    {
        [self.minus setHidden:NO];
        [self.numberLabel setHidden:NO];
    }
    else
    {
        [self.minus setHidden:YES];
        [self.numberLabel setHidden:YES];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self showNumber:self.number];
    
}

@end
