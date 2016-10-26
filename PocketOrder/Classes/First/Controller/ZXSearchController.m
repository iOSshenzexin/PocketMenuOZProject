//
//  ZXSearchController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/11.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXSearchController.h"

#import "ZXSearchDetailController.h"
#import "ZYTokenManager.h"
#import "ZXSearchHotRecommandCell.h"
@interface ZXSearchController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong)IBOutlet UITableView * myTableView;

@property (nonatomic,strong)IBOutlet UIView * navView;

@property (nonatomic,strong)IBOutlet UITextField * searchText;

@property (nonatomic,strong)NSMutableArray * searchHistory;
@property (nonatomic,strong)NSArray *myArray;//搜索记录的数组

@end

@implementation ZXSearchController

-(void)viewWillAppear:(BOOL)animated{
    [self readNSUserDefaults];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.searchText becomeFirstResponder];
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

-(void)readNSUserDefaults{//取出缓存的数据
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray * myArray = [userDefaultes arrayForKey:@"myArray"];
    self.myArray = myArray;
    [self.myTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     _searchHistory = [NSMutableArray array];
    self.searchText.returnKeyType = UIReturnKeySearch;//更改键盘的return
    self.searchText.delegate = self;
    self.myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (IBAction)back:(id)sender {
    [self.navigationController  popViewControllerAnimated:YES];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{//搜索方法
    if (textField.text.length > 0) {
        [ZYTokenManager SearchText:textField.text];//缓存搜索记录
        [self readNSUserDefaults];
        [self didClickSearchJumpController:textField.text];
    }else{
        NSLog(@"请输入查找内容");
    }
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        if (_myArray.count > 0) {
            return _myArray.count + 1;
        }else{
            return 0;
        }
    }else{
        return 1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *headerTitles = @[@"热门搜索",@"历史搜索"];
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = RGB(241, 241, 241);
    UILabel *headerLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenW, 40)];
    headerLbl.textColor = RGB(163, 163, 163);
    headerLbl.text = headerTitles[section];
    [header addSubview:headerLbl];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section== 1) {
         if (indexPath.row == _myArray.count){
            UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
            cell.textLabel.text = @"清除历史记录";
            cell.textLabel.textColor = RGB(163, 163, 163);
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            return cell;
        }else{
            UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            NSArray* reversedArray = [[_myArray reverseObjectEnumerator] allObjects];
            cell.textLabel.text = reversedArray[indexPath.row];
            return cell;
        }
    }else{
        ZXSearchHotRecommandCell * cell = [ZXSearchHotRecommandCell cellWithTableView:tableView];
              return cell;
        }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 1) {
        return 120;
    }
    self.myTableView.estimatedRowHeight = 44.0f;
    return UITableViewAutomaticDimension;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.myTableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
    if (indexPath.row == _myArray.count) {//清除所有历史记录
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清除历史记录" message:@"" preferredStyle: UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [ZYTokenManager removeAllArray];
            _myArray = nil;
            [self.myTableView reloadData];
        }];
        // UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:cancelAction];
        [alertController addAction:deleteAction];
        //[alertController addAction:archiveAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [self didClickSearchJumpController: cell.textLabel.text];
    }
    }
}

/**
 跳转到搜索页面
 */
- (void)didClickSearchJumpController:(NSString *)text
{
    ZXSearchDetailController *vc = [[ZXSearchDetailController alloc] init];
    vc.textFieldContent = text;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


@end
