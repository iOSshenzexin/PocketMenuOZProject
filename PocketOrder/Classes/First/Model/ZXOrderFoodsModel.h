//
//  ZXOrderFoodsModel.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXOrderFoodsModel : NSObject

/*
 id = 9323284;
 */
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *picture;
@property (nonatomic,assign) NSInteger praise_num;

@property (nonatomic,assign) NSInteger month_saled;
@property (nonatomic,assign) NSInteger min_price;
@property (nonatomic,assign) NSInteger orderCount;


//@property (nonatomic,copy) NSString *food_id;




@property (nonatomic, assign) CGFloat cellHeight;
/** 中间内容的frame */
@property (nonatomic, assign) CGRect middleFrame;


@property (nonatomic,copy) NSArray *cellArray;


@end
