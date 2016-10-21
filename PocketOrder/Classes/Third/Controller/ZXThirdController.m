//
//  ZXThirdController.m
//  PocketMenu
//
//  Created by 杨晓婧 on 16/7/4.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXThirdController.h"

#import "ZXShoppingCarHeaderView.h"
#import "ZXShoppingCarCell.h"

#import "ZXGoodsModel.h"
#import "ZXHeaderMerchantModel.h"
@interface ZXThirdController ()<UITableViewDelegate,UITableViewDataSource,ZXShoppingCarHeaderViewDelegate>

@property (nonatomic,strong) NSMutableArray *carLists;
/** 数据模型数组 */
@property(nonatomic,strong) NSMutableArray * modelArrs;
/** 组数据模型 */
@property(nonatomic,strong) NSMutableArray * groupArrs;



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
    [self.tableView.mj_header beginRefreshing];
}

- (void)setupTable
{
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    [[UITableViewHeaderFooterView appearance] setTintColor:[UIColor redColor]];

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
    return 40;
}



- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 20)];
    footerView.backgroundColor = [UIColor clearColor];
   // RGB(236, 236, 236);
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 25;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ZXShoppingCarHeaderView *headerView = [ZXShoppingCarHeaderView headerViewWithTableView:tableView];
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
    }else {
        if (headerView.editBtn.selected) {
            for (ZXGoodsModel * model in allSelectArr)
            {
                model.isSelect = YES;
            }
        }else{
            for (ZXGoodsModel * model in allSelectArr)
            {
                model.isSelect = NO;
            }
        }
    }
   
    [self.tableView reloadData];
}

- (IBAction)didClickAllChoosed:(UIButton *)sender {
    sender.selected = !sender.selected;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXShoppingCarCell *cell = [ZXShoppingCarCell cellWithTableView:tableView];
    cell.model = self.modelArrs[indexPath.section][indexPath.row];

    return cell;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)didClickEdit:(UIButton *)btn
{
    btn.selected = !btn.selected;
    ZXFunction
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.view = nil;
}

@end
