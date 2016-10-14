//
//  ZXAddAdressController.m
//  PocketOrder
//
//  Created by 杨晓婧 on 16/8/19.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXAddAdressController.h"

@interface ZXAddAdressController ()

@end

@implementation ZXAddAdressController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithFont:17 btnWidth:60 btnHeight:30 image:nil highlightImage:nil title:@"保存" target:self action:@selector(didClickSaveAddress) leftEdgeInset:0 rightEdgeInset:-20];
}

- (void)didClickSaveAddress
{
   ZXFunction
}

@end
