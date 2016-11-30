//
//  ZXAddressOneCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/14.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXAddressOneCell.h"


@interface ZXAddressOneCell ()

@property (nonatomic,weak) UIButton *previousBtn;

@property (weak, nonatomic) IBOutlet UIButton *manBtn;

@end

@implementation ZXAddressOneCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.previousBtn = self.manBtn;
    self.sex = self.manBtn.titleLabel.text;

}
- (IBAction)didClickSexBtn:(UIButton *)sender {
    self.sex = sender.titleLabel.text;
    if (sender != self.previousBtn) {
        sender.selected = self.previousBtn.selected;
        self.previousBtn.selected = NO;
        self.previousBtn = sender;
    }
}

static NSString *addressOneCell = @"ZXAddressOneCell";
+(instancetype)cellWithTableView:(UITableView *)tableview
{
    ZXAddressOneCell *cell = [tableview dequeueReusableCellWithIdentifier:addressOneCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZXAddressOneCell class]) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(void)setUserAddressModel:(ZXUserAddressListModel *)userAddressModel
{
    _userAddressModel = userAddressModel;
    self.userName.text = userAddressModel.true_name;
    ZXLog(@"userAddressModel.tel_phone; %@",userAddressModel.tel_phone);
    self.userTelephone.text = userAddressModel.tel_phone;
}
@end
