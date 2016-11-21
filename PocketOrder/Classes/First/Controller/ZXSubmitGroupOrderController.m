//
//  ZXSubmitGroupOrderController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXSubmitGroupOrderController.h"
#import "ZXGroupPaymentOrderController.h"
@interface ZXSubmitGroupOrderController ()

@end

@implementation ZXSubmitGroupOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableFooterView];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
    int num =[self.numberText.text intValue];
    if (num == 1) {
        self.minusBtn.enabled = NO;
    }
    
}

- (void)setupTableFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 100)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds = CGRectMake(0, 0, ScreenW - 30, 40);
    btn.layer.cornerRadius = 3;
    [btn setTitle:@"提交订单" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClickSubmitOrder:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = AppThemeColor;
    btn.center = footerView.center;
    [footerView addSubview:btn];
    self.tableView.tableFooterView = footerView;
}

- (void)didClickSubmitOrder:(UIButton *)btn
{
    ZXGroupPaymentOrderController *vc = [[UIStoryboard storyboardWithName:@"ZXGroupPaymentOrderController" bundle:nil]instantiateViewControllerWithIdentifier:@"ZXGroupPaymentOrderController"];
    vc.title = @"支付订单";
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (IBAction)didClickMinus:(UIButton *)sender {
    int num =[self.numberText.text intValue];
    num --;
    self.numberText.text = [NSString stringWithFormat:@"%d",num];
    if (num == 1) {
        sender.enabled = NO;
    }
}


- (IBAction)didClickPlus:(id)sender {
    int num =[self.numberText.text intValue];
    num ++;
    self.numberText.text = [NSString stringWithFormat:@"%d",num];
    if (num > 1) {
        self.minusBtn.enabled = YES;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }else if(section == 1){
        return 2;
    }
    return 2;
}



@end
