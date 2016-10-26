//
//  ZXSearchDetailController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/26.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXSearchDetailController.h"

@interface ZXSearchDetailController ()

@property (nonatomic,strong)IBOutlet UITextField *searchText;

@end

@implementation ZXSearchDetailController

- (IBAction)back:(id)sender {
    [self.navigationController  popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchText.text = self.textFieldContent;
}



@end
