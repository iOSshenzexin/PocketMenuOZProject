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
#import "ZXShopCarConfirmOrderController.h"
@interface ZXThirdController ()<UITableViewDelegate,UITableViewDataSource,ZXShoppingCarHeaderViewDelegate,ZXShoppingCarCellDelegate>

@property (nonatomic,strong) NSMutableArray *carLists;
/** 数据模型数组 */
@property(nonatomic,strong) NSMutableArray * modelArrs;
/** 组数据模型 */
@property(nonatomic,strong) NSMutableArray * groupArrs;

@property(nonatomic,strong) ZXShoppingCarBottomModel * bottomModel;

@end

@implementation ZXThirdController


-(NSMutableArray *)modelArrs
{
    if (_modelArrs == nil) {
        _modelArrs = [NSMutableArray array];
    }
    return _modelArrs;
}

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
    
    self.bottomModel = [[ZXShoppingCarBottomModel alloc]init];
    self.allPrices.text = self.bottomModel.priceText;
    [self.payMoneyButton setTitle:[NSString stringWithFormat:@"去结算(共%d件)",self.bottomModel.counts] forState:UIControlStateNormal];
    
    [self setupTable];


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
    NSDictionary *dic = self.carLists[section];
    NSMutableArray *array = dic[@"goodsInfo"];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    [self imputedAllPrice];
    ZXShoppingCarHeaderView *headerView = [ZXShoppingCarHeaderView headerViewWithTableView:tableView];
    ZXHeaderMerchantModel * headModel = self.groupArrs[section];
    headerView.model = headModel;
    headerView.headerDelegate = self;
    headerView.tag = section + 1000;
    return headerView;
}

#pragma mark - 点击section头部左上角按钮对应事件
-(void)didClickShoppingCarHeaderViewSelectAllOfCellInSection:(ZXShoppingCarHeaderView *)headerView mark:(NSString *)mark{
    NSInteger indexpath = headerView.tag - 1000;
    ZXHeaderMerchantModel *headModel = self.groupArrs[indexpath];
    NSArray *allSelectArr = self.modelArrs[indexpath];
    
    if ([mark isEqualToString:@"select"] && headerView.headerSelectBtn.selected) {
            for (ZXGoodsModel * model in allSelectArr)
            {
                model.isSelect = YES;
                headModel.isSelect = YES;
            }
            [self isallSelectAllPrice];
        }else
        {
            for (ZXGoodsModel * model in allSelectArr)
            {
                model.isSelect = NO;
                headModel.isSelect = NO;
            }
            [self isallSelectAllPrice];
            self.allSelectButton.selected = NO;
    }
    //检测是否全部选中,如果全部选择,全选按钮✅号,否则不
    [self.tableView reloadData];
}

//点击编辑按钮进行数量改变和删除
- (void)didClickShoppingCarHeaderViewEditButton:(ZXShoppingCarHeaderView *)header
{
    header.editBtn.selected = !header.editBtn.selected;
    NSInteger indexpath = header.tag - 1000;
    NSArray *allSelectArr = self.modelArrs[indexpath];
    ZXHeaderMerchantModel *headModel = self.groupArrs[indexpath];
    headModel.isEdited = header.editBtn.selected;
    headModel.isShowMinus = header.editBtn.selected;
    headModel.isShowPlus = header.editBtn.selected;

    if (header.editBtn.selected) {
        for (NSInteger i = 0; i < allSelectArr.count; i ++) {
            ZXShoppingCarCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:indexpath]];
            if (headModel.isShowPlus) {
                cell.leading.constant = -78;
                cell.trailing.constant = -8;
            }
            cell.plus.hidden = !headModel.isShowPlus;
            cell.minus.hidden = !headModel.isShowMinus;
            [UIView animateWithDuration:0.3 animations:^{
                [cell layoutIfNeeded];
            }];
        }
    }else if(!header.editBtn.selected){
        for (NSInteger i = 0; i < allSelectArr.count; i ++) {
            ZXShoppingCarCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:indexpath]];
            if (!headModel.isShowPlus) {
                cell.leading.constant = 0;
                cell.trailing.constant = -78;
            }
            cell.plus.hidden = !headModel.isShowMinus;
            cell.minus.hidden = !headModel.isShowMinus;
            [UIView animateWithDuration:0.3 animations:^{
                [cell layoutIfNeeded];
            }];
        }
    }
}

