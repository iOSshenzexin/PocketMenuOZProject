//
//  ZXFirstController.m
//  PocketMenu
//
//  Created by 杨晓婧 on 16/7/4.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXFirstController.h"

#import "TopBannerTool.h"

#import "AdvertiseViewController.h"
#import "DeliciousFoodController.h"
#import "ZXDessertAndDrinksController.h"
#import "ZXGroupBuyController.h"
#import "ZXSupermarketController.h"

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
#import "ZXSearchController.h"

#import "ZXTodayRecommendedController.h"
#import "ZXGuessYouLikeController.h"

#import "ZXShawdowView.h"


#import "ZXStoreTypeModel.h"

@interface ZXFirstController ()<KNBannerViewDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate,ZXTodayRecommendedCellDelegate,ZXYouLikeCellDelegate>
{
    GMSPlacesClient *_placesClient;
}

@property (nonatomic, strong, readwrite) UILabel *titileLabel;

@property (nonatomic, strong, readwrite) NSMutableArray *movies;

/* 主题Collectionview */
@property (nonatomic,weak) UICollectionView *themeCV;
/* 今日推荐Collectionview */
@property (nonatomic,weak) UICollectionView *todayCV;
/* 猜你喜欢Collectionview */
@property (nonatomic,weak) UICollectionView *youLikeCV;

@property (nonatomic,weak) ZXShawdowView *shawdow;

@property (nonatomic,weak) UITableView *cityTableView;

@property (nonatomic,weak) UIButton *leftButton;


//假数据
@property (nonatomic,strong) NSMutableArray *pics;
@property (nonatomic,strong) NSMutableArray *colors;
@property (nonatomic,strong) NSMutableArray *titles;
@property (nonatomic,strong) NSMutableArray *btnPics;




@end

@implementation ZXFirstController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startGoogleMap];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupTableViewHeader];
    /* 点击广告跳转到广告页面 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToAd) name:@"pushtoad" object:nil];
    /* 设置NavigationBarButton */
    [self setupNavigationBarBtn];
    [self.homeTableView.mj_header beginRefreshing];
    [self setDatas];
    [self loadDatas];
}

- (void)loadDatas
{
    [ZXNetworkTool byAFNPost: PocketMenuOZ_HomeStroeListAPI parameters:nil success:^(id responseObject) {
        self.titles = [ZXStoreTypeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.themeCV reloadData];
    } failure:^(NSError *error) {
        ZXLog(@"%@",error);
    }];
}


- (void)setDatas{
    self.pics = [NSMutableArray arrayWithObjects:@"module01-img01",@"module01-img02",@"module01-img03",@"module01-img04", nil];
    //self.titles = [NSMutableArray arrayWithObjects:@"美食",@"超市",@"甜品饮料",@"团购", nil];
    self.colors = [NSMutableArray arrayWithObjects:RGB(214, 108, 45),RGB(227, 197, 53),RGB(182, 198, 53),RGB(130, 190, 205), nil];
    
    self.btnPics = [NSMutableArray arrayWithObjects:@"module01-icon01",@"module01-icon02",@"module01-icon03",@"module01-icon04", nil];
}

#pragma mark - 设置表格头部
- (void)setupTableViewHeader{
    /* 设置主页的头部轮播图 */
    self.homeTableView.tableHeaderView = [TopBannerTool setupNetWorkBannerViewAtViewController:self height:200];
    //去掉tableView的分割线
    self.homeTableView.separatorStyle = UITableViewCellSelectionStyleNone;
}


- (void)startGoogleMap
{
    if ([CLLocationManager locationServicesEnabled]) {
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    _placesClient = [[GMSPlacesClient alloc] init];
    [_placesClient currentPlaceWithCallback:^(GMSPlaceLikelihoodList *placeLikelihoodList, NSError *error){
        if (error != nil) {
            NSLog(@"Pick Place error %@", [error localizedDescription]);
            return;
        }
        if (placeLikelihoodList != nil) {
            GMSPlace *place = [[[placeLikelihoodList likelihoods] firstObject] place];
           // GMSAddressComponent *a = [place.addressComponents firstObject];
            if (place != nil) {
                [self.leftButton setTitle:place.addressComponents[2].name forState:UIControlStateNormal];
                [self.leftButton sizeToFit];
//                for (GMSAddressComponent *sub in place.addressComponents) {
//                     ZXLog(@"self.nameLabel.text %@",sub.name);
//                }
//            ZXLog(@"self.nameLabel.text %@",place.addressComponents);
//            ZXLog(@"self.addressLabel.text = %@", [[place.formattedAddress componentsSeparatedByString:@", "]
//        componentsJoinedByString:@"\n"]);
        }
        }
        }];
    }
}

