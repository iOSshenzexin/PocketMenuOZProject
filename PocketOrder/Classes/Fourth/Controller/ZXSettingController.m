//
//  ZXSettingController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/19.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXSettingController.h"

#import <SDImageCache.h>
#import "ZXFileTool.h"
#import <SVProgressHUD/SVProgressHUD.h>
#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]


@interface ZXSettingController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign) NSInteger totalSize;
@property (weak, nonatomic) IBOutlet UIButton *casheButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation ZXSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.activityIndicator startAnimating];
    [ZXFileTool getFileSize:CachePath completion:^(NSInteger totalSize) {
        _totalSize = totalSize;
        [self.casheButton setTitle:[self sizeStr] forState:UIControlStateNormal];
        [self.tableView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.activityIndicator stopAnimating];
            self.activityIndicator.hidden = YES;
        });
}];
    [self setupTableFooterView];
}

// 获取缓存尺寸字符串
- (NSString *)sizeStr
{
    NSInteger totalSize = _totalSize;
    NSString *sizeStr = @"";
    // MB KB B
    if (totalSize > 1000 * 1000) {
        // MB
        CGFloat sizeF = totalSize / 1000.0 / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@%.1fMB",sizeStr,sizeF];
    } else if (totalSize > 1000) {
        // KB
        CGFloat sizeF = totalSize / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@%.1fKB",sizeStr,sizeF];
    } else if (totalSize > 0) {
        // B
        sizeStr = [NSString stringWithFormat:@"%@%.ldB",sizeStr,totalSize];
    }else{
        sizeStr = @"0B";
    }
    return sizeStr;
}



- (void)setupTableFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds = CGRectMake(0, 0, ScreenW - 30, 40);
    btn.layer.cornerRadius = 3;
    [btn setTitle:@"退出登录" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = AppThemeColor;
    btn.center = footerView.center;
    [footerView addSubview:btn];
    self.tableView.tableFooterView = footerView;
}

- (void)logout{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"您确定要退出吗?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:cancleAction];
    
    UIAlertAction *determineAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AppDelegate *app = MyApplicationDelegate;
        app.isLogin = NO;
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:determineAction];
    [self presentViewController:alertController animated:YES completion:nil];
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
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    if (indexPath.row == 0) {
        UIWebView *callWebview =[[UIWebView alloc] init];
        NSURL *telURL =[NSURL URLWithString:@"tel://400-666-8888"];
        [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
        [self.view addSubview:callWebview];
    }else if (indexPath.row == 1){
        self.activityIndicator.hidden = NO;
        [self.activityIndicator startAnimating];
        [ZXFileTool removeDirectoryPath:CachePath];
        _totalSize = 0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.casheButton setTitle:@"0B" forState:UIControlStateNormal];
            [self.activityIndicator stopAnimating];
            self.activityIndicator.hidden = YES;
        });
    }else{
        [SVProgressHUD showSuccessWithStatus:@"当前为最新版本!"];
    }
}


@end
