//
//  LSSelectMenuView.m
//  MyDemo
//
//  Created by  tsou117 on 15/5/8.
//  Copyright (c) 2015年  tsou117. All rights reserved.
//

#import "LSSelectMenuView.h"


@implementation LSSelectMenuView{
    
    BOOL isShow;//YES已展开，NO已收起
    NSInteger selectIndex;//当前选择index
    
    NSInteger itemCount;//按钮个数
    
    CGRect maxShowRect;
    CGRect minShowRect;
}
@synthesize delegate = _delegate;
@synthesize dataSource = _dataSource;
@synthesize showView = _showView;


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //
        self.frame = frame;
        UIView* line1 = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-0.5, frame.size.width, 0.5)];
        line1.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line1];

    }

    return self;
}
#pragma mark - SET
- (void)setDataSource:(id<LSSelectMenuViewDataSource>)dataSource{
    _dataSource = dataSource;
    itemCount = [_dataSource numberOfItemsInMenuView:self];
    
    float lineY = 8;
    float ww = (self.frame.size.width - itemCount * 1)/itemCount;
    float hh = self.frame.size.height;
    for (int i = 0; i<itemCount; i++) {
        //
        LSButton* btn = [[LSButton alloc] initWithFrame:CGRectMake((ww + 1)*i, 0, ww, hh)];
        //添加中间分隔线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(ww * i, lineY, 1, hh- 2 * lineY)];
        lineView.backgroundColor = RGB(190, 190, 190);
        [self addSubview:lineView];
        btn.tag = 100+i;
        [btn setTitle:[_dataSource menuView:self titleForItemAtIndex:i]];
        //设置字体大小有一个 宏
        [btn setMarkImg:[UIImage imageNamed:@"list"]];
        [btn setMarkAlignment:2];
        [self addSubview:btn];
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionOfTap:)];
        [btn addGestureRecognizer:tap];
    }
}

- (void)setShowView:(UIView *)showView{
    _showView = showView;
    _showView.clipsToBounds = YES;
    
    maxShowRect = showView.frame;
    
    CGRect rect = _showView.frame;
    rect.size.height = 0;
    _showView.frame = rect;
    
    minShowRect = _showView.frame;
    
    _showView.backgroundColor = [UIColor colorWithRed:0.145 green:0.145 blue:0.145 alpha:0];

    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClose)];
    [_showView addGestureRecognizer:tap];
}
- (void)tapClose{
    [self closeCurrViewOnIndex:selectIndex isCloseShowView:YES];

}

#pragma mark - item选择
- (void)actionOfTap:(UITapGestureRecognizer*)sender{
    
    self.userInteractionEnabled = NO;
    
    LSButton* btn = (LSButton*)sender.view;
    if (isShow){
        //
        if (selectIndex == sender.view.tag-100)
        {
            //移除当前
            [self closeCurrViewOnIndex:selectIndex isCloseShowView:YES];
        }
        else
        {
            //先关闭当前
            [self closeCurrViewOnIndex:selectIndex isCloseShowView:NO];
            
            //展开新的
            [self showTListViewWIthSelectItemView:btn];
        }
    }
    else
    {
        //展开新的
        [self showTListViewWIthSelectItemView:btn];
    }
}

#pragma mark - 展开
- (void)showTListViewWIthSelectItemView:(LSButton*)sender{
    
    selectIndex = sender.tag-100;
    
    //按钮样式变化
    [sender settitleColor:[UIColor colorWithRed:1.000 green:0.502 blue:0.000 alpha:1]];
    [sender setMarkImg:[UIImage imageNamed:@"list-on"]];
    
    //背景变化
    [self openShowView];
    
    //动画过度
    [UIView animateWithDuration:DurationTime animations:^{
        sender.markImgView.transform = CGAffineTransformRotate(sender.markImgView.transform, -M_PI);
    } completion:^(BOOL ok){
        if (ok) {

            self.userInteractionEnabled = YES;
        }
    }];
    
    isShow = YES;
    [_delegate selectMenuView:self didSelectAtIndex:selectIndex];
    
}

