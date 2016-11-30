//
//  ZXGuessYouLikeCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/24.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXGuessYouLikeCell.h"

@implementation ZXGuessYouLikeCell

static NSString *guessYouLikeCell = @"ZXGuessYouLikeCell";
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    ZXGuessYouLikeCell *cell = [tableView dequeueReusableCellWithIdentifier:guessYouLikeCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZXGuessYouLikeCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

@end
