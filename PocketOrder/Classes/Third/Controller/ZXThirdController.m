//
//  ZXThirdController.m
//  PocketMenu
//
//  Created by 杨晓婧 on 16/7/4.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXThirdController.h"
#import "ZXSupermarketController.h"

#import "ZXShoppingCarHeaderView.h"
#import "ZXShoppingCarCell.h"

#import "ZXGoodsModel.h"
#import "ZXHeaderMerchantModel.h"
#import "ZXShoppingCarBottomModel.h"
@interface ZXThirdController ()<UITableViewDelegate,UITableViewDataSource,ZXShoppingCarHeaderViewDelegate>

@property (nonatomic,strong) NSMutableArray *carLists;
/** 数据模型数组 */
@property(nonatomic,strong) NSMutableArray * modelArrs;
/** 组数据模型 */
@property(nonatomic,strong) NSMutableArray * groupArrs;

@property(nonatomic,strong) ZXShoppingCarBottomModel * bottomModel;

@end

@implementation ZXThirdController

- (NSMutableArray *)carLists{
    
    if (_carLists == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"shopping.json" ofType:nil];
        
        NSData *jsonData = [NSData dataWithContentsOfFile:path];
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
        _carLists = dict[@"shoppingCar"];
        
        NSMutableArray * modelArrs = [NSMutableArray array];
        for (NSDictionary * dict in _carLists)
        {
            NSMutableArray * modelArr = [ZXGoodsModel mj_objectArrayWithKeyValuesArray:dict[@"goodsInfo"]];
            
            [modelArrs addObject:modelArr];
        }
        self.modelArrs = modelArrs;
        
        NSMutableArray * groupArrs = [ZXHeaderMerchantModel mj_objectArrayWithKeyValuesArray:_carLists];
        self.groupArrs = groupArrs;
        [self.tableView reloadData];
        
    }
    return _carLists;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNomalTitle:@"编辑" SelectedTitle:@"删除" target:self action:@selector(didClickEdit:)];
    [self setupTable];
    self.tableView.allowsMultipleSelectionDuringEditing = YES;

   // [self.tableView.mj_header beginRefreshing];
}

- (void)setupTable
{
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);

    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
    // 给表格视图添加下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewInfo)];
//    self.tableView.mj_header.automaticallyChangeAlpha = YES;
//    // 给表格视图添加上拉加载
//    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreInfo)];
}


- (void)loadNewInfo {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
    // 拼接参数
  //  NSString *urlString = [NSString stringWithFormat:@"http://api.dantangapp.com/v1/channels/%ld/items?gender=1&generation=1&limit=20&offset=0", self.channesID];
    
   // [self loadItemInfo:urlString withType:0];
}

- (void)loadMoreInfo {
//    if(self.next_url != nil && ![self.next_url isEqual:[NSNull null]]) {
//        [self loadItemInfo:self.next_url withType:1];
//    }else {
//        MRLog(@"null");
//    }
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.carLists.count;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary * dict = self.carLists[section];
    NSArray * datas = [ZXGoodsModel mj_objectArrayWithKeyValuesArray:dict[@"goodsInfo"]];
    
    return datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
    footerView.backgroundColor = [UIColor clearColor];
   // RGB(236, 236, 236);
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ZXShoppingCarHeaderView *headerView = [ZXShoppingCarHeaderView sharedHeaderView:tableView];
    ZXHeaderMerchantModel * headModel = self.groupArrs[section];
    headerView.model = headModel;
    headerView.headerDelegate = self;
    headerView.tag = section + 1000;
    return headerView;
}

