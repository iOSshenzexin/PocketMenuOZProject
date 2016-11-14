//
//  ZXShoppingCarCell.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/20.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZXGoodsModel.h"
@interface ZXShoppingCarCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIButton *deleteButton;



@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;

@property (weak, nonatomic) IBOutlet UILabel *goodsNameLbl;

@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLbl;

@property (weak, nonatomic) IBOutlet UIButton *minus;

@property (weak, nonatomic) IBOutlet UITextField *amountTxt;

@property (weak, nonatomic) IBOutlet UIButton *plus;

@property (assign, nonatomic) NSUInteger amount;

@property (nonatomic,strong) ZXGoodsModel *model;


+(instancetype)cellWithTableView:(UITableView *)tableview;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leading;


@end
