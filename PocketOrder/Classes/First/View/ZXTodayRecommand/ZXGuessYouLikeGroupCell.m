//
//  ZXGuessYouLikeGroupCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/28.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXGuessYouLikeGroupCell.h"

@implementation ZXGuessYouLikeGroupCell

static NSString *guessYouLikeGroupCell = @"ZXGuessYouLikeGroupCell";
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    ZXGuessYouLikeGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:guessYouLikeGroupCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZXGuessYouLikeGroupCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
@end
