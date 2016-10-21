//
//  ZXPaymentOrderController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXPaymentOrderController.h"

#import "ZXPayResultController.h"
@interface ZXPaymentOrderController ()

@property (weak, nonatomic) IBOutlet UILabel *firstLbl;

@property (weak, nonatomic) IBOutlet UILabel *secondLbl;

@property (weak, nonatomic) IBOutlet UILabel *threeLbl;

@property (weak, nonatomic) IBOutlet UILabel *fourLbl;

@end

@implementation ZXPaymentOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startOrderTimer];
    [self setupTableFooterView];
}

- (void)setupTableFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds = CGRectMake(0, 0, ScreenW - 30, 40);
    btn.layer.cornerRadius = 3;
    [btn setTitle:@"确认支付 $88" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClickPayMoney) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = AppThemeColor;
    btn.center = footerView.center;
    [footerView addSubview:btn];
    self.tableView.tableFooterView = footerView;
}

- (void)didClickPayMoney
{
    ZXPayResultController *vc = [[UIStoryboard storyboardWithName:@"ZXPayResultController" bundle:nil]instantiateViewControllerWithIdentifier:@"ZXPayResultController"];
    vc.title = @"支付结果";
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)startOrderTimer{
    __block int timeout= 900; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){
            //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
#warning -回到主线程出来事情
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                self.firstLbl.text = [NSString stringWithFormat:@"%d", (timeout/60)/10];
                self.secondLbl.text = [NSString stringWithFormat:@"%d", (timeout/60) % 10];
                self.threeLbl.text = [NSString stringWithFormat:@"%d", (timeout%60) / 10];
                self.fourLbl.text = [NSString stringWithFormat:@"%d", (timeout%60) %10];
                [UIView commitAnimations];
            });
            timeout--;
        }
    });
    //启动定时器
    dispatch_resume(_timer);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


@end
