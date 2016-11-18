//
//  ZXPaidController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/27.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXPaidController.h"
#import "ZXWaitingPayDetailController.h"



#import "ZXPaidCell.h"
@interface ZXPaidController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ZXPaidController

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
    ZXPaidCell *cell = [ZXPaidCell cellWithTableView:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 168;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXWaitingPayDetailController *vc = [[ZXWaitingPayDetailController alloc] init];
    vc.title = @"已支付";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
