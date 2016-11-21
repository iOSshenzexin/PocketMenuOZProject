//
//  ZXGroupPaymentOrderController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXGroupPaymentOrderController.h"


@interface ZXGroupPaymentOrderController ()

@property (nonatomic,weak) UIButton *previousButton;

@property (weak, nonatomic) IBOutlet UIButton *firstBtn;

@end

@implementation ZXGroupPaymentOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.previousButton = self.firstBtn;
    [self setupTableFooterView];
}

- (IBAction)didClickSelectPayStyle:(UIButton *)sender {
    if (sender != self.previousButton) {
        sender.selected = self.previousButton.selected;
        self.previousButton.selected = NO;
        self.previousButton = sender;
    }
}



- (void)setupTableFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 100)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds = CGRectMake(0, 0, ScreenW - 30, 40);
    btn.layer.cornerRadius = 3;
    [btn setTitle:@"确认支付" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClickPayOrder:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = AppThemeColor;
    btn.center = footerView.center;
    [footerView addSubview:btn];
    self.tableView.tableFooterView = footerView;
}


- (void)didClickPayOrder:(UIButton *)btn
{
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *fooerView = [[UIView alloc] init];
    fooerView.backgroundColor = [UIColor clearColor];
    return fooerView;
}

@end
