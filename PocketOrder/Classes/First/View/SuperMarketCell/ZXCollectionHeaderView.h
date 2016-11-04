//
//  ZXCollectionHeaderView.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/4.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXCollectionHeaderView : UICollectionReusableView


+(instancetype)headerViewWith:(UICollectionView *)cv indexPath:(NSIndexPath *)indexPath;

@property (nonatomic,strong) UILabel *titleLabel;

@end
