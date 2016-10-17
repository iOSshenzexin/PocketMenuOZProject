//
//  ZXSecondController.m
//  PocketMenu
//
//  Created by 杨晓婧 on 16/7/4.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXSecondController.h"

#import "ZXSearchController.h"
@interface ZXSecondController ()

@end

@implementation ZXSecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithFont:0 btnWidth:20 btnHeight:21 image:@"Search" highlightImage:@"Search-cilck" title:nil target:self action:@selector(didClickSearch:) leftEdgeInset:0 rightEdgeInset:-8];
}

- (void)didClickSearch:(UIButton *)btn{
    ZXSearchController *vc = [[ZXSearchController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{

}


@end
