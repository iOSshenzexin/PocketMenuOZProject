//
//  ZXSelectAddressController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/17.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXSelectAddressController.h"
#import "ZXAddAdressController.h"
#import "ZXSelectAddressOneCell.h"
#import "ZXSelectAddressTwoCell.h"
@interface ZXSelectAddressController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZXSelectAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [ZXSelectAddressOneCell cellWithTableView:tableView];
    }else{
        cell = [ZXSelectAddressTwoCell cellWithTableView:tableView];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) return 61;
    return 81;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = self.tableView.backgroundColor;
    return footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXAddAdressController *vc = [[ZXAddAdressController alloc] init];
    vc.title = @"添加收货地址";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
