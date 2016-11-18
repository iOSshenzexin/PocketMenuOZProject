//
//  ZXWaitingEvaluatedCell.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/27.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXWaitingEvaluatedCell;
@protocol ZXWaitingEvaluatedCellDelegate <NSObject>

@optional

- (void)waitingEvaluatedCellJumpToEvaluatedPage:(ZXWaitingEvaluatedCell *)cell;

- (void)didClickButtonToGetMoceOrder:(ZXWaitingEvaluatedCell *)cell;


@end


@interface ZXWaitingEvaluatedCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableview;

@property (nonatomic,weak) id<ZXWaitingEvaluatedCellDelegate> delegate;

@end
