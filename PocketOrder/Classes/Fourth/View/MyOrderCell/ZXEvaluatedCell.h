//
//  ZXEvaluatedCell.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/27.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXEvaluatedCell;
@protocol ZXEvaluatedCellDelegate <NSObject>

@optional

- (void)didClickButtonToGetMoceOrder:(ZXEvaluatedCell *)cell;

@end


@interface ZXEvaluatedCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableview;


@property (nonatomic,weak) id <ZXEvaluatedCellDelegate> delegate;

@end
