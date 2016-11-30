//
//  ZXChangePersonInfoController.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/19.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXChangePersonInfoController;
@protocol ZXPassHeadImageDelegate <NSObject>

@optional

- (void)passHeaderImage:(ZXChangePersonInfoController *)vc;

@end


@interface ZXChangePersonInfoController : UITableViewController

@property (weak, nonatomic) IBOutlet UIButton *headImage;

@property (weak, nonatomic) IBOutlet UITextField *userName;

@property (weak, nonatomic) IBOutlet UITextField *telephone;

@property (weak, nonatomic) IBOutlet UITextField *email;

@property (nonatomic,weak) id <ZXPassHeadImageDelegate> delegate;


+ (ZXChangePersonInfoController *)sharedController;

@end
