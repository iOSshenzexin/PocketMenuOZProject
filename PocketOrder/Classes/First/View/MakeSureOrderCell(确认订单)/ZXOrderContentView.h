//
//  ZXOrderContentView.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZXOrderFoodsModel.h"

@interface ZXOrderContentView : UIView

@property (nonatomic,strong) ZXOrderFoodsModel *orderContentModel;


@property (weak, nonatomic) IBOutlet UILabel *priceLbl;

@property (weak, nonatomic) IBOutlet UILabel *nameLbl;

@property (weak, nonatomic) IBOutlet UILabel *amountLbl;

@end
