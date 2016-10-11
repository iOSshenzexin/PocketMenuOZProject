//
//  ZXTodayRecommendedCell.h
//  PocketOrder
//
//  Created by 杨晓婧 on 16/9/12.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXTodayRecommendedCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UICollectionView *todayCV;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
