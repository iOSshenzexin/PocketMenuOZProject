//
//  ZXSearchHotRecommandCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/24.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXSearchHotRecommandCell.h"

@implementation ZXSearchHotRecommandCell

static NSString *searchHotRecommandCell = @"ZXSearchHotRecommandCell";
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    ZXSearchHotRecommandCell *cell = [tableView dequeueReusableCellWithIdentifier:searchHotRecommandCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZXSearchHotRecommandCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

@end
