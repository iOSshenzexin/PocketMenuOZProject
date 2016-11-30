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
    if (self.addressModel) {
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithFont:17 btnWidth:60 btnHeight:30 image:nil highlightImage:nil title:@"修改" target:self action:@selector(didClickUpdateAddress) leftEdgeInset:0 rightEdgeInset:-20];
    }else{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithFont:17 btnWidth:60 btnHeight:30 image:nil highlightImage:nil title:@"保存" target:self action:@selector(didClickSaveAddress) leftEdgeInset:0 rightEdgeInset:-20];
    }
    self.tableView.sectionFooterHeight = 0;
}


- (void)didClickUpdateAddress
{
    
}


- (void)didClickSaveAddress
{
    ZXAddressOneCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    ZXAddressTwoCell *cellTwo = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    ZXLog(@"用户性别 :%@",cell.sex);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    ZXLoginMessageModel *userModel = PocketMenuOzLoginModel;
    params[@"member_id"] = @(userModel.member_id);
    params[@"true_name"] = cell.userName.text;
    params[@"mob_phone"] = cell.userTelephone.text;
    params[@"prefixes"] = cell.sex;

    params[@"area_id"] = cellTwo.areaName.text;
    params[@"city_id"] = cellTwo.cityName.text;
    params[@"area_info"] = cellTwo.postNumber.text;
    params[@"address"] = [NSString stringWithFormat:@"%@ %@",cellTwo.streetName.text,cellTwo.doorNumber.text];
    ZXLog(@"params %@",params);
    [ZXNetworkTool byAFNPost:PocketMenuOZ_UserAddressAddAPI parameters:params success:^(id responseObject) {
        if ([responseObject[@"status"] intValue] == 200) {
            [SVProgressHUD showSuccessWithStatus:responseObject[@"message"]];
        }else{
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        ZXLog(@"%@",error);
    }];

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
    if (indexPath.section == 0) {
        ZXAddressOneCell *cell = [ZXAddressOneCell cellWithTableView:tableView];
        cell.userAddressModel = self.addressModel;
        return cell;
    }
    else{
        ZXAddressTwoCell *cell = [ZXAddressTwoCell cellWithTableView:tableView];
        cell.userAddressModel = self.addressModel;
        return cell;
    }
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
