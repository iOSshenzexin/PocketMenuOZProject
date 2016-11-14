//
//  ZXShoppingCarHeaderView.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/20.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZXHeaderMerchantModel.h"
@class ZXShoppingCarHeaderView;

@protocol ZXShoppingCarHeaderViewDelegate <NSObject>

- (void)didClickShoppingCarHeaderViewSelectAllOfCellInSection:(ZXShoppingCarHeaderView *)headerView mark:(NSString *)mark;

- (void)didClickShoppingCarHeaderViewSelectStore:(ZXShoppingCarHeaderView *)headerView ;
- (void)didClickShoppingCarHeaderViewEditButton:(ZXShoppingCarHeaderView *)header;

@end


@interface ZXShoppingCarHeaderView : UITableViewHeaderFooterView

+(instancetype)headerViewWithTableView:(UITableView *)tableView;


@property (nonatomic,weak) id<ZXShoppingCarHeaderViewDelegate> headerDelegate;
@property (nonatomic,strong) ZXHeaderMerchantModel *model;

@property (weak, nonatomic) IBOutlet UIButton *headerSelectBtn;

@property (weak, nonatomic) IBOutlet UIButton *marketNameBtn;

@property (strong, nonatomic) IBOutlet UIButton *editBtn;


@end
