//
//  ZXSupermarketListController.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/3.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZXSupermarketListController;

@protocol ZXSupermarketListControllerDelegate <NSObject>

@optional

- (void)didClickGetsupermarketName:(ZXSupermarketListController *)vc;

@end


@interface ZXSupermarketListController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,weak) id <ZXSupermarketListControllerDelegate> delegate;

@property (nonatomic,copy) NSString *name;

@end
