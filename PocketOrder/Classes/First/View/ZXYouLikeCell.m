//
//  ZXYouLikeCell.m
//  PocketOrder
//
//  Created by 杨晓婧 on 16/9/12.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXYouLikeCell.h"

@implementation ZXYouLikeCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    ZXYouLikeCell *cell = [tableView dequeueReusableCellWithIdentifier:youLikeCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZXYouLikeCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.youLikeCV.collectionViewLayout = layout;
}
@end
