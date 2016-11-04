//
//  ZXConfirmOrderFourCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/14.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXConfirmOrderFourCell.h"
#import "ZXOrderContentView.h"

@interface ZXConfirmOrderFourCell()

@property (nonatomic,strong) NSMutableArray *viewArrays;


@end

@implementation ZXConfirmOrderFourCell


-(NSMutableArray *)viewArrays
{
    if (!_viewArrays) {
        _viewArrays = [NSMutableArray array];
    }
    return _viewArrays;
}

static NSString *confirmOrderFourCell = @"ZXConfirmOrderFourCell";
+(instancetype)cellWithTableView:(UITableView *)tableview
{
    ZXConfirmOrderFourCell *cell = [tableview dequeueReusableCellWithIdentifier:confirmOrderFourCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZXConfirmOrderFourCell class]) owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)setFoodsContent:(NSArray *)foodsContent
{
    _foodsContent = foodsContent;
    
    for (NSInteger i = 0; i < foodsContent.count; i ++ ) {
        ZXOrderContentView *view = [ZXOrderContentView szx_viewFromXib];
        view.orderContentModel = self.foodsContent[i];
        [self.viewArrays addObject:view];
        [self.contentView addSubview:view];
    }
}

-(void)layoutSubviews
{
     [super layoutSubviews];
    for (NSInteger i =0 ; i < self.viewArrays.count; i ++) {
        ZXOrderContentView *view = self.viewArrays[i];
        view.frame = CGRectMake(0, 43 + i * 30, ScreenW, 30);
    }
    
}


-(CGFloat)cellHeight
{
     _cellHeight += 43;
    
    _cellHeight += _foodsContent.count * 30;

    _cellHeight += 190;

    return _cellHeight;
    
}
@end
