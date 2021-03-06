//
//  ZXLoginBlockView.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/8.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXLoginBlockView;

@protocol ZXLoginBlockViewDelegate <NSObject>

@optional


- (void)didClickNomalLoginButton:(ZXLoginBlockView *)blockView type:(UIButton *)btn;

- (void)didClickForgerPwd:(ZXLoginBlockView *)blockView;


@end



@interface ZXLoginBlockView : UIView

@property (nonatomic,weak) id<ZXLoginBlockViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *commonLoginTelTxt;

@property (weak, nonatomic) IBOutlet UITextField *commonLoginPwdTxt;


@property (weak, nonatomic) IBOutlet UIButton *rememberPwd;

@property (strong, nonatomic) IBOutlet UITextField *fastLoginCodeTxt;

@property (weak, nonatomic) IBOutlet UITextField *fastLoginTelText;

+ (instancetype)commonLoginView;

+ (instancetype)fastLoginView;



@end
