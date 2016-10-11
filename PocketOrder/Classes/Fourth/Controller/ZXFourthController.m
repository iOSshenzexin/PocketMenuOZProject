//
//  ZXFourthController.m
//  PocketMenu
//
//  Created by 杨晓婧 on 16/7/4.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXFourthController.h"
#import "CoolNavi.h"
static CGFloat const kWindowHeight = 205.0f;
static NSUInteger const kCellNum = 15;
static NSUInteger const kRowHeight = 44;
static NSString * const kCellIdentify = @"cell";

@interface ZXFourthController ()<UITableViewDataSource, UITableViewDelegate>
{
   // GMSMapView *_mapView;
}

@property (nonatomic, strong) UITableView *tableView;



@end

@implementation ZXFourthController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];

    //[self createMapUI];
    [self createCoolNavigationBar];
}

- (void)createCoolNavigationBar{
    self.tableView.frame = CGRectMake(0, 0,ScreenW, ScreenH-49);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    CoolNavi *headerView = [[CoolNavi alloc] initWithFrame:CGRectMake(0, 0, ScreenW, kWindowHeight)backGroudImage:@"background" headerImageURL:@"http://d.hiphotos.baidu.com/image/pic/item/0ff41bd5ad6eddc4f263b0fc3adbb6fd52663334.jpg" title:@"妹子!" subTitle:@"个性签名, 啦啦啦!"];
    headerView.scrollView = self.tableView;
    headerView.imgActionBlock = ^(){
        NSLog(@"headerImageAction");
    };
    [self.view addSubview:headerView];
}


#pragma mark - getter and setter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentify];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark - tableView Delegate and dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kCellNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentify forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"test %ld",(long)indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRowHeight;
}

//- (void)createMapUI{
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:36.106652 longitude:120.467981 zoom:16];
//    _mapView = [GMSMapView mapWithFrame:self.view.frame camera:camera];
//    _mapView.myLocationEnabled = YES;
//    self.view = _mapView;
//    
//    //在地图上创建一个中心
//    GMSMarker *marker = [[GMSMarker alloc] init];
//    marker.position = CLLocationCoordinate2DMake(36.106652, 120.467981);
//    marker.title = @"悉尼";
//    marker.snippet = @"澳大利亚";
//    marker.map = _mapView;
//}

@end
