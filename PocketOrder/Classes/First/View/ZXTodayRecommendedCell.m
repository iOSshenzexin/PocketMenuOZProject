//
//  ZXTodayRecommendedCell.m
//  PocketOrder
//
//  Created by 杨晓婧 on 16/9/12.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXTodayRecommendedCell.h"

@implementation ZXTodayRecommendedCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    ZXTodayRecommendedCell *cell = [tableView dequeueReusableCellWithIdentifier:todayRecommendedCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZXTodayRecommendedCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)layoutSubviews{
    [super layoutSubviews];
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    self.todayCV.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
//    self.todayCV.collectionViewLayout = layout;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.todayCV.collectionViewLayout = layout;
}
@end
