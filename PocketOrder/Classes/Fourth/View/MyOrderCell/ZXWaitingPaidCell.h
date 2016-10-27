//
//  ZXWaitingPaidCell.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/27.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXWaitingPaidCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *countdownLbl;

+(instancetype)cellWithTableView:(UITableView *)tableview;

@end
