//
//  ZXGroupBuyDetailOneCell.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/2.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ZXGroupBuyDetailOneCell;
@protocol ZXGroupBuyDetailOneCellDelegate <NSObject>

@optional

- (void)collectGroupAcitivity:(ZXGroupBuyDetailOneCell *)cell;

@end


@interface ZXGroupBuyDetailOneCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,weak) id <ZXGroupBuyDetailOneCellDelegate>delegate;

@end
