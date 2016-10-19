//
//  ZXFourthController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/17.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXFourthController.h"

#import "ZXHeaderView.h"
#import "ZXUnLoginHeaderView.h"

#import "ZXChangePersonInfoController.h"
#import "ZXSettingController.h"
#import "ZXChangePWDController.h"
#import "ZXLoginController.h"

#import "AppDelegate.h"
@interface ZXFourthController ()

@end

@implementation ZXFourthController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.sectionFooterHeight = 0;
    self.tableView.contentOffset = CGPointMake(0, -20);
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 215;
    }
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    AppDelegate *app =  MyApplicationDelegate;
    if (section == 0) {
        if (app.isLogin){
        ZXHeaderView *headerView = [ZXHeaderView awakFromNib];
        [headerView.jumpBtn addTarget:self action:@selector(jumpToPersomInfo:) forControlEvents:UIControlEventTouchUpInside];
        return headerView;
        }else{
        ZXUnLoginHeaderView *unLoginHeaderView = [ZXUnLoginHeaderView awakFromNib];
        [unLoginHeaderView.loginBtn addTarget:self action:@selector(jumpToLoginPage:) forControlEvents:UIControlEventTouchUpInside];
        return unLoginHeaderView;
        }
    }
    return nil;
}

#pragma mark - 未登录跳到登录界面
- (void)jumpToLoginPage:(UIButton *)btn
{
    ZXLoginController *vc = [[ZXLoginController alloc] init];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}
#pragma mark - 已登录跳到个人信息界面
- (void)jumpToPersomInfo:(UIButton *)btn
{
    ZXChangePersonInfoController *vc = [[UIStoryboard storyboardWithName:@"ZXChangePersonInfoController" bundle:nil]instantiateViewControllerWithIdentifier:@"ZXChangePersonInfoController"];
    vc.title = @"账户信息";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0 ){
        return 3;
    }
    if (section == 1) {
        return 2;
    }
    
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            ZXChangePWDController *vc = [[UIStoryboard storyboardWithName:@"ZXChangePWDController" bundle:nil]instantiateViewControllerWithIdentifier:@"ZXChangePWDController"];
            vc.title = @"修改密码";
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.section == 2) {
         ZXSettingController *vc = [[UIStoryboard storyboardWithName:@"ZXSettingController" bundle:nil]instantiateViewControllerWithIdentifier:@"ZXSettingController"];
        vc.title = @"设置";
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.view = nil;
}
@end
