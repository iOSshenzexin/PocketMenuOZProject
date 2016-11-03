//
//  ZXSupermarketListController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/3.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXSupermarketListController.h"

#import "ZXSupermarketListCell.h"
@interface ZXSupermarketListController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZXSupermarketListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXSupermarketListCell *cell = [ZXSupermarketListCell cellWithTableView:tableView];
    return cell;
}

@end
