//
//  ZXEvaluatedOrderStatusController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXEvaluatedOrderStatusController.h"

#import "ZXProductListController.h"

@interface ZXEvaluatedOrderStatusController ()

@end

@implementation ZXEvaluatedOrderStatusController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)didClickGoToOnceMore:(id)sender {
    ZXProductListController *vc = [[ZXProductListController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
