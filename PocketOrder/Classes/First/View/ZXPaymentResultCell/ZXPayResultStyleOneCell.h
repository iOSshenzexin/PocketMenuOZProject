//
//  ZXPayResultStyleOneCell.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/28.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXPayResultStyleOneCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *statusImage;


+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
