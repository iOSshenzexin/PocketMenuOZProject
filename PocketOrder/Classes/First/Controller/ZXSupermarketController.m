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
#import "ZXSupermarketListController.h"
#import "ZXSupermarketProductController.h"

#import "ZXTabBarController.h"

#import "ZXCollectionHeaderView.h"
extern int btnH;

@interface ZXSupermarketController ()<LeftSelectScrollDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ZXSupermarketListControllerDelegate,UITextFieldDelegate>
{
    LeftSelectScroll *leftScrollView;
    NSMutableArray *leftDataSource;
    //当点击的时候 不去调用滑动调节
    BOOL isScrollSetSelect;
    UICollectionView *_collectionViewList;
}

@property (weak, nonatomic) IBOutlet UIView *navigationBar;



@property (weak, nonatomic) IBOutlet UIView *bottom;

@property (weak, nonatomic) IBOutlet UIButton *marketBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchViewRightConstraint;

@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerY;



@property (nonatomic,strong) NSMutableArray *sectionsCount;

@property (nonatomic,strong) NSMutableArray *rowsCount;

@property (nonatomic,assign) NSInteger index;



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

- (IBAction)didClickCancle:(id)sender {
    self.searchBottomView.backgroundColor = RGB(239, 239, 239);
    self.topConstraint.constant = 0;
    [self.view endEditing:YES];
    self.searchViewConstraint.constant = 30;
    self.searchViewRightConstraint.constant = 30;
    self.height.constant = 44;
    self.centerY.constant = 0;
    self.cancleBtn.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    for (UIView *sub in self.bottom.subviews) {
        if ([sub isKindOfClass:[UITableView class]]) {
            [sub removeFromSuperview];
        }
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.searchBottomView.backgroundColor = self.navigationBar.backgroundColor;
    self.topConstraint.constant = -64;
    self.height.constant = 64;
    self.centerY.constant = 6;
    [self.bottom addSubview:[[UITableView alloc] initWithFrame:self.view.bounds]];
    self.searchViewConstraint.constant = 10;
    self.searchViewRightConstraint.constant = 60;
    self.cancleBtn.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    return YES;
}



- (IBAction)didClickJumpToSupmarketList:(id)sender {
    ZXSupermarketListController *vc = [[ZXSupermarketListController alloc] init];
    vc.delegate = self;
    vc.title = @"选择超市";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didClickGetsupermarketName:(ZXSupermarketListController *)vc
{
    [self.marketBtn setTitle:vc.name forState:UIControlStateNormal];
}

- (IBAction)didClickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)didClickShoppingCar:(id)sender {
    UIApplication *app = [UIApplication sharedApplication];
    ZXTabBarController *tabVc = [ZXTabBarController sharedTabBarController];
    tabVc.selectedIndex = 2;
    app.keyWindow.rootViewController = tabVc;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.sectionsCount = [NSMutableArray arrayWithObjects:@"4",@"4",@"5",@"6",@"7",@"5",@"6", nil];
     self.rowsCount = [NSMutableArray arrayWithObjects:@"4",@"4",@"5",@"6",@"7",@"5",@"6", nil];
    [self initObjects];
    [self creatLeftScrollView];
    [self createCollectionView];
}

//初始化数据源
-(void)initObjects{
    leftDataSource = [[NSMutableArray alloc]initWithObjects:@"热门推荐",@"意大利面",@"饮料",@"水果",@"套餐",@"牛奶",@"生活用品",nil];
}

-(void)createCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    layout.headerReferenceSize = CGSizeMake(ScreenW * 0.75 - 10,44);
    
    _collectionViewList = [[UICollectionView alloc] initWithFrame:CGRectMake(ScreenW * 0.25 + 3, 0, ScreenW * 0.75 - 6,ScreenH - 113) collectionViewLayout:layout];
    // ScreenH - 113
    [_collectionViewList registerNib:[UINib nibWithNibName:@"ZXSupmarketCollectionCell"bundle:nil]forCellWithReuseIdentifier:supmarketCollectionCell];
    
    //设置头视图
    [_collectionViewList registerClass:[ZXCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionHeaderView];
   
    
    _collectionViewList.delegate = self;
    _collectionViewList.dataSource = self;
    _collectionViewList.backgroundColor = RGB(236, 236, 236);
    _collectionViewList.tag = 21; //标识tableView
    [self.bottom addSubview:_collectionViewList];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.sectionsCount[self.index] integerValue];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.rowsCount[self.index] integerValue];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview;
    if (kind == UICollectionElementKindSectionHeader){
        ZXCollectionHeaderView *headerView = [ZXCollectionHeaderView headerViewWith:collectionView indexPath:indexPath];
        headerView.titleLabel.text = [self viewForHeaderView:indexPath.section];
        reusableview = headerView;
    }
     return reusableview;
}


//实际需要会修改 - 设置sectionHeaderView
-(NSString *)viewForHeaderView:(NSInteger)parama{
    NSString *title;
    if (leftDataSource.count != 0) {
        title = leftDataSource[parama];
        ZXLog(@"%@",[NSString stringWithFormat:@"第%ld组",(long)parama]);
    }
   
    return title;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenW * 0.75 - 20)/3, (ScreenW * 0.75 - 20)/3 + 20);
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZXSupmarketCollectionCell *cell = [ZXSupmarketCollectionCell cellWithTableView:collectionView indexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ZXSupermarketProductController *vc = [[ZXSupermarketProductController alloc] init];
    vc.title = @"乳制品";
    [self.navigationController pushViewController:vc animated:YES];
}

//左侧列表
-(void)creatLeftScrollView{
    leftScrollView = [[LeftSelectScroll alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.25,ScreenH - 113)];
    NSInteger count = leftDataSource.count;
  //  leftScrollView.bounces = YES;
    leftScrollView.contentSize = CGSizeMake(0, btnH * count);
    leftScrollView.autoresizesSubviews = NO;
    [leftScrollView setLeftSelectArray:leftDataSource];
    leftScrollView.leftSelectDelegate = self;
    leftScrollView.delegate = self;
    [self.bottom addSubview:leftScrollView];
}


#pragma mark -点击左侧ScrollView切换右侧CollectionView的代理方法
-(void)clickLeftSelectScrollButton:(NSInteger)indexPath{
    CGFloat offsetX = btnH * (indexPath) - leftScrollView.bounds.size.height * 0.5;
    if (offsetX < 0){
        offsetX = 0;
    }
    CGFloat maxOffsetX = leftScrollView.contentSize.height - leftScrollView.bounds.size.height;
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    self.index = indexPath;
    [_collectionViewList reloadData];
    [leftScrollView setSelectButtonWithIndexPathSection:indexPath];
    [leftScrollView setContentOffset:CGPointMake(0, offsetX) animated:YES];
    isScrollSetSelect = NO;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _collectionViewList.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    isScrollSetSelect = YES ;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}


@end
