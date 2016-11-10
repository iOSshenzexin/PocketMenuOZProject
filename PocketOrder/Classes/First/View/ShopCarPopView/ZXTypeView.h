//
//  ZXTypeView.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/9.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZXTypeSeleteDelegete <NSObject>

-(void)btnindex:(int) tag;

@end
@interface ZXTypeView : UIView
@property(nonatomic)float height;
@property(nonatomic)int seletIndex;
@property (nonatomic,retain) id<ZXTypeSeleteDelegete> delegate;

-(instancetype)initWithFrame:(CGRect)frame andDatasource:(NSArray *)arr :(NSString *)typename;

@end
