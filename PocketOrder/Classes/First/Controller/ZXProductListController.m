//
//  ZXProductListController.m
//  PocketOrder
//
//  Created by 杨晓婧 on 16/8/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXProductListController.h"

#import "LeftSelectScroll.h"
#import "ZXDishesCell.h"


#import "ZXAddAdressController.h"

#import "OverlayView.h"
#import "ShoppingCartView.h"
#import "BadgeView.h"

extern int btnH;

@interface ZXProductListController ()<LeftSelectScrollDelegate,UITableViewDataSource,UITableViewDelegate,ZFReOrderTableViewDelegate>{
    LeftSelectScroll *leftScrollView;
    
    NSMutableArray *leftDataSource;
    
    //当点击的时候 不去调用滑动调节
    BOOL isScrollSetSelect;
    
    UITableView *_tableViewList;
}


@property (nonatomic,strong) ShoppingCartView *ShopCartView;

@end

@implementation ZXProductListController

 //结算
- (IBAction)didClickSettlementting:(id)sender {
    ZXAddAdressController *vc = [[ZXAddAdressController alloc] init];
    vc.title = @"新增地址";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.translucent = YES;
//    self.navigationController.navigationBar.shadowImage = [UIImage new];

    [self initObjects];
    
    [self creatLeftScrollView];
    
    [self createTableView];
    
    [self createShopCarView];


}

- (void)createShopCarView
{
    _ShopCartView = [[ShoppingCartView alloc] initWithFrame:CGRectMake(0, ScreenH - 46, ScreenW, 46) inView:self.view withObjects:nil];
    _ShopCartView.parentView = self.view;
    _ShopCartView.OrderList.delegate = self;
    _ShopCartView.OrderList.tableView.delegate = self;
    _ShopCartView.OrderList.tableView.dataSource = self;
    _ShopCartView.backgroundColor = RGB(239, 239, 239);
    [self.view addSubview:_ShopCartView];
}


 //初始化数据源
-(void)initObjects{
    leftDataSource = [[NSMutableArray alloc]initWithObjects:@"披萨",@"意大利面",@"饮料",@"水果",@"套餐",@"米线",@"小炒",@"汤,粥",@"小吃",@"意大利面",@"饮料",@"水果",@"披萨",@"意大利面",@"饮料",@"水果",@"套餐",@"米线",@"小炒",@"汤,粥",nil];
}

-(void)createTableView{
    _tableViewList = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.25, leftScrollY+1, kScreenWidth * 0.75, ScreenH-leftScrollY-46)];
    _tableViewList.delegate = self;
    _tableViewList.dataSource = self;
    _tableViewList.rowHeight = 105;
    _tableViewList.backgroundColor = RGB(242, 242, 242);
    _tableViewList.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableViewList.tag = 21;//标识tableView
    [self.view addSubview:_tableViewList];
    _tableViewList.separatorStyle = UITableViewCellSeparatorStyleNone;
}

 //左侧列表
-(void)creatLeftScrollView{
    leftScrollView = [[LeftSelectScroll alloc]initWithFrame:CGRectMake(0, leftScrollY+1, kScreenWidth * 0.25,ScreenH-leftScrollY-46)];
    NSInteger count = leftDataSource.count;
    leftScrollView.pagingEnabled = YES;
    leftScrollView.bounces = YES;
    
    leftScrollView.contentSize = CGSizeMake(0, btnH * count);
    leftScrollView.autoresizesSubviews = NO;
    [leftScrollView setLeftSelectArray:leftDataSource];
    
    leftScrollView.leftSelectDelegate = self;
    
    leftScrollView.delegate = self;
    
    [self.view addSubview:leftScrollView];
}

#pragma mark 点击左侧切换右侧的代理方法
-(void)clickLeftSelectScrollButton:(NSInteger)indexPath{
    CGFloat count = (leftScrollView.bounds.size.height / btnH);
    if ((indexPath + 1) * btnH > leftScrollView.bounds.size.height) {
        [leftScrollView setContentOffset:CGPointMake(0, btnH * (indexPath - count)+ btnH) animated:YES];
    }
    isScrollSetSelect = NO;
    [_tableViewList scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView.tag == 21) {
        if (isScrollSetSelect == YES) {
            [leftScrollView setSelectButtonWithIndexPathSection:section];
            CGFloat count = leftScrollView.bounds.size.height / btnH;
            if ((section + 1) * btnH > leftScrollView.bounds.size.height) {
                 [leftScrollView setContentOffset:CGPointMake(0, btnH * (section - count)+ btnH) animated:YES];
            }
            if (section == 1) {
                [leftScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            }
        }
        return [self viewForHeaderView:section];
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 32;
}


//实际需要会修改
-(UIView*)viewForHeaderView:(NSInteger)parama{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth*0.75, 32)];
    label.backgroundColor = RGB(239, 239, 239);
    if (leftDataSource.count != 0) {
        label.text = leftDataSource[parama];
        label.font = [UIFont systemFontOfSize:14];
        //[NSString stringWithFormat:@"第%ld组",(long)parama];
    }
    return label;
}

 #pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  leftDataSource.count ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXDishesCell *cell = [ZXDishesCell cellWithTableView:tableView];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXAddAdressController *vc = [[ZXAddAdressController alloc] init];
    vc.title = @"新增地址";
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    isScrollSetSelect = YES ;
}


@end
