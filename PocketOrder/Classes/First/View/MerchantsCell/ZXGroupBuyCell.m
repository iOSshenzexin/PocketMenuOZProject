//
//  ZXGroupBuyCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/2.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXGroupBuyCell.h"

@implementation ZXGroupBuyCell

static NSString *groupBuyCell = @"ZXGroupBuyCell";

-(void)setFrame:(CGRect)frame{
    frame.size.height -= 10;
    [super setFrame:frame];
}


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    ZXGroupBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:groupBuyCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZXGroupBuyCell class]) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
