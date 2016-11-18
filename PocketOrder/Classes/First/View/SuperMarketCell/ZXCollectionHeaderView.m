//
//  ZXCollectionHeaderView.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/4.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXCollectionHeaderView.h"

@interface ZXCollectionHeaderView ()
{
    //UILabel *titleLabel;
}

@end


@implementation ZXCollectionHeaderView

-(void)awakeFromNib
{
    [super awakeFromNib];
}

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self createBasicView];
    }
    return self;
}

-(void)createBasicView{
    self.titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(10, 0, (ScreenW * 0.75 - 20), 44)];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.titleLabel];
}

+(instancetype)headerViewWith:(UICollectionView *)cv indexPath:(NSIndexPath *)indexPath{
    ZXCollectionHeaderView *headerView = [cv dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionHeaderView forIndexPath:indexPath];
    return headerView;
}


@end
