//
//  ZXPayResultController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXPayResultController.h"

#import "ZXPayResultStyleOneCell.h"
#import "ZXPayResultStyleTwoCell.h"
#import "ZXPayResultStyleLineCell.h"

@interface ZXPayResultController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZXPayResultController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 1;
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row % 2 == 1) {
            ZXPayResultStyleLineCell *cell = [ZXPayResultStyleLineCell cellWithTableView:tableView];
            return cell;
        }
        else if(indexPath.row == 0){
            ZXPayResultStyleOneCell *cell = [ZXPayResultStyleOneCell cellWithTableView:tableView];
            return cell;
        }else{
        ZXPayResultStyleTwoCell *cell = [ZXPayResultStyleTwoCell cellWithTableView:tableView];
        return cell;
        }
}
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"payResultStyleThree"];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row %2 ==1) {
             return 30;
        }else if(indexPath.row == 0){
            return 60;
        }else{
        return 30;
        }
    }
    return 160;
}
@end
