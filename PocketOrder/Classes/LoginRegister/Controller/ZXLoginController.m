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
#import "ZXUserProtocolController.h"

#import "XFSegementView.h"
#import "ZXLoginBlockView.h"
#import "UIView+Extension.h"

#import "ZXGetCheckCode.h"
@interface ZXLoginController ()<TouchLabelDelegate,ZXLoginBlockViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *middleView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadCons;

@end

@implementation ZXLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.translatesAutoresizingMaskIntoConstraints = YES;
    
    XFSegementView *segement = [[XFSegementView alloc] initWithFrame:CGRectMake(0, 64, ScreenW, 44)];
    segement.titleColor = RGB(97, 97, 97);
    segement.titleArray = @[@"手机快速登录",@"账户密码登录"];
    segement.touchDelegate = self;
    [self.view addSubview:segement];
    
    ZXLoginBlockView *fastView = [ZXLoginBlockView fastLoginView];
    fastView.delegate = self;
    UIButton *btn = [fastView.fastLoginCodeTxt addCheckCodeView];
    [btn addTarget:self action:@selector(getSMSCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.middleView addSubview:fastView];
    
    ZXLoginBlockView *commonView = [ZXLoginBlockView commonLoginView];
    commonView.delegate = self;
    
    [self.middleView addSubview:commonView];
}

- (void)getSMSCode:(UIButton *)btn{
    [ZXGetCheckCode getCheckCode:btn];
}


-(void)didClickNomalLoginButton:(ZXLoginBlockView *)blockView type:(UIButton *)btn
{
    AppDelegate *app =  MyApplicationDelegate;
    app.isLogin = YES;
    [self dismissViewControllerAnimated:YES completion:^{
        self.block(app.isLogin);
    }];
}



- (void)touchLabelWithIndex:(NSInteger)index{
    _leadCons.constant = _leadCons.constant == 0 ? -self.middleView.width * 0.5:0;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}
// viewDidLayoutSubviews:才会根据布局调整控件的尺寸
- (void)viewDidLayoutSubviews
{
    // 一定要调用super
    [super viewDidLayoutSubviews];
    ZXLoginBlockView *fastView = self.middleView.subviews[0];
    fastView.frame = CGRectMake(0, 0, self.middleView.width * 0.5, self.middleView.height);

    ZXLoginBlockView *commonView = self.middleView.subviews[1];
    commonView.frame = CGRectMake( self.middleView.width * 0.5, 0,self.middleView.width * 0.5, self.middleView.height);
}

-(void)didClickForgerPwd:(ZXLoginBlockView *)blockView
{
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


- (IBAction)didClickPushToUserProtocol:(id)sender {
    ZXUserProtocolController *vc = [[ZXUserProtocolController alloc] init];
    vc.title = @"PocketMenuOZ-用户协议";
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
