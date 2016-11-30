//
//  ZXResetPWDController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/14.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXResetPWDController.h"

#import "ZXSetUpPWDController.h"
#import "ZXGetCheckCode.h"
@interface ZXResetPWDController ()
@property (weak, nonatomic) IBOutlet UITextField *telTxt;
@property (weak, nonatomic) IBOutlet UITextField *codeTxt;

@end

@implementation ZXResetPWDController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTextField];

}

- (IBAction)didClickConfirmTel:(id)sender {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (![ZXVerificationObject validateMobile:self.telTxt.text]) {
        [SVProgressHUD showErrorWithStatus:@"手机号格式有误!"];
    }else{
        params[@"member_mobile"] = self.telTxt.text;
    }
    if ((![ZXVerificationObject validateNumber:self.codeTxt.text])) {
        [SVProgressHUD showErrorWithStatus:@"验证码格式有误!"];
    }else{
        params[@"member_code"] = self.codeTxt.text;
    }
    [ZXNetworkTool byAFNPost:PocketMenuOZ_ResetPwdAPI parameters:params success:^(id responseObject) {
        ZXPrintResponseObject
        if ([responseObject[@"status"] intValue] == 200) {
            
           ZXSetUpPWDController *vc = [[ZXSetUpPWDController alloc] init];
           vc.title = @"设置密码";
           vc.telephone = self.telTxt.text;
           [self.navigationController pushViewController:vc animated:YES];
        }
    } failure:^(NSError *error) {
        ZXLog(@"%@",error);
    }];
}


- (void)setupTextField
{
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, self.telTxt.frame.size.height)];
    UIButton *codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    codeBtn.bounds = CGRectMake(0, 5, 80, 30);
    codeBtn.layer.cornerRadius = 5;
    [codeBtn setTitle: @"获取验证码" forState:UIControlStateNormal];
    [codeBtn addTarget:self action:@selector(getSMSCode:) forControlEvents:UIControlEventTouchUpInside];
    codeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [codeBtn setBackgroundColor:AppThemeColor];
    codeBtn.center = rightView.center;
    [rightView addSubview:codeBtn];
    self.telTxt.rightView = rightView;
    self.telTxt.rightViewMode = UITextFieldViewModeAlways;
}

- (void)getSMSCode:(UIButton *)btn{
    [ZXGetCheckCode getCheckCode:btn];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}



@end
