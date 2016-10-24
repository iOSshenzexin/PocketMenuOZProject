//
//  ZXShawdowView.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/24.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXShawdowView.h"

#define DurationTime 0.35

@interface ZXShawdowView()

@property (nonatomic,strong) UIView *shawdow;

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,assign) CGFloat subView_height;

@end


@implementation ZXShawdowView

- (instancetype)initWithSubViewOfFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
            self.frame = frame;
            UIView *shawdowView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenW, ScreenH)];
            self.shawdow = shawdowView;
        
            UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0)];
            scrollView.backgroundColor = [UIColor whiteColor];
            self.scrollView = scrollView;
            [shawdowView  addSubview:scrollView];
            
            self.subView_height = frame.size.height;
            [scrollView addSubview:self];
            [UIView animateWithDuration:DurationTime animations:^{
                shawdowView.backgroundColor = [UIColor colorWithRed:0.145 green:0.145 blue:0.145 alpha:0.65];
            }completion:nil
             ];
            [UIView animateWithDuration:DurationTime animations:^{
                scrollView.frame = CGRectMake(0, 0, self.frame.size.width,self.frame.size.height);
            }completion:nil
             ];
            UIApplication *app = [UIApplication sharedApplication];
            [app.keyWindow insertSubview:shawdowView atIndex:3];
    }
      return self;
}

- (void)szx_removeSubViews{
    [UIView animateWithDuration:DurationTime animations:^{
        self.scrollView.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, 0);
    }completion:^(BOOL finished) {
        self.shawdow.backgroundColor = [UIColor colorWithRed:0.145 green:0.145 blue:0.145 alpha:0];
        [self.shawdow removeFromSuperview];
    }];
}



@end
