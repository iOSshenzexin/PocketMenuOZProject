//
//  ZXAddAdressController.m
//  PocketOrder
//
//  Created by 杨晓婧 on 16/8/19.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXAddAdressController.h"


#import "ZXAddressOneCell.h"
#import "ZXAddressTwoCell.h"
@interface ZXAddAdressController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZXAddAdressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithFont:17 btnWidth:60 btnHeight:30 image:nil highlightImage:nil title:@"保存" target:self action:@selector(didClickSaveAddress) leftEdgeInset:0 rightEdgeInset:-20];
    
    self.tableView.sectionFooterHeight = 0;
//    self.tableView.sectionHeaderHeight = 40;
}



- (void)didClickSaveAddress
{
   ZXFunction
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *headerTitles = @[@"联系人",@"收货地址"];
    UIView *header = [[UIView alloc] init];
    UILabel *headerLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenW, 40)];
    headerLbl.text = headerTitles[section];
    [header addSubview:headerLbl];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [ZXAddressOneCell cellWithTableView:tableView];
        
    }
    else{
        cell = [ZXAddressTwoCell cellWithTableView:tableView];

    }
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 137;
    }
    return 183;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


@end
