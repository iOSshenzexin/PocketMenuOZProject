//
//  ZXFourthController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/17.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXFourthController.h"

#import "ZXHeaderView.h"
#import "ZXUnLoginHeaderView.h"

#import "ZXChangePersonInfoController.h"
#import "ZXSettingController.h"
#import "ZXChangePWDController.h"
#import "ZXLoginController.h"
#import "ZXSelectAddressController.h"
#import "ZXMessageController.h"
#import "ZXOrderCenterController.h"
#import "ZXCollectionViewController.h"

#import "AppDelegate.h"


#import "MHFacebookImageViewer.h"

@interface ZXFourthController ()<ZXPassHeadImageDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) UIImage *headImage;


@end

@implementation ZXFourthController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.sectionFooterHeight = 0;
    self.tableView.contentOffset = CGPointMake(0, 0);
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 20, 0);
    ZXChangePersonInfoController *vc = [ZXChangePersonInfoController sharedController];
    vc.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (void) displayImage:(UIImageView*)imageView withImage:(UIImage*)image  {
    [imageView setImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    //[imageView setupImageViewer];
    [imageView setupImageViewerWithCompletionOnOpen:^{
    } onClose:^{
    }];
    imageView.clipsToBounds = YES;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 215;
    }
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    AppDelegate *app =  MyApplicationDelegate;
    if (section == 0) {
        if (app.isLogin){
        ZXHeaderView *headerView = [ZXHeaderView awakFromNib];
            [self loadUserMessage:headerView];
        [self displayImage:headerView.headerImage withImage:headerView.headerImage.image];
            
        if (self.headImage) {
            headerView.headerImage.image = self.headImage;
        }
        [headerView.jumpBtn addTarget:self action:@selector(jumpToPersomInfo:) forControlEvents:UIControlEventTouchUpInside];
        return headerView;
        }else{
        ZXUnLoginHeaderView *unLoginHeaderView = [ZXUnLoginHeaderView awakFromNib];
        [unLoginHeaderView.loginBtn addTarget:self action:@selector(jumpToLoginPage) forControlEvents:UIControlEventTouchUpInside];
        return unLoginHeaderView;
        }
    }
    return nil;
}

- (void)loadUserMessage:(ZXHeaderView *)header{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    ZXLoginMessageModel *userModel = PocketMenuOzLoginModel;
    params[@"member_id"] = @(userModel.member_id);
    [ZXNetworkTool byAFNPost:PocketMenuOZ_GetUserMessageAPI parameters:params success:^(id responseObject) {
        if ([responseObject[@"status"] intValue] == 200) {
            header.userName.text = responseObject[@"data"][@"member_name"];
            header.userTelephone.text = [responseObject[@"data"][@"member_mobile"] stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        }
    } failure:^(NSError *error) {
        ZXLog(@"%@",error);
    }];
}

#pragma mark - 未登录跳到登录界面
- (void)jumpToLoginPage
{
    ZXLoginController *vc = [[ZXLoginController alloc] init];
    ZXNavgaitonController *nav = [[ZXNavgaitonController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
    vc.block = ^(BOOL login){
        ZXLog(@"%d",login);
    };
}
#pragma mark - 已登录跳到个人信息界面
- (void)jumpToPersomInfo:(UIButton *)btn
{
    ZXChangePersonInfoController *vc = [ZXChangePersonInfoController sharedController];
    vc.title = @"账户信息";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)passHeaderImage:(ZXChangePersonInfoController *)vc
{
    self.headImage = vc.headImage.currentImage;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0 ){
        return 3;
    }
    if (section == 1) {
        return 2;
    }
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     AppDelegate *app =  MyApplicationDelegate;
    if (!app.isLogin) {
        ZXLoginController *vc = [[ZXLoginController alloc] init];
        ZXNavgaitonController *nav = [[ZXNavgaitonController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
        vc.block = ^(BOOL login){
            [self didClickSelectCellNSIndexPath:indexPath];
        };
    }
    else{
        [self didClickSelectCellNSIndexPath:indexPath];
    }
}

- (void)didClickSelectCellNSIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            vc = [[ZXOrderCenterController alloc] init];
            vc.title = @"订单中心";
        }
        if(indexPath.row == 1) {
            vc = [[ZXMessageController alloc] init];
            vc.title = @"消息";
        }
        if(indexPath.row == 2) {
            vc = [[ZXCollectionViewController alloc] init];
            vc.title = @"我的收藏";
        }
        }
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            vc = [[UIStoryboard storyboardWithName:@"ZXChangePWDController" bundle:nil]instantiateViewControllerWithIdentifier:@"ZXChangePWDController"];
            vc.title = @"修改密码";
        }else{
            vc = [[ZXSelectAddressController alloc] init];
            vc.title = @"我的收货地址";
        }
    }
    if (indexPath.section == 2) {
        vc = [[UIStoryboard storyboardWithName:@"ZXSettingController" bundle:nil]instantiateViewControllerWithIdentifier:@"ZXSettingController"];
        vc.title = @"设置";
    }
     [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    self.view = nil;

}


@end
