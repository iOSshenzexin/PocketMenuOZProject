//
//  ZXEvaluatedController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/27.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXEvaluatedController.h"
#import "ZXWaitingPayDetailController.h"
#import "ZXEvaluatedCell.h"

#import "ZXProductListController.h"
@interface ZXEvaluatedController ()<ZXEvaluatedCellDelegate>

@end

@implementation ZXEvaluatedController

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
    ZXEvaluatedCell *cell = [ZXEvaluatedCell cellWithTableView:tableView];
    cell.delegate = self;
    return cell;
}

-(void)didClickToGetMoceOrder:(ZXEvaluatedCell *)cell
{
    ZXProductListController *vc = [[ZXProductListController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 168;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXWaitingPayDetailController *vc = [[ZXWaitingPayDetailController alloc] init];
    vc.title = @"已评价";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
