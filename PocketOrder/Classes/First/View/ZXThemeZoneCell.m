//
//  ZXThemeZoneCell.m
//  PocketOrder
//
//  Created by 杨晓婧 on 16/9/12.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXThemeZoneCell.h"

//static CGFloat const margin = 5;

@interface ZXThemeZoneCell()


@end
@implementation ZXThemeZoneCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    ZXThemeZoneCell *cell = [tableView dequeueReusableCellWithIdentifier:themeZoneCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZXThemeZoneCell" owner:nil options:nil] lastObject];
        // 注册cell
    }
    return cell;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 5;
    
    layout.minimumInteritemSpacing = 5;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.collectionViewLayout = layout;
    
    
    
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    // 设置cell尺寸
//    layout.minimumInteritemSpacing = margin;
//    layout.minimumLineSpacing = margin;
//    self.collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
//    self.collectionView.scrollEnabled = NO;
//    self.collectionView.collectionViewLayout = layout;
}

@end
