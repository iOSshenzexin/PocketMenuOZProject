//
//  ZXDishesCell.h
//  PocketOrder
//
//  Created by 杨晓婧 on 16/8/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXDishesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *foodImageView;

@property (weak, nonatomic) IBOutlet UILabel *orderCount;

@property (weak, nonatomic) IBOutlet UIButton *minus;

@property (weak, nonatomic) IBOutlet UIButton *plus;

@property (assign, nonatomic) NSUInteger amount;



+ (instancetype)cellWithTableView:(UITableView *)tableview;

@end
