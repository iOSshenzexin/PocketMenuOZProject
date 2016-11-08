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
        [cell.collectionView registerNib:[UINib nibWithNibName:@"ZXSquareCell" bundle:nil] forCellWithReuseIdentifier:squareCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.collectionViewLayout = layout;
}



@end
