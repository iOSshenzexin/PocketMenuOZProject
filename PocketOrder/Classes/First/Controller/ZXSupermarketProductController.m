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

#import "WZLBadgeImport.h"



#define topTitleHeight 44
@interface ZXSupermarketProductController ()<LSSelectMenuViewDelegate,LSSelectMenuViewDataSource,UITableViewDelegate,UITableViewDataSource>{
    LSSelectMenuView *menuView;
    NSArray *menuInfo;
    
    UITableView *_mytableview;
    
    UITableView *_listView;
}
@property (nonatomic, assign) NSInteger row;
@property (nonatomic,copy) NSMutableArray *listArray;

@property (nonatomic, assign) NSInteger goodsCount;

@end

@implementation ZXSupermarketProductController


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMenuView];
    self.listArray = [NSMutableArray arrayWithObjects:@"伊利",@"蒙牛",@"德亚",@"特仑苏",@"牧牌",@"琴牌",nil];
    
    //[_mytableview.mj_header beginRefreshing];
    [self setupNavigationBarBtn];
}

- (void)setupNavigationBarBtn{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithFont:0 btnWidth:30 btnHeight:21 image:@"shopping_car" highlightImage:@"shopping_car" title:nil target:self action:@selector(didClickShoppingCar:) leftEdgeInset:-10 rightEdgeInset:10];
    /*
     */
    self.navigationItem.rightBarButtonItem.badgeBgColor = [UIColor blueColor];
    self.navigationItem.rightBarButtonItem.badgeTextColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem.badgeFont = [UIFont boldSystemFontOfSize:10];
    self.navigationItem.rightBarButtonItem.badgeMaximumBadgeNumber = 99;
    self.navigationItem.rightBarButtonItem.badgeCenterOffset = CGPointMake(-10, 0);
    if (self.goodsCount == 0) {
        
    }else{
    [self.navigationItem.rightBarButtonItem showBadgeWithStyle:WBadgeStyleNumber value:self.goodsCount animationType:2];
    }
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
    
    [self addAnimationForSelectGoods:cell rowAtIndexPath:indexPath tableView:tableView];

    return cell;
}

/**
 给cell添加动画效果
 */
- (void)addAnimationForSelectGoods:(ZXSupermarketProductCell *)cell rowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView
{
    __weak typeof(cell) weakCell = cell;
    [cell setDidClickAddBtnHandle:^{
        //计算每行行高
        self.row = indexPath.row;
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = weakCell.imgView.image;
        CGRect cellRect = [tableView rectForRowAtIndexPath:indexPath];
        cellRect.size.width = cellRect.size.height;
        cellRect.origin.y -= tableView.contentOffset.y;
        imageView.frame = cellRect;
        [self.view addSubview:imageView];
        
        CABasicAnimation* rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 11.0 ];
        rotationAnimation.duration = 1.0;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = 0;
        
        // 这个是让旋转动画慢于缩放动画执行
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [imageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        });
        
        [UIView animateWithDuration:1.0 animations:^{
            imageView.frame = CGRectMake(self.view.bounds.size.width-10, -(self.view.bounds.size.height - CGRectGetHeight(self.view.frame)) - 30, 0, 0);
        } completion:^(BOOL finished) {
            [imageView removeFromSuperview];
            self.goodsCount ++;
           [self.navigationItem.rightBarButtonItem showBadgeWithStyle:WBadgeStyleNumber value:self.goodsCount animationType:2];
        }];
    }];
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
