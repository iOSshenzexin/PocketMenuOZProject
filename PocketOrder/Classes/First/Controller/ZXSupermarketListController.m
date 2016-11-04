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
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 56)];
    header.backgroundColor = [UIColor clearColor];
    UILabel *headerLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenW - 30, 56)];
    headerLbl.numberOfLines = 0;
    headerLbl.textColor = RGB(133, 133, 133);
    headerLbl.text = @"我们为您推荐了以下几个超市,点击开始购物吧!";
    [header addSubview:headerLbl];
    self.tableView.tableHeaderView = header;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer= [[UIView alloc] init];
    footer.backgroundColor = [UIColor clearColor];
    return footer;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.name = @"家乐福超市";
    if ([self.delegate respondsToSelector:@selector(didClickGetsupermarketName:)]) {
        [self.delegate didClickGetsupermarketName:self];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
