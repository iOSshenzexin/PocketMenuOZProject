//
//  ZXAddressTwoCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/17.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXAddressTwoCell.h"

@implementation ZXAddressTwoCell

static NSString *addressTwoCell = @"ZXAddressTwoCell";
+(instancetype)cellWithTableView:(UITableView *)tableview
{
    ZXAddressTwoCell *cell = [tableview dequeueReusableCellWithIdentifier:addressTwoCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZXAddressTwoCell class]) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(void)setUserAddressModel:(ZXUserAddressListModel *)userAddressModel
{
    _userAddressModel = userAddressModel;
    self.streetName.text = userAddressModel.address;
    
}

@end
