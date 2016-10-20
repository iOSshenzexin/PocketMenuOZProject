//
//  ZXGoodsModel.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/20.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXGoodsModel : NSObject

//商品属性
@property(nonatomic,copy)NSString * goodsID;
@property(nonatomic,copy)NSString * goodsTitle;
@property(nonatomic,copy)NSString * goodsCount;
@property(nonatomic,copy)NSString * goodsColor;
@property(nonatomic,copy)NSString * goodsSize;
@property(nonatomic,copy)NSString * goodsPrice;
@property(nonatomic,copy)NSString * goodsImageURL;
//测试image
@property(nonatomic,copy)NSString * goodsImage;
//选中状态
@property(nonatomic,assign)BOOL isSelect;


@end
