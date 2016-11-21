//
//  ZXPaidCell.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/27.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXPaidCell;
@protocol ZXPaidCellDelegate <NSObject>

@optional

- (void)didClickMakeAPhoneCall:(ZXPaidCell *)cell;

- (void)didClickCancleOrder:(ZXPaidCell *)cell;


@end

@interface ZXPaidCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableview;

@property (nonatomic,weak) id <ZXPaidCellDelegate>delegate;

@end
