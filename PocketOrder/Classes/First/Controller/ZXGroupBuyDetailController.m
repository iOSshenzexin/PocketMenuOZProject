//
//  ZXGroupBuyDetailController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/2.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXGroupBuyDetailController.h"
#import "TopBannerTool.h"
#import "ZXGroupBuyDetailOneCell.h"
#import "ZXGroupBuyDetailTwoCell.h"
#import "ZXGroupBuyDetailThreeCell.h"
@interface ZXGroupBuyDetailController ()<KNBannerViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation ZXGroupBuyDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBarBtn];
    KNBannerView *banner = [TopBannerTool setupNetWorkBannerViewAtViewController:self];
    banner.pageControlStyle = KNPageControlStyleMiddle;
    self.tableView.tableHeaderView = banner;
}


#pragma mark  点击首页轮播图进入展示页
- (void)bannerView:(KNBannerView *)bannerView collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSInteger)index{
    NSLog(@"%zd---%zd",bannerView.tag,index);
}

- (void)setupNavigationBarBtn{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithFont:0 btnWidth:20 btnHeight:21 image:@"call_shop" highlightImage:@"call_shop_cilck" title:nil target:self action:@selector(didClickDialNumber:) leftEdgeInset:0 rightEdgeInset:-8];
}

- (void)didClickDialNumber:(UIButton *)btn
{
    UIWebView *callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:@"tel://400-666-8888"];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebview]; 
}


#pragma mark - UITableViewDataSource UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer = [[UIView alloc] init];
    footer.backgroundColor = [UIColor clearColor];
    return footer;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ZXGroupBuyDetailOneCell *cell = [ZXGroupBuyDetailOneCell cellWithTableView:tableView];
        return cell;
    }else if (indexPath.section == 1){
          ZXGroupBuyDetailTwoCell *cell = [ZXGroupBuyDetailTwoCell cellWithTableView:tableView];
          return cell;
    }
    ZXGroupBuyDetailThreeCell *cell = [ZXGroupBuyDetailThreeCell cellWithTableView:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 70;
    }else if(indexPath.section == 1)
    {
        return 150;
    }else if(indexPath.section == 2){
        return 400;
    }
    return 400;
}

@end
