//
//  LeftSelectScroll.h
//  YiLeHelp
//
//  Created by ChenYi on 15/11/14.
//  Copyright © 2015年 JC. All rights reserved.
//
//尺寸定义
#define kScreenWidth [UIScreen mainScreen].bounds.size.width//屏幕的宽度
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height//屏幕的高度
#define kNav_H kScreenHeight > 668 ? 86 : 64//屏幕的高度
#define tabbarH  49//屏幕的高度


#import <UIKit/UIKit.h>
/*
@protocol LeftSelectScrollDataSource <NSObject>

- (NSInteger)numberOfRowsInSection;

- (UIButton*)viewForRowAtIndexPath:(NSInteger *)indexPath;

@end
*/
@protocol LeftSelectScrollDelegate <NSObject>

-(void)clickLeftSelectScrollButton:(NSInteger)indexPath;

@end

@interface LeftSelectScroll : UIScrollView

@property(nonatomic,strong)NSArray *leftSelectArray;

@property (nonatomic,strong)id<LeftSelectScrollDelegate>leftSelectDelegate;

-(void)setLeftSelectArray:(NSArray *)leftSelectArray;


-(void)setSelectButtonWithIndexPathSection:(NSInteger)indexPathSection;
@end
