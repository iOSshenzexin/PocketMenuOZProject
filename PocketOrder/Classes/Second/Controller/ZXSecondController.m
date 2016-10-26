//
//  ZXSecondController.m
//  PocketMenu
//
//  Created by 杨晓婧 on 16/7/4.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXSecondController.h"

#import "ZXSearchController.h"
@interface ZXSecondController (){
    GMSMapView *_mapView;
}

@end

@implementation ZXSecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithFont:0 btnWidth:20 btnHeight:21 image:@"Search" highlightImage:@"Search-cilck" title:nil target:self action:@selector(didClickSearch:) leftEdgeInset:0 rightEdgeInset:-8];
    
    [self addGoogleMap];
}

- (void)addGoogleMap
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:22.290664
                                                            longitude:114.195304
                                                                 zoom:14];
    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.view = _mapView;
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(22.290664, 114.195304);
    marker.title = @"香港";
    marker.snippet = @"Hong Kong";
    marker.map = _mapView;
}


- (void)didClickSearch:(UIButton *)btn{
    ZXSearchController *vc = [[ZXSearchController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}




- (void)viewWillAppear:(BOOL)animated{

}


@end
