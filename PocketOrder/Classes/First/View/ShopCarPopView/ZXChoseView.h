//
//  ZXChoseView.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/9.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZXTypeView.h"
#import "ZXBuyCountView.h"
@interface ZXChoseView : UIView<UITextFieldDelegate,UIAlertViewDelegate>
@property(nonatomic, retain)UIView *alphaiView;
@property(nonatomic, retain)UIView *whiteView;

@property(nonatomic, retain)UIImageView *img;

@property(nonatomic, retain)UILabel *lb_price;
@property(nonatomic, retain)UILabel *lb_stock;
@property(nonatomic, retain)UILabel *lb_detail;
@property(nonatomic, retain)UILabel *lb_line;

@property(nonatomic, retain)UIScrollView *mainscrollview;

@property(nonatomic, retain) ZXTypeView *sizeView;
@property(nonatomic, retain) ZXTypeView *colorView;
@property(nonatomic, retain) ZXBuyCountView *countView;

@property(nonatomic, retain)UIButton *bt_sure;

@property(nonatomic, retain)UIButton *bt_cancle;

@property(nonatomic, retain)UIButton *bt_shopCar;

@property(nonatomic) int stock;


@end
