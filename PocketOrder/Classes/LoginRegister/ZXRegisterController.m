//
//  ZXRegisterController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/14.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXRegisterController.h"

#import "ZXSetUpPWDController.h"
#import "ZXDisclaimerController.h"

#import "ZXGetCheckCode.h"
@interface ZXRegisterController ()
@property (weak, nonatomic) IBOutlet UITextField *telTxt;

@end

@implementation ZXRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.telTxt textFieldWithCheckCode:self.telTxt.frame.size.height target:self action:@selector(getCheckCode:)];
}

- (void)getSMSCode:(UIButton *)btn{
    [ZXGetCheckCode getCheckCode:btn];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)didClickAgreeBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
}
- (IBAction)didClickAnnounce:(id)sender {
    ZXDisclaimerController *vc = [[ZXDisclaimerController alloc] init];
    vc.title = @"免责声明";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)didClickSetPWD:(id)sender {
    ZXSetUpPWDController *vc = [[ZXSetUpPWDController alloc] init];
    vc.title = @"设置密码";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
