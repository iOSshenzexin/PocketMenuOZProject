//
//  ZXFoodMerchantsCell.h
//  PocketOrder
//
//  Created by 杨晓婧 on 16/8/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//  美食商家Cell

#import <UIKit/UIKit.h>

@interface ZXFoodMerchantsCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (weak, nonatomic) IBOutlet UILabel *goodsTitle;

@end
