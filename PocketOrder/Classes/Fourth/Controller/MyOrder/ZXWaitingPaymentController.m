//
//  ZXWaitingPaymentController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/27.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXWaitingPaymentController.h"

#import "ZXWaitingPayDetailController.h"
#import "ZXWaitingPaidCell.h"
@interface ZXWaitingPaymentController ()<UITableViewDelegate,UITableViewDataSource,ZXWaitingPaidCellDelegate>

@end

@implementation ZXWaitingPaymentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXWaitingPaidCell *cell = [ZXWaitingPaidCell cellWithTableView:tableView];
    cell.delegate = self;
    return cell;
}

-(void)didClickPayMoney:(ZXWaitingPaidCell *)cell
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showSuccessWithStatus:@"去支付"];
}

- (void)didClickCancleWaitingOrder:(ZXWaitingPaidCell *)cell
{
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



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 168;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXWaitingPayDetailController *vc = [[ZXWaitingPayDetailController alloc] init];
    vc.title = @"待付款";
    [self.navigationController pushViewController:vc animated:YES];
}


@end
