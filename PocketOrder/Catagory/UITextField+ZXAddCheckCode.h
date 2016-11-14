//
//  UITextField+ZXAddCheckCode.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (ZXAddCheckCode)

- (void)textFieldWithCheckCode:(CGFloat)height target:(id)target action:(SEL)action;

- (UIButton *)addCheckCodeView;

@end