//点击cell删除按钮删除cell
-(void)didClickDeleteButtonDeleteCurrentCell:(ZXShoppingCarCell *)cell
{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    NSDictionary *dic = self.carLists[indexPath.section];
    [dic[@"goodsInfo"] removeObjectAtIndex:indexPath.row];
    if([[self.carLists objectAtIndex:indexPath.section][@"goodsInfo"] count]  > 0)
    {
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationNone];
    }
    else{
        [self.tableView beginUpdates];
        [self.carLists removeObjectAtIndex:indexPath.section];
        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section]
                  withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView endUpdates];
    }
    ZXLog(@"self.modelArrs %@",self.modelArrs);
    [self imputedAllPrice];

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
    self.bottomModel.isSelect = sender.selected;
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
//全选
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
    self.allSelectButton.selected = self.bottomModel.isSelect;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXShoppingCarCell *cell = [ZXShoppingCarCell cellWithTableView:tableView];
    cell.headModel = self.groupArrs[indexPath.section];
    cell.model = self.modelArrs[indexPath.section][indexPath.row];
    cell.delegate = self;
    return cell;
}

/**
 *  cell的代理方法
 *
 *  @param cell     cell可以拿到indexpath
 *  @param selectBt 选中按钮
 */
- (void)shoppingCellDelegate:(ZXShoppingCarCell *)cell WithSelectButton:(UIButton *)selectBt
{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    ZXGoodsModel * model = self.modelArrs[indexPath.section][indexPath.row];
    NSArray * arr = self.modelArrs[indexPath.section];
    model.isSelect = !selectBt.selected;
    int counts = 0;
    for (ZXGoodsModel * modelArr in arr)
    {
        if(modelArr.isSelect)
        {
            counts ++ ;
        }
    }
    ZXHeaderMerchantModel * headerModel = self.groupArrs[indexPath.section];
    if(counts == arr.count)
    {
        headerModel.isSelect = YES;
       // self.allSelectButton.selected = YES;
    }else
    {
        headerModel.isSelect = NO;
        self.allSelectButton.selected = NO;
    }
    [self isallSelectAllPrice];
    [self.tableView reloadData];
}

/**
 *  计算总价
 */
- (void)imputedAllPrice
{
    int allprice = 0;
    int allCount = 0;
    for (NSArray * goodsArr in self.modelArrs)
    {
        for (ZXGoodsModel * goodsModel in goodsArr)
        {
            if(goodsModel.isSelect == YES)
            {
                int price = goodsModel.goodsCount.intValue * goodsModel.goodsPrice.intValue;
                int count = goodsModel.goodsCount.intValue;
                allCount = count + allCount;
                allprice = price + allprice;
            }
        }
    }
    NSString * priceText = [NSString stringWithFormat:@"总计 : %.2f",allprice / 100.0];
    self.bottomModel.priceText = priceText;
    self.bottomModel.counts = allCount;

    self.allPrices.text = self.bottomModel.priceText;
    [self.payMoneyButton setTitle:[NSString stringWithFormat:@"去结算(共%d件)",self.bottomModel.counts] forState:UIControlStateNormal];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (IBAction)didClickPayMoneyButton:(id)sender {
    if (self.bottomModel.counts == 0) {
        
    }else{
    ZXShopCarConfirmOrderController *vc = [[ZXShopCarConfirmOrderController alloc] init];
    vc.title = @"确认订单";
    [self.navigationController pushViewController:vc animated:YES];
    }
}



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
