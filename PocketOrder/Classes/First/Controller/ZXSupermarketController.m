//
//  ZXSupermarketController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/3.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXSupermarketController.h"

#import "ZXSupermarketListController.h"
@interface ZXSupermarketController ()

@end

@implementation ZXSupermarketController

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (IBAction)didClickJumpToSupmarketList:(id)sender {
    ZXSupermarketListController *vc = [[ZXSupermarketListController alloc] init];
    vc.title = @"选择超市";
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)didClickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)didClickShoppingCar:(id)sender {
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
