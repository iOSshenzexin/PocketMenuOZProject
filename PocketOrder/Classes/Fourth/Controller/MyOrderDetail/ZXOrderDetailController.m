//
//  ZXOrderDetailController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXOrderDetailController.h"

#import "MyOrderDetailOneCell.h"
#import "MyOrderDetailTwoCell.h"
@interface ZXOrderDetailController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZXOrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
    footer.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = footer;
    
    self.tableView.sectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *headerTitles = @[@"订单明细",@"配送信息"];
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = self.tableView.backgroundColor;
    UILabel *headerLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenW, 40)];
    headerLbl.text = headerTitles[section];
    [header addSubview:headerLbl];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [MyOrderDetailOneCell cellWithTableView:tableView];
    }else{
        cell = [MyOrderDetailTwoCell cellWithTableView:tableView];
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 165;
    }
    return 227;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}




@end
