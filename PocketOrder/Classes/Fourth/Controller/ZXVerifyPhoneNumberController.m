//
//  ZXVerifyPhoneNumberController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXVerifyPhoneNumberController.h"
#import "ZXBindNewPhoneNumberController.h"
@interface ZXVerifyPhoneNumberController ()

@end

@implementation ZXVerifyPhoneNumberController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)didClickVerifyOriginPhoneNumber:(id)sender {
    ZXBindNewPhoneNumberController *vc = [[ZXBindNewPhoneNumberController alloc] init];
    vc.title = @"绑定新手机号";
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}
@end
