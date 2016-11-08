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

- (IBAction)didClickRememberPWD:(UIButton *)sender {
    sender.selected = !sender.selected;
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
