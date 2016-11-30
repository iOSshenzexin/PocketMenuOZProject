//
//  ZXGuessYouLikeController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/23.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXGuessYouLikeController.h"

#import "ZXGuessYouLikeCell.h"
@interface ZXGuessYouLikeController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZXGuessYouLikeController

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)viewDidLayoutSubviews {
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXGuessYouLikeCell *cell = [ZXGuessYouLikeCell cellWithTableView:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 132;
}

@end