#pragma mark  设置NavigationBarButton
- (void)setupNavigationBarBtn{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithFont:0 btnWidth:21 btnHeight:21 image:@"news" highlightImage:nil title:nil target:self action:@selector(didClickMessage) leftEdgeInset:0 rightEdgeInset:-10];
//  左侧按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"arrows"] forState:UIControlStateNormal];
    [btn setTitle: @"定位中" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn sizeToFit];
    self.leftButton = btn;
   [btn addTarget:self action:@selector(didClickAddress:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn_left = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, btn_left, nil];

//  搜索框
    
    ZXSearchBar *searchBar = [[ZXSearchBar alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 30)];
    searchBar.placeholder = @"搜索商家,品类或商圈";
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    
    self.homeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewInfo)];
}

#pragma  mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    ZXSearchController *vc = [[ZXSearchController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    return NO;
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
- (void)didClickAddress:(UIButton *)btn
{
    if (self.shawdow) {
        [self.shawdow szx_removeSubViews];
        self.shawdow = nil;
    }else{
    ZXShawdowView *shawdow = [[ZXShawdowView alloc] initWithSubViewOfFrame:CGRectMake(0, 0, ScreenW, 300)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideShawdowView:)];
        [shawdow.superview.superview addGestureRecognizer:tap];
        
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, shawdow.bounds.size.width, shawdow.bounds.size.height) style:UITableViewStyleGrouped];
        table.delegate = self;
        table.dataSource = self;
        table.sectionFooterHeight = 0;
        table.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,0,0,0.1)];
        table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
       [shawdow addSubview:table];
    self.cityTableView = table;
    self.shawdow = shawdow;
    }
}


- (void)hideShawdowView:(UITapGestureRecognizer *)tap{
    CGPoint point = [tap locationInView:tap.view];
    if (point.y > self.shawdow.frame.size.height) {
        [self.shawdow szx_removeSubViews];
        self.shawdow = nil;
    }
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.cityTableView) {
        return 3;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.cityTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cityCell"];
        }
        cell.textLabel.text = @"珀斯";
        return cell;
    }else{
    if (indexPath.row == 0) {
        ZXThemeZoneCell *cell = [ZXThemeZoneCell cellWithTableView:tableView];
        cell.collectionView.dataSource = self;
        cell.collectionView.delegate = self;
        self.themeCV = cell.collectionView;
        return cell;
    }
    if (indexPath.row == 1) {
        ZXTodayRecommendedCell *cell = [ZXTodayRecommendedCell cellWithTableView:tableView];
        cell.delegate = self;
        cell.todayCV.dataSource = self;
        cell.todayCV.delegate = self;
        self.todayCV = cell.todayCV;
        return cell;
    }
    ZXYouLikeCell *cell = [ZXYouLikeCell cellWithTableView:tableView];
        cell.delegate = self;
    cell.youLikeCV.dataSource = self;
    cell.youLikeCV.delegate = self;
    self.youLikeCV = cell.youLikeCV;
    return cell;
    }
    return nil;
}


-(void)enterTodayRecommendController:(ZXTodayRecommendedCell *)cell
{
    ZXGuessYouLikeController *vc = [[ZXGuessYouLikeController alloc] init];
    vc.title = @"今日推荐";
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)enterZXGuessYouLikeCellController:(ZXYouLikeCell *)cell
{
    ZXTodayRecommendedController *vc = [[ZXTodayRecommendedController alloc] init];
    vc.title = @"猜你喜欢";
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.cityTableView) {
        return 2;
    }else{
        return 1;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *headerTitles = @[[NSString stringWithFormat:@"当前城市: %@",self.leftButton.titleLabel.text],@"附近地址"];
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
    if (tableView == self.cityTableView) {
        return 40;
    }
    return 0;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.themeCV | collectionView == self.todayCV) {
        return self.titles.count;
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
        cell.picture.image = [UIImage imageNamed:self.pics[indexPath.row]];
        cell.typeModel =  self.titles[indexPath.row];
        cell.contentBtn.backgroundColor = self.colors[indexPath.row];
        cell.icon.image = [UIImage imageNamed:self.btnPics[indexPath.row]];
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
    UIViewController *vc;
    if (indexPath.row == 1) {
        vc = [[ZXDessertAndDrinksController alloc] init];
        vc.title = @"甜品饮料";
    }else if (indexPath.row == 3){
        vc = [[ZXGroupBuyController alloc] init];
        vc.title = @"团购";
    }
    else if (indexPath.row == 0){
        vc = [[DeliciousFoodController alloc] init];
        vc.title = @"美食";
    }else{
        vc = [[ZXSupermarketController alloc] init];
    }
     vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.cityTableView) {
        return 44;
    }else{
    if (indexPath.row == 0) {
        return 210;
    }else if (indexPath.row == 1){
        return 287;
    }
    return 270;
    }
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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.shawdow.superview.superview removeFromSuperview];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //self.view = nil;
}



@end
