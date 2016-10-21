//
//  ZXMakeSureOrderController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/13.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXMakeSureOrderController.h"


#import "ZXSelectAddressController.h"

#import "ZXConfirmOrderOneCell.h"
#import "ZXConfirmOrderTwoCell.h"
#import "ZXConfirmOrderThreeCell.h"
#import "ZXConfirmOrderFourCell.h"

#import "ZXPaymentOrderController.h"
@interface ZXMakeSureOrderController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZXMakeSureOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZXLog(@"self.foodsArray %@",self.foodsArray);
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 70)];
    footerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = footerView;

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
            ZXConfirmOrderFourCell *cell = [ZXConfirmOrderFourCell cellWithTableView:tableView ];
            cell.foodsContent  = [ZXOrderFoodsModel mj_objectArrayWithKeyValuesArray: self.foodsArray[0]];
            return cell;
        }

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
    if (indexPath.row == 3) {
        return 400;
    }
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        ZXSelectAddressController *vc = [[ZXSelectAddressController alloc] init];
        vc.title = @"选择收货地址";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - 提交订单
- (IBAction)submitFoodOrder:(id)sender {
    ZXPaymentOrderController *vc = [[UIStoryboard storyboardWithName:@"ZXPaymentOrderController" bundle:nil]instantiateViewControllerWithIdentifier:@"ZXPaymentOrderController"];
    vc.title = @"支付订单";
    [self.navigationController pushViewController:vc animated:YES];
    
}



@end
