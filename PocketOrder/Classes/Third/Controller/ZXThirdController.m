//
//  ZXThirdController.m
//  PocketMenu
//
//  Created by 杨晓婧 on 16/7/4.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXThirdController.h"

#import <MJRefresh.h>
#import "shoppingCartModel.h"
#import "MKJRequestHelper.h"
#import "ZXCustomShoppingCarCell.h"
#import <UIImageView+WebCache.h>
#import <UITableView+FDTemplateLayoutCell.h>
//#import "ChooseGoodsPropertyViewController.h"
#import "UIViewController+KNSemiModal.h"
#import <JTSImageViewController.h>
#import <Masonry.h>

#import "ZXShopCarConfirmOrderController.h"

@interface ZXThirdController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,ZXCustomShoppingCarCellDelegate>

@property (nonatomic,strong) NSMutableArray *buyerLists;
@property (nonatomic,strong) UIButton *rightButton;
//@property (nonatomic,strong) ChooseGoodsPropertyViewController *chooseVC;
// 由于代理问题衍生出的来已经选择单个或者批量的数组装Cell
@property (nonatomic,strong) NSMutableArray *tempCellArray;



// 底部统计View的控件 （normal）
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *allSelectedButton;
@property (weak, nonatomic) IBOutlet UIView *normalBottomRightView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *normalBottomRightWidthConstraint;
@property (weak, nonatomic) IBOutlet UIButton *accountButton;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;

// 底部全局编辑按钮 (edit)
@property (weak, nonatomic) IBOutlet UIView *editBottomRightView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *editBottomRightWidthConstraint;
@property (weak, nonatomic) IBOutlet UIButton *editBaby;
@property (weak, nonatomic) IBOutlet UIButton *bottomDelete;
@property (weak, nonatomic) IBOutlet UIButton *storeButton;

@property (nonatomic,strong) UIView *textView;

@end

static NSString *shoppongID = @"ZXCustomShoppingCarCell";
static NSString *shoppingHeaderID = @"BuyerHeaderCell";
@implementation ZXThirdController

- (void)dealloc
{
    NSLog(@"%s____dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置底部按钮
    CGRect rec = self.bottomView.frame;
    rec.size.width = [UIScreen mainScreen].bounds.size.width;
    rec.size.height = 50;
    rec.origin.x = 0;
    rec.origin.y = [UIScreen mainScreen].bounds.size.height - 99;
    self.bottomView.frame = rec;
    self.normalBottomRightWidthConstraint.constant = [UIScreen mainScreen].bounds.size.width * 2 / 3;
    self.editBottomRightWidthConstraint.constant = [UIScreen mainScreen].bounds.size.width * 2 / 3;
    [self.view addSubview:self.bottomView];
    self.editBottomRightView.hidden = YES;
    
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNomalTitle:@"编辑" SelectedTitle:@"完成" target:self action:@selector(clickAllEdit:)];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    [self.tableView registerNib:[UINib nibWithNibName:shoppongID bundle:nil] forCellReuseIdentifier:shoppongID];
    [self.tableView registerNib:[UINib nibWithNibName:shoppingHeaderID bundle:nil] forCellReuseIdentifier:shoppingHeaderID];

    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    header.stateLabel.hidden = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 点击全部编辑按钮
- (void)clickAllEdit:(UIButton *)button
{
    button.selected = !button.selected;
    for (BuyerInfo *buyer in self.buyerLists)
    {
        buyer.buyerIsEditing = button.selected;
    }
    [self.tableView reloadData];
    self.editBottomRightView.hidden = !button.selected;
}

- (void)refreshData
{
    self.totalPriceLabel.text = @"合计: $0.00";
    self.allSelectedButton.selected = NO;
    self.rightButton.selected = NO;
    
    __weak typeof(self)weakSelf = self;
    // 请求购物车数据
    [[MKJRequestHelper shareRequestHelper] requestShoppingCartInfo:^(id obj, NSError *err) {
        // buyer Array
        [weakSelf.buyerLists removeAllObjects];
        weakSelf.buyerLists = (NSMutableArray *)obj;
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.mj_header endRefreshing];
        
        if (![[MKJRequestHelper shareRequestHelper] isEmptyArray:weakSelf.buyerLists]) {
            weakSelf.rightButton.enabled = YES;
        }
    }];

}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.buyerLists.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BuyerInfo *buyer = self.buyerLists[section];
    return buyer.prod_list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXCustomShoppingCarCell *cell = [tableView dequeueReusableCellWithIdentifier:shoppongID forIndexPath:indexPath];
    cell.delegate = self;
    [self configCell:cell indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}


