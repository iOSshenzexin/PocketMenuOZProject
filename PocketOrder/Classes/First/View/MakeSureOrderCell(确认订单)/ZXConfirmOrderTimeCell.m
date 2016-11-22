//
//  ZXConfirmOrderTimeCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/11.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXConfirmOrderTimeCell.h"

@implementation ZXConfirmOrderTimeCell

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    [super setFrame:frame];
}

static NSString *confirmOrderTimeCell = @"ZXConfirmOrderTimeCell";
+(instancetype)cellWithTableView:(UITableView *)tableview
{
    ZXConfirmOrderTimeCell *cell = [tableview dequeueReusableCellWithIdentifier:confirmOrderTimeCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZXConfirmOrderTimeCell class]) owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}


@end
