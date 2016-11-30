//
//  ZXAddAdressController.h
//  PocketOrder
//
//  Created by 杨晓婧 on 16/8/19.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXUserAddressListModel.h"

@interface ZXAddAdressController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) ZXUserAddressListModel *addressModel;



@end
