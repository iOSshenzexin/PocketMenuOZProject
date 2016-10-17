//
//  ZXTabBarController.m
//  PocketMenu
//
//  Created by 杨晓婧 on 16/7/4.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXTabBarController.h"
#import "ZXFirstController.h"
#import "ZXSecondController.h"
#import "ZXThirdController.h"
#import "ZXFourthController.h"
#import "ZXNavgaitonController.h"
@interface ZXTabBarController ()

@end

@implementation ZXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpAllChildViewController];
}

- (void)setUpAllChildViewController{
    // 1.添加首页
    ZXFirstController *oneVC = [[ZXFirstController alloc]init];
    [self setUpOneChildViewController:oneVC image:[UIImage imageNamed:@"nav01-normal"] selectImage:[UIImage imageNamed:@"nav01-click"] title:nil];
    // 2. 收藏
    ZXSecondController *twoVC = [[ZXSecondController alloc]init];
    [self setUpOneChildViewController:twoVC image:[UIImage imageNamed:@"nav02-normal"] selectImage:[UIImage imageNamed:@"nav02-click"] title:@"我的收藏"];
    // 3.添加购物车
    ZXThirdController *threeVC = [[ZXThirdController alloc]init];
    [self setUpOneChildViewController:threeVC image:[UIImage imageNamed:@"nav03-normal"] selectImage:[UIImage imageNamed:@"nav03-click"] title:@"购物车"];
    // 4.添加个人中心
   
    ZXFourthController *fourVC = [[UIStoryboard storyboardWithName:@"ZXFourthController" bundle:nil]instantiateViewControllerWithIdentifier:@"FourthController"];
    [self setUpOneChildViewController:fourVC image:[UIImage imageNamed:@"nav04-normal"] selectImage:[UIImage imageNamed:@"nav04-click"]  title:nil];
}

- (void)setUpOneChildViewController:(UIViewController *)viewController image:(UIImage *)image selectImage:(UIImage *)selectImage title:(NSString *)title {
    ZXNavgaitonController *navC = [[ZXNavgaitonController alloc]initWithRootViewController:viewController];
    navC.tabBarItem.title = title;
    viewController.title = title;
    navC.tabBarItem.title = [NSString stringWithFormat:@""];
    navC.tabBarItem.image = image;
    navC.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navC.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    [self addChildViewController:navC];
}
@end
