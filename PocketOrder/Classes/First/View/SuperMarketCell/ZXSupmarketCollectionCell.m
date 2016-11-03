//
//  ZXSupmarketCollectionCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/3.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXSupmarketCollectionCell.h"

@implementation ZXSupmarketCollectionCell

+(instancetype)cellWithTableView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    ZXSupmarketCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:supmarketCollectionCell forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZXSupmarketCollectionCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

@end
