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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.todayCV.collectionViewLayout = layout;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.todayCV registerNib:[UINib nibWithNibName:@"ZXTodayCell"bundle:nil]forCellWithReuseIdentifier:todayCell];
    self.todayCV.scrollEnabled = NO;
}


- (IBAction)didClickEnterTodayRecommend:(id)sender {
    if ([self.delegate respondsToSelector:@selector(enterTodayRecommendController:)]) {
        [self.delegate enterTodayRecommendController:self];
    }
}



@end
