//
//  ZXSetUpPWDController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/14.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXSetUpPWDController.h"

@interface ZXSetUpPWDController ()

@property (weak, nonatomic) IBOutlet UITextField *pwd_newTxt;

@property (weak, nonatomic) IBOutlet UITextField *pwd_oldTxt;

@end

@implementation ZXSetUpPWDController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)didClickSettingPWD:(id)sender {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (![ZXVerificationObject validateMobile:self.pwd_newTxt.text]) {
        [SVProgressHUD showErrorWithStatus:@"手机号格式有误!"];
    }else{
        params[@"member_passwd"] = self.pwd_newTxt.text;
    }
    if (![self.pwd_newTxt.text isEqualToString:self.pwd_oldTxt.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入的密码不一致!"];
    }
    params[@"member_mobile"] = self.telephone;
    [ZXNetworkTool byAFNPost:PocketMenuOZ_ResetPwdAPI parameters:params success:^(id responseObject) {
        ZXPrintResponseObject
        if ([responseObject[@"status"] intValue] == 200) {
          [SVProgressHUD showSuccessWithStatus:@"修改成功!"];
          [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
        }
    } failure:^(NSError *error) {
        ZXLog(@"%@",error);
    }];
}



@end