// 组装cell
- (void)configCell:(ZXCustomShoppingCarCell *)cell indexPath:(NSIndexPath *)indexPath
{
    BuyerInfo *buyer = self.buyerLists[indexPath.section];
    ProductInfo *product = buyer.prod_list[indexPath.row];
    cell.leftChooseButton.selected = product.productIsChoosed; //!< 商品是否需要选择的字段
    __weak typeof(cell)weakCell = cell;
    [cell.productImageView sd_setImageWithURL:[NSURL URLWithString:product.image] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image && cacheType == SDImageCacheTypeNone)
        {
            weakCell.productImageView.alpha = 0;
            [UIView animateWithDuration:1.0 animations:^{
                weakCell.productImageView.alpha = 1.0f;
            }];
        }
        else
        {
            weakCell.productImageView.alpha = 1.0f;
        }
    }];
    cell.titleLabel.text = product.title;
    if ([[MKJRequestHelper shareRequestHelper] isEmptyArray:product.model_detail])
    {
        cell.sizeDetailLabel.text = @"";
        cell.editDetailView.hidden = YES;
    }
    else
    {
        cell.editDetailView.hidden = NO;
        cell.sizeDetailLabel.text = @"这里测试规格数据这里测试规格数据这里测试规格数据这里测试规格数据这里测试规格数据这里测试规格数据这里测试规格数据";
        cell.editDetailTitleLabel.text = @"点击我修改规格";
    }
    
    cell.priceLabel.attributedText = [[MKJRequestHelper shareRequestHelper] recombinePrice:product.cn_price orderPrice:product.order_price];
    
    cell.countLabel.text = [NSString stringWithFormat:@"x%ld",product.count];
    
    cell.editCountLabel.text = [NSString stringWithFormat:@"%ld",product.count];
    
    // 正常模式下面 非编辑
    if (!buyer.buyerIsEditing)
    {
        cell.normalBackView.hidden = NO;
        cell.editBackView.hidden = YES;
    }
    else
    {
        cell.normalBackView.hidden = YES;
        cell.editBackView.hidden = NO;
    }
}

// 高度计算
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuyerInfo *buyer = self.buyerLists[indexPath.section];
    if (buyer.buyerIsEditing)
    {
        return 100;
    }
    else{
        CGFloat actualHeight = [tableView fd_heightForCellWithIdentifier:shoppongID cacheByIndexPath:indexPath configuration:^(ZXCustomShoppingCarCell *cell) {
            [self configCell:cell indexPath:indexPath];
        }];
        return actualHeight >= 100 ? actualHeight : 100;
    }
}

// tableView的sectionHeader加载数据
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BuyerInfo *buyer = self.buyerLists[section];
    ZXCustomShoppingCarCell *cell = [tableView dequeueReusableCellWithIdentifier:shoppingHeaderID];
    cell.headerSelectedButton.selected = buyer.buyerIsChoosed; //!< 买手是否需要勾选的字段
    [cell.buyerImageView sd_setImageWithURL:[NSURL URLWithString:buyer.user_avatar]];
    cell.buyerNameLabel.text = buyer.nick_name;
    cell.sectionIndex = section;
    cell.editSectionHeaderButton.selected = buyer.buyerIsEditing;
    if (self.rightButton.selected)
    {
        cell.editSectionHeaderButton.hidden = YES;
    }
    else
    {
        cell.editSectionHeaderButton.hidden = NO;
    }
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



#pragma -
#pragma - 点击单个商品cell选择按钮
- (void)productSelected:(ZXCustomShoppingCarCell *)cell isSelected:(BOOL)choosed
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    BuyerInfo *buyer  = self.buyerLists[indexPath.section];
    ProductInfo *product = buyer.prod_list[indexPath.row];
    product.productIsChoosed = !product.productIsChoosed;
    // 当点击单个的时候，判断是否该买手下面的商品是否全部选中
    __block NSInteger count = 0;
    [buyer.prod_list enumerateObjectsUsingBlock:^(ProductInfo *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.productIsChoosed)
        {
            count ++;
        }
    }];
    if (count == buyer.prod_list.count)
    {
        buyer.buyerIsChoosed = YES;
    }
    else
    {
        buyer.buyerIsChoosed = NO;
    }
    [self.tableView reloadData];
    // 每次点击都要统计底部的按钮是否全选
    self.allSelectedButton.selected = [self isAllProcductChoosed];
    
    [self.accountButton setTitle:[NSString stringWithFormat:@"去结算(%ld)",[self countTotalSelectedNumber]] forState:UIControlStateNormal];
    
    self.totalPriceLabel.text = [NSString stringWithFormat:@"合计: $%.2f",[self countTotalPrice]];
    
}


