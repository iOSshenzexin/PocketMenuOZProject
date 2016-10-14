//
//  ZXFirstController.m
//  PocketMenu
//
//  Created by 杨晓婧 on 16/7/4.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXFirstController.h"

#import "KNBannerView.h"
#import "TopBannerTool.h"

#import "AdvertiseViewController.h"
#import "DeliciousFoodController.h"

#import "BGRefresh.h"
#import "ZXSearchBar.h"

/** 自定义cell */
#import "ZXThemeZoneCell.h"
#import "ZXTodayRecommendedCell.h"
#import "ZXYouLikeCell.h"
/* collectionviewCell */
#import "ZXSquareCell.h"
#import "ZXTodayCell.h"
#import "ZXLikeCell.h"


#import "ZXMessageController.h"
#import "ZXHomePictureController.h"

// 搭界面用
#import "ZXAddAdressController.h"
@interface ZXFirstController ()<KNBannerViewDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong, readwrite) UILabel *titileLabel;

@property (nonatomic, strong, readwrite) NSMutableArray *movies;

/* 主题Collectionview */
@property (nonatomic,weak) UICollectionView *themeCV;
/* 今日推荐Collectionview */
@property (nonatomic,weak) UICollectionView *todayCV;
/* 猜你喜欢Collectionview */
@property (nonatomic,weak) UICollectionView *youLikeCV;


@end

@implementation ZXFirstController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    /* 注册自定制cell */
    [self registerTableViewCell];
    
    /* 点击广告跳转到广告页面 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToAd) name:@"pushtoad" object:nil];
    
    /* 设置NavigationBarButton */
    [self setupNavigationBarBtn];
    
    [self.homeTableView.mj_header beginRefreshing];
}


#pragma mark  设置NavigationBarButton
- (void)setupNavigationBarBtn{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithFont:0 btnWidth:21 btnHeight:21 image:@"news" highlightImage:nil title:nil target:self action:@selector(didClickMessage) leftEdgeInset:0 rightEdgeInset:-8];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 50, 21);
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    [leftBtn setTitle:@"地点" forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [leftBtn setImage:[UIImage imageNamed:@"arrows"] forState:UIControlStateNormal];
    CGFloat labelWidth = [leftBtn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:17]}].width;
    [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -leftBtn.currentImage.size.width, 0, leftBtn.currentImage.size.width)];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth - 10)];
    [leftBtn addTarget:self action:@selector(didClickAddress) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    //搜索框
    self.navigationItem.titleView = [ZXSearchBar searchBar];
    
    
    
    self.homeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewInfo)];
}

-(void)loadNewInfo
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.homeTableView.mj_header endRefreshing];
    });
}


   /*查看消息*/
- (void)didClickMessage{
    ZXMessageController *vc = [[ZXMessageController alloc] init];
    vc.title = @"消息";
    [self.navigationController pushViewController:vc animated:YES];
}

   /*选择地点*/
- (void)didClickAddress
{
    ZXAddAdressController *vc = [[ZXAddAdressController alloc] init];
    vc.title = @"添加收货地址";
    [self.navigationController pushViewController:vc animated:YES];
    ZXFunction
}

#pragma mark - 注册自定制cell
- (void)registerTableViewCell{
    /* 设置主页的头部轮播图 */
    self.homeTableView.tableHeaderView = [TopBannerTool setupNetWorkBannerViewAtViewController:self];
    [self.homeTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZXThemeZoneCell class]) bundle:nil] forCellReuseIdentifier:themeZoneCell];
    [self.homeTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZXTodayRecommendedCell class]) bundle:nil] forCellReuseIdentifier:todayRecommendedCell];
    [self.homeTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZXYouLikeCell class]) bundle:nil] forCellReuseIdentifier:youLikeCell];
    //去掉tableView的分割线
    self.homeTableView.separatorStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ZXThemeZoneCell *cell = [ZXThemeZoneCell cellWithTableView:tableView];
        [cell.collectionView registerNib:[UINib nibWithNibName:@"ZXSquareCell" bundle:nil] forCellWithReuseIdentifier:squareCell];
        cell.collectionView.dataSource = self;
        cell.collectionView.delegate = self;
        self.themeCV = cell.collectionView;
        return cell;
    }
    if (indexPath.row == 1) {
        ZXTodayRecommendedCell *cell = [ZXTodayRecommendedCell cellWithTableView:tableView];
        // 注册cell
        [cell.todayCV registerNib:[UINib nibWithNibName:@"ZXTodayCell"bundle:nil]forCellWithReuseIdentifier:todayCell];
        cell.todayCV.scrollEnabled = NO;
        cell.todayCV.dataSource = self;
        cell.todayCV.delegate = self;
        self.todayCV = cell.todayCV;
        return cell;
    }
    ZXYouLikeCell *cell = [ZXYouLikeCell cellWithTableView:tableView];
    [cell.youLikeCV registerNib:[UINib nibWithNibName:@"ZXLikeCell"bundle:nil]forCellWithReuseIdentifier:likeCell];
    cell.youLikeCV.dataSource = self;
    cell.youLikeCV.delegate = self;
    self.youLikeCV = cell.youLikeCV;
    return cell;
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.themeCV | collectionView == self.todayCV) {
        return 4;
    }
    if (section == 0) {
        return 1;
    }else{
        return 3;
    }
   
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (collectionView == self.youLikeCV) {
        return 2;
    }
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.youLikeCV) {
        if (indexPath.section == 0) {
            return CGSizeMake((ScreenW - 30) * 0.5, 216);
        }else{
            return CGSizeMake((ScreenW - 30) * 0.5, 65);
        }
    }else if (collectionView == self.todayCV){
        CGFloat itemWidth = (ScreenW - 50) * 0.25;
        return CGSizeMake(itemWidth, 108);
    }
    return CGSizeMake((ScreenW - 15) * 0.5, 77.5);;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 5, 0, 5);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.themeCV) {
        ZXSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:squareCell forIndexPath:indexPath];
        return cell;
    }else if (collectionView == self.todayCV){
        // 从缓存池取
        ZXTodayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:todayCell forIndexPath:indexPath];
        return cell;
    }
     ZXLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:likeCell forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DeliciousFoodController *vc = [[DeliciousFoodController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.title = @"美食";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 210;
    }else if (indexPath.row == 1){
        return 287;
    }
    return 270;
}


-(void)setupRefreshView{
    BGRefresh* refresh = [[BGRefresh alloc] init];
    refresh.startBlock = ^{
        NSLog(@"开始刷新....");
    };
    refresh.endBlock = ^{
        NSLog(@"结束刷新....");
    };
    refresh.isAutoEnd = YES;//设为自动结束刷新 YES/NO 自动/手动
    refresh.refreshTime = 3.0;//设置自动刷新时间(秒为单位) 手动结束刷新时不设置此项
    refresh.scrollview = self.homeTableView;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark  点击首页轮播图进入展示页
- (void)bannerView:(KNBannerView *)bannerView collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSInteger)index{
    ZXHomePictureController *vc = [[ZXHomePictureController alloc] init];
    vc.title = bannerView.IntroduceStringArr[index];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"%zd---%zd",bannerView.tag,index);
}

#pragma mark  点击广告进入详情页
- (void)pushToAd{
    AdvertiseViewController *adVc = [[AdvertiseViewController alloc] init];
    [self.navigationController pushViewController:adVc animated:YES];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.view = nil;
}



@end