- (void)openShowView{
    
    BOOL mark = [_showView.accessibilityIdentifier boolValue];
    if (!mark) {
        //是展开的
        _showView.frame = maxShowRect;
        _showView.accessibilityIdentifier = @"YES";
        [UIView animateWithDuration:DurationTime animations:^{
            //
            _showView.backgroundColor = [UIColor colorWithRed:0.145 green:0.145 blue:0.145 alpha:0.65];
        }];
    }
    
    //展开当前视图
    UIView* nowView = [_dataSource menuView:self currViewAtIndex:selectIndex];
    nowView.frame = CGRectMake(0, 0, _showView.frame.size.width, 0);
    nowView.tag = 1000+selectIndex;
    [_showView addSubview:nowView];
    
    [UIView animateWithDuration:DurationTime animations:^{
        //
        nowView.frame = CGRectMake(0, 0, nowView.frame.size.width, [_dataSource menuView:self heightForCurrViewAtIndex:selectIndex]);
    }completion:^(BOOL finished) {
        //
    }];
}

#pragma mark - 收起

- (void)closeCurrViewOnIndex:(NSInteger)index isCloseShowView:(BOOL)isshow{
    
    //关闭当前视图
    LSButton* btn = (LSButton*)[self viewWithTag:100+index];
    [self removeTListViewWithSelectItemView:btn];
    
    UIView* vv = (UIView*)[_showView viewWithTag:1000+selectIndex];
    [UIView animateWithDuration:DurationTime animations:^{
        //
        vv.frame = CGRectMake(0, 0, vv.frame.size.width, 0);
    }completion:^(BOOL finished) {
        //
        [vv removeFromSuperview];
    }];
    
    if (isshow) {
        //关闭背景
        [UIView animateWithDuration:DurationTime animations:^{
            //
            _showView.backgroundColor = [UIColor colorWithRed:0.145 green:0.145 blue:0.145 alpha:0];
            
        }completion:^(BOOL finished) {
            //
            _showView.frame = minShowRect;
            _showView.accessibilityIdentifier = @"NO";
        }];
    }
}

- (void)removeTListViewWithSelectItemView:(LSButton*)sender{
    
    //按钮样式变化
    [sender settitleColor:[UIColor darkGrayColor]];
    [sender setMarkImg:[UIImage imageNamed:@"list"]];
    
    
    //动画过度
    [UIView animateWithDuration:DurationTime animations:^{
        sender.markImgView.transform = CGAffineTransformRotate(sender.markImgView.transform, M_PI);
    } completion:^(BOOL ok){
        if (ok) {
            self.userInteractionEnabled = YES;

        }
    
    }];
    isShow = NO;
    [_delegate selectMenuView:self didRemoveAtIndex:selectIndex];
}


#pragma mark - //在当前视图的操作中如需关闭视图，执行此方法
- (void)closeCurrViewWithIndex:(NSInteger)index{
    
    
    
    LSButton* btn = (LSButton*)[self viewWithTag:100+index];
    UIView* vv = (UIView*)[_showView viewWithTag:1000+index];
    
    //关闭当前视图
    //按钮样式变化
    [btn settitleColor:[UIColor darkGrayColor]];
    [btn setMarkImg:[UIImage imageNamed:@"list-on"]];
    
    
    //动画过度
    [UIView animateWithDuration:DurationTime animations:^{
        btn.markImgView.transform = CGAffineTransformRotate(btn.markImgView.transform, M_PI);
    } completion:^(BOOL ok){
        if (ok) {
            self.userInteractionEnabled = YES;
            
        }
        
    }];
    isShow = NO;
    
    [UIView animateWithDuration:DurationTime animations:^{
        //
        _showView.backgroundColor = [UIColor colorWithRed:0.145 green:0.145 blue:0.145 alpha:0];
        vv.frame = CGRectMake(0, 0, vv.frame.size.width, 0);
    }completion:^(BOOL finished) {
        //
        _showView.frame = minShowRect;
        _showView.accessibilityIdentifier = @"NO";
        [vv removeFromSuperview];
    }];
}

@end
