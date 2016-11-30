//
//  ZXAddressTwoCell.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/17.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZXUserAddressListModel.h"
@interface ZXAddressTwoCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableview;
@property (weak, nonatomic) IBOutlet UITextField *areaName;

@property (weak, nonatomic) IBOutlet UITextField *postNumber;

@property (weak, nonatomic) IBOutlet UITextField *cityName;

@property (weak, nonatomic) IBOutlet UITextField *doorNumber;
@property (weak, nonatomic) IBOutlet UITextField *streetName;

@property(nonatomic,strong) ZXUserAddressListModel *userAddressModel;

@end
