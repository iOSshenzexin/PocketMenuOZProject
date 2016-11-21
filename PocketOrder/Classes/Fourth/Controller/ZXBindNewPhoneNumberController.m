//
//  ZXBindNewPhoneNumberController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXBindNewPhoneNumberController.h"
#import "ZXGetCheckCode.h"
@interface ZXBindNewPhoneNumberController ()

@end

@implementation ZXBindNewPhoneNumberController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.phoneText textFieldWithCheckCode:self.phoneText.frame.size.height target:self action:@selector(getSMSCode:)];
}

- (void)getSMSCode:(UIButton *)btn{
    [ZXGetCheckCode getCheckCode:btn];
}

- (IBAction)didClickBindNewPhoneNumber:(id)sender {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showSuccessWithStatus:@"新手机绑定成功!"];
}


@end
