//
//  ZXSelectAddressController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/17.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXSelectAddressController.h"
#import "ZXAddAdressController.h"
#import "ZXSelectAddressOneCell.h"
#import "ZXSelectAddressTwoCell.h"
#import "ZXUserAddressListModel.h"
@interface ZXSelectAddressController ()<UITableViewDelegate,UITableViewDataSource,ZXSelectAddressTwoCellDelegate>

@property (nonatomic,strong) NSMutableArray *addresses;
@end

@implementation ZXSelectAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)didClickUpdateUserAddress:(ZXSelectAddressTwoCell *)cell
{
    ZXAddAdressController *vc = [[ZXAddAdressController alloc] init];
    vc.title = @"修改收货地址";
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    vc.addressModel = self.addresses[index.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadUserAddressListContent
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    ZXLoginMessageModel *userModel = PocketMenuOzLoginModel;
    params[@"member_id"] = @(userModel.member_id);
    [ZXNetworkTool byAFNPost:PocketMenuOZ_UserAddressListAPI parameters:params success:^(id responseObject) {
        self.addresses = [ZXUserAddressListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        ZXLog(@"%@",error);
    }];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self loadUserAddressListContent];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return self.addresses.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
       ZXSelectAddressOneCell *cell = [ZXSelectAddressOneCell cellWithTableView:tableView];
         return cell;
    }else{
       ZXSelectAddressTwoCell *cell = [ZXSelectAddressTwoCell cellWithTableView:tableView];
        cell.delegate = self;
        cell.addressModel = self.addresses[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) return 61;
    return 81;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = self.tableView.backgroundColor;
    return footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ZXAddAdressController *vc = [[ZXAddAdressController alloc] init];
        vc.title = @"新增收货地址";
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        ZXAddAdressController *vc = [[ZXAddAdressController alloc] init];
        vc.title = @"修改收货地址";
        vc.addressModel = self.addresses[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath * indexP =[NSIndexPath indexPathForRow:0 inSection:0];
    if (indexP == indexPath) {
        return NO;
    }
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteInternetAddressInfo:indexPath];
        [self.addresses removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView reloadData];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
/**
 * 删除地址信息
 */
- (void)deleteInternetAddressInfo:(NSIndexPath *)indexPath
{
    ZXSelectAddressTwoCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"address_id"] = cell.addressModel.address_id;
    [ZXNetworkTool byAFNPost:PocketMenuOZ_UserAddressDeleteAPI parameters:params success:^(id responseObject) {
        if ([responseObject[@"status"] intValue] == 200) {
            [SVProgressHUD showSuccessWithStatus:responseObject[@"message"]];
        }else{
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        ZXLog(@"%@",error);
    }];
    
    
}



@end
