//
//  LeftSelectScroll.m
//  YiLeHelp
//
//  Created by ChenYi on 15/11/14.
//  Copyright © 2015年 JC. All rights reserved.
//

#import "LeftSelectScroll.h"

int const btnH = 40.0;

@implementation LeftSelectScroll{
    UIButton *tempSelectButton;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        tempSelectButton = [[UIButton alloc]init];
        self.backgroundColor = RGB(240, 245, 249);
    }
    return self;
}

-(void)setLeftSelectArray:(NSArray *)leftSelectArray{
    _leftSelectArray = leftSelectArray;
    for (int i = 0; i<_leftSelectArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, btnH * i, kScreenWidth * 0.25, btnH);
        [button setTitle:_leftSelectArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"shop_choose"] forState:UIControlStateSelected];
      
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.backgroundColor = [UIColor clearColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, button.frame.size.height - 0.5, button.frame.size.width, 0.5)];
        label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dash_line"]];
        [button addSubview:label];
        [self addSubview:button];
        
        [button addTarget:self action:@selector(clickLeftSelectButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+11;
        if (i == 0) {
            [button setSelected:YES];
            tempSelectButton = button;
        }
    }
}

-(void)clickLeftSelectButton:(UIButton*)button{
    [tempSelectButton setSelected:NO];
    [button setSelected:YES];
    
    tempSelectButton = button;
    
    NSInteger tag = button.tag - 11;
    if (self.leftSelectDelegate && [self.leftSelectDelegate respondsToSelector:@selector(clickLeftSelectScrollButton:)]) {
        [self.leftSelectDelegate clickLeftSelectScrollButton:tag];
    }
}

-(void)setSelectButtonWithIndexPathSection:(NSInteger)indexPathSection{
    for (int i = 0; i< _leftSelectArray.count; i++) {
        NSInteger tag = i + 11 ;
        UIButton *btn = (UIButton*)[self viewWithTag:tag];
        if (btn.tag == indexPathSection + 11) {
            tempSelectButton = btn;
            [btn setSelected:YES];
        }else{
            [btn setSelected:NO];
        }
    }
    
}


@end
