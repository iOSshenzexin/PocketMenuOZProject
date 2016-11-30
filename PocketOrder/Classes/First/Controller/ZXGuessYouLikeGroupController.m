//
//  ZXGuessYouLikeGroupController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/28.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXGuessYouLikeGroupController.h"

#import "ZXGuessYouLikeGroupCell.h"
@interface ZXGuessYouLikeGroupController ()

@end

@implementation ZXGuessYouLikeGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZXGuessYouLikeGroupCell *cell = [ZXGuessYouLikeGroupCell cellWithTableView:tableView];
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 135;
}

@end
