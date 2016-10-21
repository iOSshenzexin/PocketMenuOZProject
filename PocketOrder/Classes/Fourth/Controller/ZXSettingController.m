//
//  ZXSettingController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/19.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXSettingController.h"

@interface ZXSettingController ()

@end

@implementation ZXSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self setupTableFooterView];
}

- (void)setupTableFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds = CGRectMake(0, 0, ScreenW - 30, 40);
    btn.layer.cornerRadius = 3;
    [btn setTitle:@"退出登录" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = AppThemeColor;
    btn.center = footerView.center;
    [footerView addSubview:btn];
    self.tableView.tableFooterView = footerView;
}

- (void)logout{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"您确定要退出吗?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:cancleAction];
    
    UIAlertAction *determineAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AppDelegate *app = MyApplicationDelegate;
        app.isLogin = NO;
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:determineAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}



@end
