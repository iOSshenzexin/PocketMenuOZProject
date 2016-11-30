//
//  ZXSelectAddressTwoCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/17.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXSelectAddressTwoCell.h"

@implementation ZXSelectAddressTwoCell

static NSString *selectAddressTwoCell = @"ZXSelectAddressTwoCell";
+(instancetype)cellWithTableView:(UITableView *)tableview
{
    ZXSelectAddressTwoCell *cell = [tableview dequeueReusableCellWithIdentifier:selectAddressTwoCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZXSelectAddressTwoCell class]) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(void)setAddressModel:(ZXUserAddressListModel *)addressModel{
    _addressModel = addressModel;
    self.userInfo.text = [NSString stringWithFormat:@"%@ %@ %@",addressModel.true_name,addressModel.prefixes,@(addressModel.mob_phone)];
    self.addressLabel.text = [NSString stringWithFormat:@"%@",addressModel.address];
}

- (IBAction)didClickUpdateAddress:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didClickUpdateUserAddress:)]) {
        [self.delegate didClickUpdateUserAddress:self];
    }
}


@end
