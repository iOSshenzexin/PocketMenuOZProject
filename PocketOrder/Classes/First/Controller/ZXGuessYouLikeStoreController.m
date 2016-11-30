//
//  ZXGuessYouLikeStoreController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/28.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXGuessYouLikeStoreController.h"

#import "ZXFoodMerchantsCell.h"

@interface ZXGuessYouLikeStoreController ()

@end

@implementation ZXGuessYouLikeStoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZXFoodMerchantsCell *cell = [ZXFoodMerchantsCell cellWithTableView:tableView];
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 175;
}
@end
