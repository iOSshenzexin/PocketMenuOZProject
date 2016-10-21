//
//  ZXChangeEmailController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/20.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXChangeEmailController.h"
#import "ZXGetCheckCode.h"
@interface ZXChangeEmailController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTxt;

@end

@implementation ZXChangeEmailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.emailTxt textFieldWithCheckCode:self.emailTxt.frame.size.height target:self action:@selector(getSMSCode:)];
}

- (void)getSMSCode:(UIButton *)btn{
    [ZXGetCheckCode getCheckCode:btn];
}
@end
