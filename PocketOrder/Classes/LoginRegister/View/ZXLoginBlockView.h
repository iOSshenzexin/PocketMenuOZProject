//
//  ZXLoginBlockView.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/8.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXLoginBlockView;

@protocol ZXLoginBlockViewDelegate <NSObject>

@optional


- (void)didClickNomalLoginButton:(ZXLoginBlockView *)blockView type:(UIButton *)btn;

- (void)didClickForgerPwd:(ZXLoginBlockView *)blockView;


@end



@interface ZXLoginBlockView : UIView

@property (nonatomic,weak) id<ZXLoginBlockViewDelegate> delegate;

+ (instancetype)commonLoginView;

+ (instancetype)fastLoginView;



@end
