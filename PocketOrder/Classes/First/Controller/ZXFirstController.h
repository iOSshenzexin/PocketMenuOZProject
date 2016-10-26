//
//  ZXFirstController.h
//  PocketMenu
//
//  Created by 杨晓婧 on 16/7/4.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXFirstController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *homeTableView;

@property (nonatomic,strong) CLLocationManager *locationManager;

@end
