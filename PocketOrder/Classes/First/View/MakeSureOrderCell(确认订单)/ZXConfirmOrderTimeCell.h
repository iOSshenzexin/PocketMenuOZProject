//
//  ZXConfirmOrderTimeCell.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/11.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXConfirmOrderTimeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *timeTextField;



+(instancetype)cellWithTableView:(UITableView *)tableview;

@end
