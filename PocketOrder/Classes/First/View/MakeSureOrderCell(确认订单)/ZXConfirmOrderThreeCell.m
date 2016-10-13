//
//  ZXConfirmOrderThreeCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/13.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXConfirmOrderThreeCell.h"

@implementation ZXConfirmOrderThreeCell

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    [super setFrame:frame];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    //self.previousButton = self.firstBtn;
    
    
}

static NSString *confirmOrderThreeCell = @"ZXConfirmOrderThreeCell";
+(instancetype)cellWithTableView:(UITableView *)tableview
{
    ZXConfirmOrderThreeCell *cell = [tableview dequeueReusableCellWithIdentifier:confirmOrderThreeCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZXConfirmOrderThreeCell class]) owner:nil options:nil] lastObject];
    }
    
    return cell;
}

@end