#pragma mark - 点击buer选择按钮回调
- (void)buyerSelected:(NSInteger)sectionIndex
{
    BuyerInfo *buyer = self.buyerLists[sectionIndex];
    buyer.buyerIsChoosed = !buyer.buyerIsChoosed;
    [buyer.prod_list enumerateObjectsUsingBlock:^(ProductInfo *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.productIsChoosed = buyer.buyerIsChoosed;
    }];
    [self.tableView reloadData];
    // 每次点击都要统计底部的按钮是否全选
    self.allSelectedButton.selected = [self isAllProcductChoosed];
    
    [self.accountButton setTitle:[NSString stringWithFormat:@"去结算(%ld)",[self countTotalSelectedNumber]] forState:UIControlStateNormal];
    
    self.totalPriceLabel.text = [NSString stringWithFormat:@"合计: $%.2f",[self countTotalPrice]];
}

#pragma mark - 点击buyer编辑按钮回调
- (void)buyerEditingSelected:(NSInteger)sectionIdx
{
    BuyerInfo *buy = self.buyerLists[sectionIdx];
    buy.buyerIsEditing = !buy.buyerIsEditing;
    [self.tableView reloadData];
}

#pragma mark - 点击编辑详情回调
- (void)clickEditingDetailInfo:(ZXCustomShoppingCarCell *)cell
{
    // 编辑对应的商品信息，这里写的太多了，我就写死了，逻辑太多了，这尼玛根本不叫Demo了，这简直就是我的成品
//    self.chooseVC = nil;
//    self.chooseVC = [[ChooseGoodsPropertyViewController alloc] init];
//    self.chooseVC.enterType = SecondEnterType;
//    self.chooseVC.price = 999.99f;
//    [self.navigationController presentSemiViewController:self.chooseVC withOptions:@{
//                                                                                     KNSemiModalOptionKeys.pushParentBack    : @(YES),
//                                                                                     KNSemiModalOptionKeys.animationDuration : @(0.6),
//                                                                                     KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
//                                                                                     KNSemiModalOptionKeys.backgroundView : [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_01"]]
//                                                                                     }];
}


#pragma mark - 点击图片展示Show
- (void)clickProductIMG:(ZXCustomShoppingCarCell *)cell
{
    NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
    BuyerInfo *buyer = self.buyerLists[indexpath.section];
    ProductInfo *product = buyer.prod_list[indexpath.row];
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    NSString *imageURLStr = product.image;
    imageInfo.imageURL  = [NSURL URLWithString:imageURLStr];
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOffscreen];
}

#pragma mark -增加或者减少商品
- (void)plusOrMinusCount:(ZXCustomShoppingCarCell *)cell tag:(NSInteger)tag
{
    NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
    BuyerInfo *buyer = self.buyerLists[indexpath.section];
    ProductInfo *product = buyer.prod_list[indexpath.row];
    
    if (tag == 555)
    {
        if (product.count <= 1) {
            
        }
        else
        {
            product.count --;
        }
    }
    else if (tag == 666)
    {
        product.count ++;
    }
    self.totalPriceLabel.text = [NSString stringWithFormat:@"合计: $%.2f",[self countTotalPrice]];
    [self.tableView reloadData];
}

#pragma mark - 点击单个商品删除回调
- (void)productGarbageClick:(ZXCustomShoppingCarCell *)cell
{
    [self.tempCellArray removeAllObjects];
    [self.tempCellArray addObject:cell];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认删除？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 101;
    alert.delegate = self;
    [alert show];
}

// alert的代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // 单个删除
    if (alertView.tag == 101) {
        if (buttonIndex == 1)
        {
            NSIndexPath *indexpath = [self.tableView indexPathForCell:self.tempCellArray.firstObject];
            BuyerInfo *buyer = self.buyerLists[indexpath.section];
            ProductInfo *product = buyer.prod_list[indexpath.row];
            if (buyer.prod_list.count == 1) {
                [self.buyerLists removeObject:buyer];
            }
            else
            {
                [buyer.prod_list removeObject:product];
            }
            // 这里删除之后操作涉及到太多东西了，需要
            [self updateInfomation];
        }
    }
    else if (alertView.tag == 102) // 多个或者单个
    {
        if (buttonIndex == 1)
        {
            NSMutableArray *buyerTempArr = [[NSMutableArray alloc] init];
            for (BuyerInfo *buyer in self.buyerLists)
            {
                if (buyer.buyerIsChoosed)
                {
                    [buyerTempArr addObject:buyer];
                }
                else
                {
                    NSMutableArray *productTempArr = [[NSMutableArray alloc] init];
                    for (ProductInfo *product in buyer.prod_list)
                    {
                        if (product.productIsChoosed)
                        {
                            [productTempArr addObject:product];
                        }
                    }
                    if (![[MKJRequestHelper shareRequestHelper] isEmptyArray:productTempArr])
                    {
                        [buyer.prod_list removeObjectsInArray:productTempArr];
                    }
                }
            }
            [self.buyerLists removeObjectsInArray:buyerTempArr];
            [self updateInfomation];
        }
    }
    
}

