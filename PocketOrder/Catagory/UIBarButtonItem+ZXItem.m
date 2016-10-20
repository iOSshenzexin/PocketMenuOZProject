//
//  UIBarButtonItem+ZXItem.m
//  PocketOrder
//
//  Created by 杨晓婧 on 16/9/12.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "UIBarButtonItem+ZXItem.h"

@implementation UIBarButtonItem (ZXItem)

+ (UIBarButtonItem *)itemWithNomalTitle:(NSString *)normal SelectedTitle:(NSString *)selected target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:normal forState:UIControlStateNormal];
    [btn setTitle:selected forState:UIControlStateSelected];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}




+ (UIBarButtonItem *)itemWithimage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *containView = [[UIView alloc] initWithFrame:btn.bounds];
    [containView addSubview:btn];
    return [[UIBarButtonItem alloc] initWithCustomView:containView];
}

+ (UIBarButtonItem *)itemWithimage:(UIImage *)image title:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor blackColor];
    [btn setImage:image forState:UIControlStateNormal];
    //调换image跟label的位置
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -btn.currentImage.size.width, 0, btn.currentImage.size.width);
    CGFloat labelW = btn.titleLabel.bounds.size.width;
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, labelW, 0, -labelW);
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *containView = [[UIView alloc] initWithFrame:btn.bounds];
    [containView addSubview:btn];
    
    return [[UIBarButtonItem alloc] initWithCustomView:containView];
}


+ (UIBarButtonItem *)backItemWithimage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:title forState:UIControlStateNormal];
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton setImage:highImage forState:UIControlStateHighlighted];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [backButton sizeToFit];
   // backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return  [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

+(UIBarButtonItem *)itemWithFont:(CGFloat)fontsize btnWidth:(CGFloat)width btnHeight:(CGFloat)height image:(NSString *)image highlightImage:(NSString *)hightlightImage title:(NSString *)title target:( id)target action:(SEL)action leftEdgeInset:(CGFloat)left rightEdgeInset:(CGFloat)right
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (image != nil | hightlightImage != nil ) {
        [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:hightlightImage] forState:UIControlStateHighlighted];
    }
 
    btn.frame = CGRectMake(0, 0, width, height);
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, left, 0, right);
    btn.titleLabel.font = [UIFont systemFontOfSize:fontsize];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}



@end
