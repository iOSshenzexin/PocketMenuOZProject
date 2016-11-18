//
//  ZXPaidOrderStatusController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXPaidOrderStatusController.h"

#import "MyOrderStatusOneCell.h"
#import "MyOrderStatusTwoCell.h"
#import "MyOrderStatusThreeCell.h"
@interface ZXPaidOrderStatusController ()

@end

@implementation ZXPaidOrderStatusController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [MyOrderStatusOneCell cellWithTableView:tableView];
    }else if (indexPath.row == 1){
        cell = [MyOrderStatusThreeCell cellWithTableView:tableView];
    }else{
        cell = [MyOrderStatusTwoCell cellWithTableView:tableView];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
    
}



@end