#pragma mark - 删除之后一些列更新操作
- (void)updateInfomation
{
    // 会影响到对应的买手选择
    for (BuyerInfo *buyer in self.buyerLists) {
        NSInteger count = 0;
        for (ProductInfo *product in buyer.prod_list) {
            if (product.productIsChoosed) {
                count ++;
            }
        }
        if (count == buyer.prod_list.count) {
            buyer.buyerIsChoosed = YES;
        }
    }
    // 再次影响到全部选择按钮
    self.allSelectedButton.selected = [self isAllProcductChoosed];
    
    self.totalPriceLabel.text = [NSString stringWithFormat:@"合计: $%.2f",[self countTotalPrice]];
    
    [self.accountButton setTitle:[NSString stringWithFormat:@"去结算(%ld)",[self countTotalSelectedNumber]] forState:UIControlStateNormal];
    
    [self.tableView reloadData];
    
    // 如果删除干净了
    if ([[MKJRequestHelper shareRequestHelper] isEmptyArray:self.buyerLists]) {
        [self clickAllEdit:self.rightButton];
        self.rightButton.enabled = NO;
    }
}


#pragma mark - 判断是否全部选中了
- (BOOL)isAllProcductChoosed
{
    if ([[MKJRequestHelper shareRequestHelper] isEmptyArray:self.buyerLists]) {
        return NO;
    }
    NSInteger count = 0;
    for (BuyerInfo *buyer in self.buyerLists) {
        if (buyer.buyerIsChoosed) {
            count ++;
        }
    }
    return (count == self.buyerLists.count);
}

#pragma mark - 点击底部全选按钮
- (IBAction)clickAllProductSelected:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    for (BuyerInfo *buyer in self.buyerLists) {
        buyer.buyerIsChoosed = sender.selected;
        for (ProductInfo *product in buyer.prod_list) {
            product.productIsChoosed = buyer.buyerIsChoosed;
        }
    }
    [self.tableView reloadData];
    
    CGFloat totalPrice = [self countTotalPrice];
    self.totalPriceLabel.text = [NSString stringWithFormat:@"合计: $%.2f",totalPrice];
    [self.accountButton setTitle:[NSString stringWithFormat:@"去结算(%ld)",[self countTotalSelectedNumber]] forState:UIControlStateNormal];
}


#pragma -
#pragma mark - 计算选出商品的总价
- (CGFloat)countTotalPrice
{
    CGFloat totalPrice = 0.0;
    for (BuyerInfo *buyer in self.buyerLists) {
        if (buyer.buyerIsChoosed) {
            for (ProductInfo *product in buyer.prod_list) {
                totalPrice += product.order_price * product.count;
            }
        }else{
            for (ProductInfo *product in buyer.prod_list) {
                if (product.productIsChoosed) {
                    totalPrice += product.order_price * product.count;
                }
            }
            
        }
    }
    return totalPrice;
}

#pragma mark - 计算商品被选择了数量
- (NSInteger)countTotalSelectedNumber
{
    NSInteger count = 0;
    for (BuyerInfo *buyer in self.buyerLists) {
        for (ProductInfo *product in buyer.prod_list) {
            if (product.productIsChoosed) {
                count ++;
            }
        }
    }
    return count;
}

// 分享
- (IBAction)share:(id)sender {
    NSLog(@"分享宝贝");
}

// 移动到收藏夹
- (IBAction)store:(id)sender {
    NSLog(@"移动到收藏夹");
}

// 底部多选删除也可单选删除
- (IBAction)deleteMultipleOrSingfle:(id)sender {
    // 这个大的是用来过滤buyer的 没有就是nil，从商品数组中删除
    [self.tempCellArray removeAllObjects];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认删除？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 102;
    alert.delegate = self;
    [alert show];
}

#pragma mark - 点击去结算按钮去支付订单
- (IBAction)didClickGoToPayMentOrder:(id)sender {
    ZXShopCarConfirmOrderController *vc = [[ZXShopCarConfirmOrderController alloc] init];
    vc.title = @"确认订单";
    [self.navigationController pushViewController:vc animated:YES];
}


- (NSMutableArray *)buyerLists
{
    if (_buyerLists == nil) {
        _buyerLists = [[NSMutableArray alloc] init];
    }
    return _buyerLists;
}

- (NSMutableArray *)tempCellArray
{
    if (_tempCellArray == nil) {
        _tempCellArray = [[NSMutableArray alloc] init];
    }
    return _tempCellArray;
}



@end
