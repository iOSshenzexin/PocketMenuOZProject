//
//  ZXWaitingEvaluatedController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/27.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXWaitingEvaluatedController.h"
#import "ZXProductListController.h"


#import "ZXSubmitEvaluatedController.h"
#import "ZXWaitingEvaluatedCell.h"
@interface ZXWaitingEvaluatedController ()<ZXWaitingEvaluatedCellDelegate>

@end

@implementation ZXWaitingEvaluatedController

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
    ZXWaitingEvaluatedCell *cell = [ZXWaitingEvaluatedCell cellWithTableView:tableView];
    cell.delegate = self;
    return cell;
}

-(void)waitingEvaluatedCellJumpToEvaluatedPage:(ZXWaitingEvaluatedCell *)cell
{
    ZXSubmitEvaluatedController *vc = [[ZXSubmitEvaluatedController alloc] init];
    vc.title = @"评价";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)didClickButtonToGetMoceOrder:(ZXWaitingEvaluatedCell *)cell
{
    ZXProductListController *vc = [[ZXProductListController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 168;
}



@end
