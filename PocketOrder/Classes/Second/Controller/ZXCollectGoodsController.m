//
//  ZXCollectGoodsController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/31.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXCollectGoodsController.h"

#import "ZXCollectGoodsCell.h"
@interface ZXCollectGoodsController ()

@end

@implementation ZXCollectGoodsController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = RGB(239, 239, 239);
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXCollectGoodsCell *cell = [ZXCollectGoodsCell cellWithTableView:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

@end
