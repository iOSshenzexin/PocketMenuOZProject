//
//  ZXAllOrderController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/27.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXAllOrderController.h"

#import "ZXSubmitEvaluatedController.h"
#import "ZXWaitingPaidCell.h"
#import "ZXWaitingEvaluatedCell.h"
#import "ZXPaidCell.h"
#import "ZXEvaluatedCell.h"

@interface ZXAllOrderController ()<ZXWaitingEvaluatedCellDelegate>

@end

@implementation ZXAllOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ZXWaitingEvaluatedCell*cell = [ZXWaitingEvaluatedCell cellWithTableView:tableView];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.row == 1) {
        ZXEvaluatedCell *cell = [ZXEvaluatedCell cellWithTableView:tableView];
        return cell;
    }
    if (indexPath.row == 2) {
        ZXPaidCell *cell = [ZXPaidCell cellWithTableView:tableView];
        return cell;
    }
    ZXWaitingPaidCell *cell = [ZXWaitingPaidCell cellWithTableView:tableView];
    return cell;
}


-(void)waitingEvaluatedCellJumpToEvaluatedPage:(ZXWaitingEvaluatedCell *)cell
{
    ZXSubmitEvaluatedController *vc = [[ZXSubmitEvaluatedController alloc] init];
    vc.title = @"评价";
    [self.navigationController pushViewController:vc animated:YES];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 168;
}


@end
