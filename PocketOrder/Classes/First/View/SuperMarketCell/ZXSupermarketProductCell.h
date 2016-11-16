//
//  ZXSupermarketProductCell.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/7.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXSupermarketProductCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UIButton *addGoodsButton;

@property (nonatomic, copy) void (^didClickAddBtnHandle)();

@property (nonatomic,copy) void(^btnBlock)();


@end
