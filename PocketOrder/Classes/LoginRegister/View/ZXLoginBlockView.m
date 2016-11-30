//
//  ZXLoginBlockView.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/8.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXLoginBlockView.h"

@interface ZXLoginBlockView ()

@property (weak, nonatomic) IBOutlet UIButton *fastLogin;

@property (weak, nonatomic) IBOutlet UIButton *normalLogin;

@end


@implementation ZXLoginBlockView

- (void)awakeFromNib
{
    [super awakeFromNib];
    if ([ZXSaveUserMessagerManager objectForKey:username]) {
        UITextField *userName = (UITextField *)[self viewWithTag:14];
        userName.text = [ZXSaveUserMessagerManager objectForKey:username];
        UITextField *pwd = (UITextField *)[self viewWithTag:15];
        pwd.text = [ZXSaveUserMessagerManager objectForKey:password];
        ZXLog(@"%@",pwd.text);
        self.rememberPwd.selected = YES;
    }
}


- (IBAction)didClickRememberPWD:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [ZXSaveUserMessagerManager setObject:[(UITextField *)[self viewWithTag:14] text] forKey:username];
        [ZXSaveUserMessagerManager setObject:[(UITextField *)[self viewWithTag:15] text] forKey:password];
    }else{
        [ZXSaveUserMessagerManager removeObjectForKey:username];
        [ZXSaveUserMessagerManager removeObjectForKey:password];
    }
    [ZXSaveUserMessagerManager synchronize];
}

- (IBAction)didClickResetPWD:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didClickForgerPwd:)]) {
        [self.delegate didClickForgerPwd:self];
    }
}



- (IBAction)didClickFastLogin:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didClickNomalLoginButton:type:)]) {
        [self.delegate didClickNomalLoginButton:self type:sender];
    }
}

- (IBAction)didClickNormalLogin:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didClickNomalLoginButton:type:)]) {
        [self.delegate didClickNomalLoginButton:self type:sender];
    }
}


+ (instancetype)commonLoginView{
     return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

+ (instancetype)fastLoginView{
     return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}



@end
