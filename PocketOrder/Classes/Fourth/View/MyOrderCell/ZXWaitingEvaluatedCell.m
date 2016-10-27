//
//  ZXWaitingEvaluatedCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/27.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXWaitingEvaluatedCell.h"

@implementation ZXWaitingEvaluatedCell

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 5;
    [super setFrame:frame];
}

static NSString *waitingEvaluatedCell = @"ZXWaitingEvaluatedCell";
+(instancetype)cellWithTableView:(UITableView *)tableview
{
    ZXWaitingEvaluatedCell *cell = [tableview dequeueReusableCellWithIdentifier:waitingEvaluatedCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZXWaitingEvaluatedCell class]) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
@end
