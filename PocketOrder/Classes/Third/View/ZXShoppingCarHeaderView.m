//
//  ZXShoppingCarHeaderView.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/20.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXShoppingCarHeaderView.h"

@implementation ZXShoppingCarHeaderView

static NSString *headerId = @"headerID";


+(instancetype)headerViewWithTableView:(UITableView *)tableView{
    ZXShoppingCarHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerId];
    if (headerView == nil) {
        headerView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    }
    //设置headerView背景颜色 - important
    headerView.backgroundView = ({
        UIView * view = [[UIView alloc] initWithFrame:headerView.bounds];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    return headerView;
}

-(void)setModel:(ZXHeaderMerchantModel *)model
{
    _model = model;
    self.headerSelectBtn.selected = model.isSelect;
    [self.marketNameBtn setTitle:model.homeID forState:UIControlStateNormal];
}



/**
 点击选择section中的商品
 */
- (IBAction)select:(UIButton *)sender {
    sender.selected = !sender.selected;
    if ([self.headerDelegate respondsToSelector:@selector(didClickShoppingCarHeaderViewSelectAllOfCellInSection:mark:)]) {
        [self.headerDelegate didClickShoppingCarHeaderViewSelectAllOfCellInSection:self mark:@"select"];
    }
}


/**
 点击跳转到具体超市
 */
- (IBAction)enterShop:(id)sender {
    if ([self.headerDelegate respondsToSelector:@selector(didClickShoppingCarHeaderViewSelectStore:)]) {
        [self.headerDelegate didClickShoppingCarHeaderViewSelectStore:self];
    }
}

/**
 点击编辑改变产品数量
 */
- (IBAction)didClickEditButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    if ([self.headerDelegate respondsToSelector:@selector(didClickShoppingCarHeaderViewEditButton:)]) {
    [self.headerDelegate didClickShoppingCarHeaderViewEditButton:self];
}
}





@end
