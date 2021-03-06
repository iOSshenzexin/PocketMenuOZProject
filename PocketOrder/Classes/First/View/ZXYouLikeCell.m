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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.youLikeCV.collectionViewLayout = layout;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.youLikeCV registerNib:[UINib nibWithNibName:@"ZXLikeCell"bundle:nil]forCellWithReuseIdentifier:likeCell];
}

- (IBAction)didEnterGuessYouLikeController:(id)sender {
    if ([self.delegate respondsToSelector:@selector(enterZXGuessYouLikeCellController:)]) {
        [self.delegate enterZXGuessYouLikeCellController:self];
    }
}

@end
