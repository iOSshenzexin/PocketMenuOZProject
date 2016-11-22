//
//  ZXShopCarConfirmOrderController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/16.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXShopCarConfirmOrderController.h"
#import "ZXGroupPaymentOrderController.h"




#import "ZXShopCarAddressOneCell.h"
#import "ZXShopCarAddressTwoCell.h"
@interface ZXShopCarConfirmOrderController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZXShopCarConfirmOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 2;
    }
    return 1;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer = [[UIView alloc] init];
    footer.backgroundColor = [UIColor clearColor];
    return footer;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [ZXShopCarAddressOneCell cellWithTableView:tableView];
    }else{
       cell = [ZXShopCarAddressTwoCell cellWithTableView:tableView];
    }
     return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 361;
    }
    return 111;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}




- (IBAction)didClickSubmitOrder:(id)sender {
    ZXGroupPaymentOrderController *vc = [[UIStoryboard storyboardWithName:@"ZXGroupPaymentOrderController" bundle:nil]instantiateViewControllerWithIdentifier:@"ZXGroupPaymentOrderController"];
    vc.title = @"支付订单";
    [self.navigationController pushViewController:vc animated:YES];
}
@end
