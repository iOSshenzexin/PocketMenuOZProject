//
//  ZXMessageCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/8.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXMessageCell.h"

#import "ZXMessagePaddingCell.h"
@implementation ZXMessageCell


static NSString *messageCell = @"ZXMessageCell";


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    ZXMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:messageCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZXMessagePaddingCell"bundle:nil]forCellWithReuseIdentifier:messagePaddingCell];
    self.collectionView.showsHorizontalScrollIndicator = NO;
}


@end
