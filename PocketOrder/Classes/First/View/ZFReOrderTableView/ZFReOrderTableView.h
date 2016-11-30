//
//  ZFReOrderTableView.h
//
//  Created by WZF on 15/11/13.
//  Copyright © 2015年 WZF. <wzhf366@163.com>
//



#import <UIKit/UIKit.h>

@protocol ZFReOrderTableViewDelegate <NSObject>

@optional

-(void) updateDataSource:(NSMutableArray *)dataArrays;
-(void) mergeRowsInSection:(NSInteger)section splitRowIdentifier:(NSString *)identifier;

@end

@interface ZFReOrderTableView : UIView

@property (nonatomic,strong) NSMutableArray *objects;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,weak) id <ZFReOrderTableViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame withObjects:(NSMutableArray *)objects;

-(instancetype)initWithFrame:(CGRect)frame withObjects:(NSMutableArray *)objects canReorder:(BOOL)reOrder;


@end
