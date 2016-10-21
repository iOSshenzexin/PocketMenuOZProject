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
// ZXShoppingCarHeaderView *
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



- (IBAction)select:(UIButton *)sender {
    sender.selected = !sender.selected;
    if ([self.headerDelegate respondsToSelector:@selector(didClickShoppingCarHeaderViewSelectAllOfCellInSection:mark:)]) {
        [self.headerDelegate didClickShoppingCarHeaderViewSelectAllOfCellInSection:self mark:@"select"];
    }
    
}


- (IBAction)enterShop:(id)sender {
    
}

- (IBAction)edit:(UIButton *)sender {
    sender.selected = !sender.selected;
//    if ([self.headerDelegate respondsToSelector:@selector(didClickShoppingCarHeaderViewSelectAllOfCellInSection:mark:)]) {
//        [self.headerDelegate didClickShoppingCarHeaderViewSelectAllOfCellInSection:self mark:@"edit"];
//    }
}


@end
