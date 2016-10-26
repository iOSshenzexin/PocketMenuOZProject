//
//  ZXOrderCenterController.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/26.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXOrderCenterController.h"
#import "ZXTitleButton.h"
#import "UIView+Extension.h"
#define  SZXNavMaxY  64
#define  SZXTitlesViewH 44
#define  SZXMarin  10
@interface ZXOrderCenterController ()<UIScrollViewDelegate>
/** 用来存放所有子控制器view的scrollView */
@property (nonatomic, weak) UIScrollView *scrollView;

/** 标题栏 */
@property (nonatomic, weak) UIView *titlesView;


/** 标题下划线 */
@property (nonatomic, weak) UIView *titleUnderline;
/** 上一次点击的标题按钮 */
@property (nonatomic, weak) ZXTitleButton *previousClickedTitleButton;


@end

@implementation ZXOrderCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupScrollView];
    [self setupTitlesView];
}

- (void)setupScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = RGB(239, 239, 239);
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.scrollsToTop = NO; // 点击状态栏的时候，这个scrollView不会滚动到最顶部
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 添加子控制器的view
    NSUInteger count = self.childViewControllers.count;
    CGFloat scrollViewW = scrollView.frame.origin.x;
    scrollView.contentSize = CGSizeMake(count * scrollViewW, 0);
}

- (void)setupTitlesView
{
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
    titlesView.frame = CGRectMake(0, SZXNavMaxY, ScreenW, SZXTitlesViewH);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 标题栏按钮
    [self setupTitleButtons];
    
    // 标题下划线
    [self setupTitleUnderline];
}

/**
 *  标题栏按钮
 */
- (void)setupTitleButtons
{
    // 文字
    NSArray *titles = @[@"全部", @"已支付", @"待评价", @"已评价"];
    NSUInteger count = titles.count;
    
    // 标题按钮的尺寸
    CGFloat titleButtonW = self.titlesView.frame.size.width / count;
    CGFloat titleButtonH = self.titlesView.frame.size.height;
    
    // 创建5个标题按钮
    for (NSUInteger i = 0; i < count; i++) {
        ZXTitleButton *titleButton = [[ZXTitleButton alloc] init];
        titleButton.tag = i;
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesView addSubview:titleButton];
        // frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        // 文字
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
    }
}

/**
 *  标题下划线
 */
- (void)setupTitleUnderline
{
    // 标题按钮
    ZXTitleButton *firstTitleButton = self.titlesView.subviews.firstObject;
    
    // 下划线
    UIView *titleUnderline = [[UIView alloc] init];
    titleUnderline.height = 2;
    titleUnderline.y = self.titlesView.height - titleUnderline.height;
    titleUnderline.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    [self.titlesView addSubview:titleUnderline];
    self.titleUnderline = titleUnderline;
    
    // 切换按钮状态
    firstTitleButton.selected = YES;
    self.previousClickedTitleButton = firstTitleButton;
    
   //[firstTitleButton.titleLabel sizeToFit]; // 让label根据文字内容计算尺寸
   // self.titleUnderline.width = firstTitleButton.titleLabel.width + SZXMarin;
    self.titleUnderline.width = ScreenW / (self.titlesView.subviews.count);
    self.titleUnderline.x = firstTitleButton.x + SZXMarin;
}

/**
 *  点击标题按钮
 */
- (IBAction)titleButtonClick:(ZXTitleButton *)titleButton
{
    // 重复点击了标题按钮
    if (self.previousClickedTitleButton == titleButton) {
        [[NSNotificationCenter defaultCenter] postNotificationName:SZXTitleButtonDidRepeatClickNotification object:nil];
    }
    
    // 处理标题按钮点击
    [self dealTitleButtonClick:titleButton];
}

/**
 *  处理标题按钮点击
 */
- (void)dealTitleButtonClick:(ZXTitleButton *)titleButton
{
    // 切换按钮状态
    self.previousClickedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.previousClickedTitleButton = titleButton;
    
    NSUInteger index = titleButton.tag;
    [UIView animateWithDuration:0.25 animations:^{
        // 处理下划线
//        self.titleUnderline.width = titleButton.titleLabel.width + SZXMarin;
        self.titleUnderline.width = ScreenW / self.titlesView.subviews.count;
        self.titleUnderline.centerX = titleButton.centerX;
        
        // 滚动scrollView
        CGFloat offsetX = self.scrollView.width * index;
        self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        // 添加子控制器的view
      //  [self addChildVcViewIntoScrollView:index];
    }];
    
    // 设置index位置对应的tableView.scrollsToTop = YES， 其他都设置为NO
    for (NSUInteger i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *childVc = self.childViewControllers[i];
        // 如果view还没有被创建，就不用去处理
        if (!childVc.isViewLoaded) continue;
        
        UIScrollView *scrollView = (UIScrollView *)childVc.view;
        if (![scrollView isKindOfClass:[UIScrollView class]]) continue;
        
        scrollView.scrollsToTop = (i == index);
    }
}




@end
