//
//  ZXOrderStatusController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXOrderStatusController.h"
#import "MyOrderStatusOneCell.h"
#import "MyOrderStatusTwoCell.h"
@interface ZXOrderStatusController ()

@end

@implementation ZXOrderStatusController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [MyOrderStatusOneCell cellWithTableView:tableView];
    }else{
        cell = [MyOrderStatusTwoCell cellWithTableView:tableView];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}


- (IBAction)didClickCancleOrder:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"您确定要取消此订单吗?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:cancleAction];
    
    UIAlertAction *determineAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showSuccessWithStatus:@"订单取消成功"];
    }];
    [alertController addAction:determineAction];
    [self presentViewController:alertController animated:YES completion:nil];
}





@end
