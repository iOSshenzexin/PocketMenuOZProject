//
//  ZXSupermarketController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/3.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXSupermarketController.h"

#import "ZXSupermarketListController.h"
#import "LeftSelectScroll.h"
#import "ZXSupmarketCollectionCell.h"
extern int btnH;

@interface ZXSupermarketController ()<LeftSelectScrollDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    LeftSelectScroll *leftScrollView;
    NSMutableArray *leftDataSource;
    //当点击的时候 不去调用滑动调节
    BOOL isScrollSetSelect;
    UICollectionView *_collectionViewList;

}

@property (weak, nonatomic) IBOutlet UIView *bottom;


@end

@implementation ZXSupermarketController

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (IBAction)didClickJumpToSupmarketList:(id)sender {
    ZXSupermarketListController *vc = [[ZXSupermarketListController alloc] init];
    vc.title = @"选择超市";
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)didClickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)didClickShoppingCar:(id)sender {
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initObjects];
    [self creatLeftScrollView];
    [self createCollectionView];
}

//初始化数据源
-(void)initObjects{
    leftDataSource = [[NSMutableArray alloc]initWithObjects:@"热门推荐",@"意大利面",@"饮料",@"水果",@"套餐",@"米线",@"小炒",nil];
}

-(void)createCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    layout.minimumLineSpacing = 5;
//    
//    layout.minimumInteritemSpacing = 5;
    
    _collectionViewList = [[UICollectionView alloc] initWithFrame:CGRectMake(ScreenW * 0.25, 0, ScreenW * 0.75,ScreenH - 113) collectionViewLayout:layout];
    // ScreenH - 113
    [_collectionViewList registerNib:[UINib nibWithNibName:@"ZXSupmarketCollectionCell"bundle:nil]forCellWithReuseIdentifier:supmarketCollectionCell];

    _collectionViewList.delegate = self;
    _collectionViewList.dataSource = self;
    _collectionViewList.backgroundColor = RGB(242, 242, 242);
    _collectionViewList.tag = 21; //标识tableView
    [self.bottom addSubview:_collectionViewList];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80, 100);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 5, 0, 0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZXSupmarketCollectionCell *cell = [ZXSupmarketCollectionCell cellWithTableView:collectionView indexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

//左侧列表
-(void)creatLeftScrollView{
    leftScrollView = [[LeftSelectScroll alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.25,ScreenH - 113)];
    NSInteger count = leftDataSource.count;
    leftScrollView.pagingEnabled = YES;
    leftScrollView.bounces = YES;
    leftScrollView.contentSize = CGSizeMake(0, btnH * count);
    leftScrollView.autoresizesSubviews = NO;
    [leftScrollView setLeftSelectArray:leftDataSource];
    leftScrollView.leftSelectDelegate = self;
    leftScrollView.delegate = self;
    [self.bottom addSubview:leftScrollView];
}


#pragma mark -点击左侧ScrollView切换右侧TableView的代理方法
-(void)clickLeftSelectScrollButton:(NSInteger)indexPath{
    CGFloat offsetX = btnH * indexPath - leftScrollView.frame.size.height * 0.5;
    if (offsetX < 0) {
        offsetX = 0;
    }
    [leftScrollView setContentOffset:CGPointMake(0, offsetX) animated:YES];
    CGFloat maxOffsetX = leftScrollView.contentSize.height - leftScrollView.frame.size.height;
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    [leftScrollView setContentOffset:CGPointMake(0, offsetX) animated:YES];
    isScrollSetSelect = NO;
  //  [_collectionViewList scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    isScrollSetSelect = YES ;
}

@end
