//
//  DeliciousFoodController.m
//  PocketOrder
//
//  Created by 杨晓婧 on 16/8/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "DeliciousFoodController.h"
#import "ZXProductListController.h"

#import "LSSelectMenuView.h"

#import "ZXFoodMerchantsCell.h"
#import "ZXSearchController.h"
#define topTitleHeight 44
@interface DeliciousFoodController ()<LSSelectMenuViewDelegate,LSSelectMenuViewDataSource,UITableViewDelegate,UITableViewDataSource>{
    LSSelectMenuView *menuView;
    NSArray *menuInfo;
    
    UITableView *_mytableview;
}

@end

@implementation DeliciousFoodController

static NSString *cellID = @"cellID";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMenuView];
}

- (void)setupMenuView{
    _mytableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH )];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _mytableview.backgroundColor = DefaultColor;
    _mytableview.delegate = self;
    _mytableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mytableview.dataSource = self;
    [self.view addSubview:_mytableview];
    [_mytableview registerNib:[UINib nibWithNibName:@"ZXFoodMerchantsCell" bundle:nil] forCellReuseIdentifier:cellID];
    _mytableview.contentInset = UIEdgeInsetsMake(54, 0, 0, 0);
    //
   
    
    menuInfo = @[@"商家分类",@"智能排序"];
    menuView = [[LSSelectMenuView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, topTitleHeight)];
    menuView.backgroundColor = [UIColor whiteColor];
    menuView.delegate = self;
    menuView.dataSource = self;
    [self.view addSubview:menuView];
    
    UIView* showView = [[UIView alloc] initWithFrame:CGRectMake(0, menuView.frame.origin.y+menuView.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height-64-44)];
    showView.backgroundColor = [UIColor colorWithRed:0.145 green:0.145 blue:0.145 alpha:0.65];
    [self.view addSubview:showView];
    menuView.showView = showView;
//    _mytableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewInfo)];
}
//
//-(void)loadNewInfo
//{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [_mytableview.mj_header endRefreshing];
//    });
//
//}

- (void)setupNavigationBarBtn{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithFont:0 btnWidth:20 btnHeight:21 image:@"Search" highlightImage:@"Search-cilck" title:nil target:self action:@selector(didClickSearch:) leftEdgeInset:0 rightEdgeInset:-8];
}

- (void)didClickSearch:(UIButton *)btn{
    ZXSearchController *vc = [[ZXSearchController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
    return 200 + index * 50;
}

- (UIView*)menuView:(LSSelectMenuView *)menuview currViewAtIndex:(NSInteger)index{
    UIView* vv = [[UIView alloc] initWithFrame:CGRectZero];
    vv.backgroundColor = [self randomColor];
    return vv;
}

#pragma mark - LSSelectMenuViewDelegate

- (void)selectMenuView:(LSSelectMenuView *)selectmenuview didSelectAtIndex:(NSInteger)index{
   // NSLog(@"show row = %ld",index);
    
}

- (void)selectMenuView:(LSSelectMenuView *)selectmenuview didRemoveAtIndex:(NSInteger)index{
  //  NSLog(@"remove row = %ld",index);
}

#pragma mark - UITableDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXFoodMerchantsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (!cell) {
        cell = [[ZXFoodMerchantsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZXFoodMerchantsCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    ZXProductListController *vc = [[ZXProductListController alloc] init];
    vc.title = cell.goodsTitle.text;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180.0;
}

@end
