//
//  ZXConfirmOrderFourCell.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/14.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZXOrderFoodsModel.h"
@interface ZXConfirmOrderFourCell : UITableViewCell

@property (nonatomic,copy) NSArray *foodsContent;

+(instancetype)cellWithTableView:(UITableView *)tableview;

@property (nonatomic, assign) CGFloat cellHeight;


@end
