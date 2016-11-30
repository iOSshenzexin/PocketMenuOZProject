//
//  ZXSelectAddressTwoCell.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/17.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZXUserAddressListModel.h"
@class ZXSelectAddressTwoCell;
@protocol ZXSelectAddressTwoCellDelegate <NSObject>

- (void)didClickUpdateUserAddress:(ZXSelectAddressTwoCell *)cell;

@end



@interface ZXSelectAddressTwoCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableview;

@property (nonatomic,copy) ZXUserAddressListModel *addressModel;

@property (weak, nonatomic) IBOutlet UILabel *userInfo;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;


@property (nonatomic,weak) id<ZXSelectAddressTwoCellDelegate>delegate;

@end
