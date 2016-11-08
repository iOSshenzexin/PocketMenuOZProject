//
//  ZXSetUpPWDController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/14.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXSetUpPWDController.h"

@interface ZXSetUpPWDController ()

@end

@implementation ZXSetUpPWDController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)didClickSettingPWD:(id)sender {
    [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
}



@end
