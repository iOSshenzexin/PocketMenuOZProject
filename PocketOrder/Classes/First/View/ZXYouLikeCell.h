//
//  ZXYouLikeCell.h
//  PocketOrder
//
//  Created by 杨晓婧 on 16/9/12.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXYouLikeCell;
@protocol ZXYouLikeCellDelegate <NSObject>

@optional

- (void)enterZXGuessYouLikeCellController:(ZXYouLikeCell *)cell;

@end


@interface ZXYouLikeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UICollectionView *youLikeCV;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,weak) id<ZXYouLikeCellDelegate>delegate;

@end
