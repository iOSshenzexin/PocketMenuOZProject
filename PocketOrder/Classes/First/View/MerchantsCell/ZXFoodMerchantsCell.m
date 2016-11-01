//
//  ZXFoodMerchantsCell.m
//  PocketOrder
//
//  Created by 杨晓婧 on 16/8/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXFoodMerchantsCell.h"

@implementation ZXFoodMerchantsCell

static NSString *foodMeuchantsCell = @"ZXFoodMerchantsCell";

-(void)setFrame:(CGRect)frame{
    frame.size.height -= 10;
    [super setFrame:frame];
}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    ZXFoodMerchantsCell *cell = [tableView dequeueReusableCellWithIdentifier:foodMeuchantsCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZXFoodMerchantsCell class]) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}




@end
