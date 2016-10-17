//
//  ZXThirdController.m
//  PocketMenu
//
//  Created by 杨晓婧 on 16/7/4.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXThirdController.h"

@interface ZXThirdController ()

@end

@implementation ZXThirdController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tabBarItem.title = [NSString stringWithFormat:@""];
//    self.title= @"购物车(2)";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithFont:17 btnWidth:60 btnHeight:30 image:nil highlightImage:nil title:@"编辑" target:self action:@selector(didClickEdit) leftEdgeInset:0 rightEdgeInset:-20];
}


- (IBAction)didClickAllChoosed:(UIButton *)sender {
    sender.selected = !sender.selected;
}




- (void)didClickEdit
{
    ZXFunction
}

@end
