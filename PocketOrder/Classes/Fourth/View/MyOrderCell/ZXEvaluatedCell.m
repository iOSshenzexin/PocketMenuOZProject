//
//  ZXEvaluatedCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/27.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXEvaluatedCell.h"

@implementation ZXEvaluatedCell

- (IBAction)didClickToGetMoreOrder:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didClickButtonToGetMoceOrder:)]) {
        [self.delegate didClickButtonToGetMoceOrder:self];
    }
}

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 5;
    [super setFrame:frame];
}

static NSString *evaluatedCell = @"ZXEvaluatedCell";
+(instancetype)cellWithTableView:(UITableView *)tableview
{
    ZXEvaluatedCell *cell = [tableview dequeueReusableCellWithIdentifier:evaluatedCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZXEvaluatedCell class]) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
