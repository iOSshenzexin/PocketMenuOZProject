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
extern int btnH;

@interface ZXProductListController ()<LeftSelectScrollDelegate,UITableViewDataSource,UITableViewDelegate>{
    LeftSelectScroll *leftScrollView;
    
    NSMutableArray *leftDataSource;
    
    //当点击的时候 不去调用滑动调节
    BOOL isScrollSetSelect;
    
    UITableView *_tableViewList;
}
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
//    self.navigationController.navigationBarHidden = YES;
//    self.navigationController.navigationBar.alpha = 0.5;
    [self initObjects];
    
    [self creatLeftScrollView];
    
    [self createTableView];
    
    
}
 //初始化数据源
-(void)initObjects{
    leftDataSource = [[NSMutableArray alloc]initWithObjects:@"披萨",@"意大利面",@"饮料",@"水果",@"套餐",@"米线",@"小炒",@"汤,粥",@"小吃",@"意大利面",@"饮料",@"水果",@"披萨",@"意大利面",@"饮料",@"水果",@"套餐",@"米线",@"小炒",@"汤,粥",nil];
}

static NSString *cellID = @"cellId";
-(void)createTableView{
    _tableViewList = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftScrollView.frame), leftScrollY, kScreenWidth * 0.75, kScreenHeight-(kTabbar_H)-leftScrollY)];
    _tableViewList.delegate = self;
    _tableViewList.dataSource = self;
    _tableViewList.tag = 21;//标识tableView
    [self.view addSubview:_tableViewList];
    _tableViewList.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableViewList registerNib:[UINib nibWithNibName:@"ZXDishesCell" bundle:nil] forCellReuseIdentifier:cellID];
}

 //左侧列表
-(void)creatLeftScrollView{
    leftScrollView = [[LeftSelectScroll alloc]initWithFrame:CGRectMake(0, leftScrollY, kScreenWidth * 0.25, kScreenHeight-(kTabbar_H)-leftScrollY)];
    NSInteger count = leftDataSource.count;
    leftScrollView.pagingEnabled = YES;
    leftScrollView.bounces = YES;
    leftScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //leftScrollView.con
    
    leftScrollView.contentSize = CGSizeMake(0, btnH * count);
    
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

//实际需要会修改
-(UIView*)viewForHeaderView:(NSInteger)parama{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 32)];
    label.backgroundColor = [UIColor orangeColor];
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXDishesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ZXDishesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
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
