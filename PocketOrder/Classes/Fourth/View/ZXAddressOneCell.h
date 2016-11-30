//
//  ZXAddressOneCell.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/14.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZXUserAddressListModel.h"
@interface ZXAddressOneCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableview;

@property (weak, nonatomic) IBOutlet UITextField *userName;

@property (weak, nonatomic) IBOutlet UITextField *userTelephone;

@property (nonatomic,copy) NSString *sex;

@property (nonatomic,strong) ZXUserAddressListModel *userAddressModel;
@end
