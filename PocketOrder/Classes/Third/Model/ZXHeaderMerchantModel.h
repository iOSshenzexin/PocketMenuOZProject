//
//  ZXHeaderMerchantModel.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/20.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXHeaderMerchantModel : NSObject

@property (nonatomic,assign) BOOL isSelect;

@property(nonatomic,copy) NSString * homeID;

@property(nonatomic,strong) NSMutableArray * goodsInfo;

@property (nonatomic,assign) BOOL isEdited;

@property (nonatomic,assign) BOOL isShowMinus;

@property (nonatomic,assign) BOOL isShowPlus;


@end
