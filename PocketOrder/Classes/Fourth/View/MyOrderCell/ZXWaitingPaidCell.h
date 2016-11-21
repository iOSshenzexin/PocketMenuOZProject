//
//  ZXWaitingPaidCell.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/27.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ZXWaitingPaidCell;
@protocol ZXWaitingPaidCellDelegate <NSObject>

@optional

- (void)didClickPayMoney:(ZXWaitingPaidCell *)cell;

- (void)didClickCancleWaitingOrder:(ZXWaitingPaidCell *)cell;


@end




@interface ZXWaitingPaidCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *countdownLbl;

+(instancetype)cellWithTableView:(UITableView *)tableview;

@property (nonatomic,weak) id <ZXWaitingPaidCellDelegate>delegate;


@end
