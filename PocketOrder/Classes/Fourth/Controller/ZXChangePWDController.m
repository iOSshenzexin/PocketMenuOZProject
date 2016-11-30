//
//  ZXChangePWDController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/19.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXChangePWDController.h"

@interface ZXChangePWDController ()

@end

@implementation ZXChangePWDController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupHeaderAndFooterView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)setupHeaderAndFooterView{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
    UIButton *quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quitBtn.bounds = CGRectMake(0, 0, ScreenW - 30, 40);
    quitBtn.layer.cornerRadius = 3;
    [quitBtn setTitle:@"确定" forState:UIControlStateNormal];
    [quitBtn addTarget:self action:@selector(didClickCompeleted:) forControlEvents:UIControlEventTouchUpInside];
    quitBtn.backgroundColor = AppThemeColor;
    quitBtn.center = footerView.center;
    [footerView addSubview:quitBtn];
    self.tableView.tableFooterView = footerView;
}

- (void)didClickCompeleted:(UIButton *)btn
{
    [SVProgressHUD setDefaultStyle:1];
    if (self.oldPassword.text.length == 0 | self.passwordNew.text.length == 0 | self.password_Confirm.text.length == 0) {
         [SVProgressHUD showErrorWithStatus:@"内容不可为空!"];
    }
    else if (![self.oldPassword.text isEqualToString:[ZXSaveUserMessagerManager objectForKey:password]] ) {
        [SVProgressHUD showErrorWithStatus:@"原密码输入错误!"];
    }else if(![self.passwordNew.text isEqualToString:self.password_Confirm.text]){
        [SVProgressHUD showErrorWithStatus:@"新密码与确认密码不相同!"];
    }else{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        ZXLoginMessageModel *userModel = PocketMenuOzLoginModel;
        params[@"member_id"] = @(userModel.member_id);
        params[@"newpassword"] = [self.password_Confirm.text stringMD5Hash];
        [ZXNetworkTool byAFNPost:PocketMenuOZ_ChangeUserPasswordAPI parameters:params success:^(id responseObject) {
            if ([responseObject[@"status"] intValue] == 200) {
             [ZXSaveUserMessagerManager setObject: self.password_Confirm.text forKey:password];
             [ZXSaveUserMessagerManager synchronize];
             [SVProgressHUD showSuccessWithStatus:responseObject[@"message"]];
            }else{
             [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            }
        } failure:^(NSError *error) {
            ZXLog(@"%@",error);
        }];
    }
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

@end
