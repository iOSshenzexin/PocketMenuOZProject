//
//  ZXLoginController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/14.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXLoginController.h"

#import "ZXRegisterController.h"
#import "ZXResetPWDController.h"
@interface ZXLoginController ()

@end

@implementation ZXLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)didClickRememberPWD:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)didClickResetPWD:(id)sender {
    ZXResetPWDController *vc = [[ZXResetPWDController alloc] init];
    vc.title = @"重置密码";
    [self.navigationController pushViewController:vc animated:YES];
}








- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didClickRegister:(id)sender {
    ZXRegisterController *vc = [[ZXRegisterController alloc] init];
    vc.title = @"注册";
    [self.navigationController pushViewController:vc animated:YES];
}





- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

@end
