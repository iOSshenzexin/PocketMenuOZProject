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
    [quitBtn setTitle:@"完成" forState:UIControlStateNormal];
    quitBtn.backgroundColor = AppThemeColor;
    quitBtn.center = footerView.center;
    [footerView addSubview:quitBtn];
    self.tableView.tableFooterView = footerView;
    
    ZXLog(@"%@",NSStringFromCGRect(self.tableView.tableHeaderView.frame));
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
