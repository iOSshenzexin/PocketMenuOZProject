//
//  ZXFourthController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/17.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXFourthController.h"

#import "ZXHeaderView.h"

#import "ZXChangePersonInfoController.h"
@interface ZXFourthController ()

@end

@implementation ZXFourthController

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.sectionFooterHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    
    [self setupHeaderAndFooterView];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}


-(void)setupHeaderAndFooterView{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
    UIButton *quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    quitBtn.bounds = CGRectMake(0, 0, ScreenW - 30, 40);
    quitBtn.layer.cornerRadius = 3;
    [quitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    quitBtn.backgroundColor = AppThemeColor;
    quitBtn.center = footerView.center;
    [footerView addSubview:quitBtn];
    self.tableView.tableFooterView = footerView;
  
    ZXLog(@"%@",NSStringFromCGRect(self.tableView.tableHeaderView.frame));
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 215;
    }
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        ZXHeaderView *headerView = [ZXHeaderView awakFromNib];
        [headerView.jumpBtn addTarget:self action:@selector(jumpToPersomInfo:) forControlEvents:UIControlEventTouchUpInside];
        return headerView;
    }
    return nil;
}


- (void)jumpToPersomInfo:(UIButton *)btn
{
    ZXChangePersonInfoController *vc = [[ZXChangePersonInfoController alloc] init];
    vc.navigationController.navigationBarHidden = NO;
    vc.title = @"账户信息";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0 ){
        return 3;
    }
    if (section == 1) {
        return 2;
    }
    
    return 1;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
