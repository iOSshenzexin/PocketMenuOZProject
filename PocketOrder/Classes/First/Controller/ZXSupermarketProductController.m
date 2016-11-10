//
//  ZXSupermarketProductController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/7.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXSupermarketProductController.h"
#import "ZXTabBarController.h"
#import "LSSelectMenuView.h"

#import "ZXSupermarketProductCell.h"
#import "ZXSupermarketProductDetailController.h"
#define topTitleHeight 44
@interface ZXSupermarketProductController ()<LSSelectMenuViewDelegate,LSSelectMenuViewDataSource,UITableViewDelegate,UITableViewDataSource>{
    LSSelectMenuView *menuView;
    NSArray *menuInfo;
    
    UITableView *_mytableview;
    
    UITableView *_listView;
}

@property (nonatomic,copy) NSMutableArray *listArray;
@end

@implementation ZXSupermarketProductController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMenuView];
    self.listArray = [NSMutableArray arrayWithObjects:@"伊利",@"蒙牛",@"德亚",@"特仑苏",@"牧牌",@"琴牌",nil];
    
    //[_mytableview.mj_header beginRefreshing];
    [self setupNavigationBarBtn];
}

- (void)setupNavigationBarBtn{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithFont:0 btnWidth:20 btnHeight:21 image:@"shopping_car" highlightImage:@"shopping_car" title:nil target:self action:@selector(didClickShoppingCar:) leftEdgeInset:0 rightEdgeInset:-8];
}

- (void)didClickShoppingCar:(UIButton *)sender {
    UIApplication *app = [UIApplication sharedApplication];
    ZXTabBarController *tabVc = [ZXTabBarController sharedTabBarController];
    tabVc.selectedIndex = 2;
    app.keyWindow.rootViewController = tabVc;
}


- (void)setupMenuView{
    _mytableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - topTitleHeight - 10 - 10)];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _mytableview.backgroundColor = DefaultColor;
    _mytableview.delegate = self;
    _mytableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mytableview.contentInset = UIEdgeInsetsMake(54, 0, 0, 0);
    _mytableview.dataSource = self;
    
    [self.view addSubview:_mytableview];
    
    menuInfo = @[@"品牌",@"价格"];
    menuView = [[LSSelectMenuView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, topTitleHeight)];
    menuView.backgroundColor = [UIColor whiteColor];
    menuView.delegate = self;
    menuView.dataSource = self;
    [self.view addSubview:menuView];
    
    // _mytableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewInfo)];
    
    UIView* showView = [[UIView alloc] initWithFrame:CGRectMake(0, menuView.frame.origin.y+menuView.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - 64 - topTitleHeight)];
    showView.backgroundColor = [UIColor colorWithRed:0.145 green:0.145 blue:0.145 alpha:0.65];
    [self.view addSubview:showView];
    menuView.showView = showView;
    
}


// 加载数据
-(void)loadNewInfo
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_mytableview.mj_header endRefreshing];
    });
    
}



- (UIColor *)randomColor{
    static BOOL seeded = NO;
    if (!seeded) {
        seeded = YES;
        (time(NULL));
    }
    CGFloat red = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random() / (CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

#pragma mark - LSSelectMenuViewDataSource

- (NSInteger)numberOfItemsInMenuView:(LSSelectMenuView *)menuview{
    return menuInfo.count;
}

- (NSString*)menuView:(LSSelectMenuView *)menuview titleForItemAtIndex:(NSInteger)index{
    return menuInfo[index];
}


- (CGFloat)menuView:(LSSelectMenuView *)menuview heightForCurrViewAtIndex:(NSInteger)index{
    return 200;
    //return _listView.frame.size.height;
}

- (UIView*)menuView:(LSSelectMenuView *)menuview currViewAtIndex:(NSInteger)index{
    UIView* vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0)];
    UITableView *tableView = [[UITableView alloc] initWithFrame:vv.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tag = index;
    _listView = tableView;
    
    vv.backgroundColor = [self randomColor];
    [vv addSubview:tableView];
    return vv;
}

#pragma mark - LSSelectMenuViewDelegate

- (void)selectMenuView:(LSSelectMenuView *)selectmenuview didSelectAtIndex:(NSInteger)index{
    
    NSLog(@"show row = %ld",index);
    
}

- (void)selectMenuView:(LSSelectMenuView *)selectmenuview didRemoveAtIndex:(NSInteger)index{
    NSLog(@"remove row = %ld",index);
}

#pragma mark - UITableDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _listView) {
        return self.listArray.count;
    }
    return 10;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _listView) {
        static NSString *cellId = @"cellId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        }
        cell.imageView.image = [UIImage imageNamed:@"mark1"];
        cell.textLabel.text = self.listArray[indexPath.row];
        cell.detailTextLabel.text = self.listArray[indexPath.row];
        return cell;
    }
    ZXSupermarketProductCell *cell = [ZXSupermarketProductCell cellWithTableView:tableView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _listView) {
        [menuView closeCurrViewWithIndex:_listView.tag];
        ZXLog(@"indexPath.row %ld",indexPath.row);
        
    }else{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        ZXSupermarketProductDetailController *vc = [[ZXSupermarketProductDetailController alloc] init];
        vc.title = @"伊利官方直营味可滋香蕉牛奶";
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _listView) {
        return 46;
    }
    return 100;
}

@end
