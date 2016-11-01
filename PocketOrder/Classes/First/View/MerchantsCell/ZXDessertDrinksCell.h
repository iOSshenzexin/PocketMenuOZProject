//
//  ZXDessertDrinksCell.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/1.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXDessertDrinksCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *deliveryTimeLable;

@property (weak, nonatomic) IBOutlet UILabel *deliveryAreaLabel;

@property (weak, nonatomic) IBOutlet UILabel *deliveryFeeLabel;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verticalLength;





+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
