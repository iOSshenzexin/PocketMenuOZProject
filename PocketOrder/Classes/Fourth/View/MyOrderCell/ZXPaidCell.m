//
//  ZXPaidCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/27.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXPaidCell.h"

@implementation ZXPaidCell

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 5;
    [super setFrame:frame];
}

static NSString *paidCell = @"ZXPaidCell";
+(instancetype)cellWithTableView:(UITableView *)tableview
{
    ZXPaidCell *cell = [tableview dequeueReusableCellWithIdentifier:paidCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZXPaidCell class]) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


- (IBAction)didClickCancleOrder:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didClickCancleOrder:)]) {
        [self.delegate didClickCancleOrder:self];
    }
}


- (IBAction)didClickMakeAPhoneCall:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didClickMakeAPhoneCall:)]) {
        [self.delegate didClickMakeAPhoneCall:self];
    }
}


@end
