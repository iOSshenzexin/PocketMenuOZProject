//
//  ZXMakeSureOrderController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/13.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXMakeSureOrderController.h"

#import "ZXConfirmOrderOneCell.h"
#import "ZXConfirmOrderTwoCell.h"
#import "ZXConfirmOrderThreeCell.h"
@interface ZXMakeSureOrderController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZXMakeSureOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;

   // self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithFont:14 btnWidth:80 btnHeight:32 image:nil highlightImage:nil title:@"立即登录" target:self action:@selector(didClickLogin:) leftEdgeInset:0 rightEdgeInset:-20];
}

#pragma mark - 立即登录
- (void)didClickLogin:(UIButton *)btn
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    switch (indexPath.row) {
        case 0:{
            ZXConfirmOrderOneCell *cell = [ZXConfirmOrderOneCell cellWithTableView:tableView ];
            return cell;
        }
        case 1:{
            ZXConfirmOrderTwoCell *cell = [ZXConfirmOrderTwoCell cellWithTableView:tableView ];
            return cell;
        }
        case 2:{
            ZXConfirmOrderThreeCell *cell = [ZXConfirmOrderThreeCell cellWithTableView:tableView ];
            return cell;
        }
        case 3:{
            ZXConfirmOrderTwoCell *cell = [ZXConfirmOrderTwoCell cellWithTableView:tableView ];
            return cell;
        }
            break;
            
        default:
            break;
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        return 130;
    }
    return 55;
}
@end
