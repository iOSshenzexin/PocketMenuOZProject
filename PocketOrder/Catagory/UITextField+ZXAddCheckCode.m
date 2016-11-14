//
//  UITextField+ZXAddCheckCode.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "UITextField+ZXAddCheckCode.h"

@implementation UITextField (ZXAddCheckCode)

- (void)textFieldWithCheckCode:(CGFloat)height target:(id)target action:(SEL)action
{
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, height)];
    UIButton *codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    codeBtn.bounds = CGRectMake(0, 5, 80, 30);
    codeBtn.layer.cornerRadius = 5;
    [codeBtn setTitle: @"获取验证码" forState:UIControlStateNormal];
    [codeBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    codeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [codeBtn setBackgroundColor:AppThemeColor];
    codeBtn.center = rightView.center;
    [rightView addSubview:codeBtn];
    self.rightView = rightView;
    self.rightViewMode = UITextFieldViewModeAlways;
}

- (UIButton *)addCheckCodeView{
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, self.frame.size.height)];
    UIButton *codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    codeBtn.bounds = CGRectMake(0, 5, 80, 30);
    codeBtn.layer.cornerRadius = 5;
    [codeBtn setTitle: @"获取验证码" forState:UIControlStateNormal];
    codeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [codeBtn setBackgroundColor:AppThemeColor];
    codeBtn.center = rightView.center;
    [rightView addSubview:codeBtn];
    self.rightView = rightView;
    self.rightViewMode = UITextFieldViewModeAlways;
    return codeBtn;
}



@end