#pragma mark -头部按钮代理方法
-(void)didClickShoppingCarHeaderViewSelectAllOfCellInSection:(ZXShoppingCarHeaderView *)headerView mark:(NSString *)mark{
    NSInteger indexpath = headerView.tag - 1000;
    ZXHeaderMerchantModel *headModel = self.groupArrs[indexpath];
    NSArray *allSelectArr = self.modelArrs[indexpath];
    if ([mark isEqualToString:@"select"]) {
        if(headerView.headerSelectBtn.selected)
        {
            for (ZXGoodsModel * model in allSelectArr)
            {
                model.isSelect = YES;
                headModel.isSelect = YES;
            }
        }else
        {
            for (ZXGoodsModel * model in allSelectArr)
            {
                model.isSelect = NO;
                headModel.isSelect = NO;
            }
        }
        //[self isallSelectAllPrice];
    }
    NSIndexSet *indexSet= [[NSIndexSet alloc]initWithIndex:indexpath];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

//点击编辑按钮进行数量改变和删除
- (void)didClickShoppingCarHeaderViewEditButton:(ZXShoppingCarHeaderView *)header
{
    NSInteger indexpath = header.tag - 1000;
    NSArray *allSelectArr = self.modelArrs[indexpath];
    ZXHeaderMerchantModel *headModel = self.groupArrs[indexpath];
    if (header.editBtn.selected) {
        for (NSInteger i = 0; i < allSelectArr.count; i ++) {
            ZXShoppingCarCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:indexpath]];
            cell.leading.constant = -60;
            ZXGoodsModel *model = allSelectArr[i];
            model.isSelect = YES;
            headModel.isSelect = YES;
        }
    }else{
        for (NSInteger i = 0; i < allSelectArr.count; i ++) {
            ZXShoppingCarCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:indexpath]];
            [UIView animateWithDuration:0.5 animations:^{
                cell.leading.constant = 0;
            }];
            ZXGoodsModel *model = allSelectArr[i];
            model.isSelect = NO;
            headModel.isSelect = NO;
        }
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self.tableView layoutIfNeeded];
    }];
//    NSIndexSet *indexSet= [[NSIndexSet alloc] initWithIndex:indexpath];
//    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationLeft];
}

/**
  点击按钮跳转到超市
 */
-(void)didClickShoppingCarHeaderViewSelectStore:(ZXShoppingCarHeaderView *)headerView
{
    ZXSupermarketController *vc = [[ZXSupermarketController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


/**
 全选按钮
 */
- (IBAction)didClickAllChoosed:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        for (NSInteger i = 0; i < self.groupArrs.count; i ++) {
            ZXHeaderMerchantModel *headModel = self.groupArrs[i];
            NSArray *allSelectArr = self.modelArrs[i];
            for (ZXGoodsModel * model in allSelectArr)
            {
                model.isSelect = YES;
                headModel.isSelect = YES;
            }
             [self isallSelectAllPrice];
        }
    }else{
        for (NSInteger i = 0; i < self.groupArrs.count; i ++) {
            ZXHeaderMerchantModel *headModel = self.groupArrs[i];
            NSArray *allSelectArr = self.modelArrs[i];
            for (ZXGoodsModel * model in allSelectArr)
            {
                model.isSelect = NO;
                headModel.isSelect = NO;
            }
             [self isallSelectAllPrice];
        }
    }
     [self.tableView reloadData];
    
}

- (void)isallSelectAllPrice
{
    for (NSArray * arr in self.modelArrs)
    {
        for (ZXGoodsModel * model in arr)
        {
            if (!model.isSelect)
            {
                self.bottomModel.isSelect = NO;
                return;
            }else
            {
                self.bottomModel.isSelect = YES;
            }
        }
    }
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXShoppingCarCell *cell = [ZXShoppingCarCell cellWithTableView:tableView];
    cell.model = self.modelArrs[indexPath.section][indexPath.row];

    return cell;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewCellEditingStyleDelete;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//       // [dataArray removeObjectAtIndex:indexPath.row];
//        // Delete the row from the data source.
//        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        
//    }
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
//}

/**
 导航栏按钮
 */
- (void)didClickEdit:(UIButton *)btn
{
    btn.selected = !btn.selected;
    ZXFunction
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
   // self.view = nil;
}

@end
