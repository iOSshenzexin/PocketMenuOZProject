//
//  ZXCustomShoppingCarCell.h
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/11/24.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXCustomShoppingCarCell;
@protocol ZXCustomShoppingCarCellDelegate <NSObject>

// 点击单个商品选择按钮回调
- (void)productSelected:(ZXCustomShoppingCarCell *)cell isSelected:(BOOL)choosed;
// 点击buyer选择按钮回调
- (void)buyerSelected:(NSInteger)sectionIndex;
// 点击buyer编辑回调按钮
- (void)buyerEditingSelected:(NSInteger)sectionIdx;
// 点击垃圾桶删除
- (void)productGarbageClick:(ZXCustomShoppingCarCell *)cell;
// 点击编辑规格按钮下拉回调
- (void)clickEditingDetailInfo:(ZXCustomShoppingCarCell *)cell;
// 商品的增加或者减少回调
- (void)plusOrMinusCount:(ZXCustomShoppingCarCell *)cell tag:(NSInteger)tag;
// 点击图片回调到主页显示
- (void)clickProductIMG:(ZXCustomShoppingCarCell *)cell;
@end

@interface ZXCustomShoppingCarCell : UITableViewCell

@property (nonatomic,assign) id<ZXCustomShoppingCarCellDelegate>delegate;
// 左侧选择按钮
@property (weak, nonatomic) IBOutlet UIButton *leftChooseButton;
// 图片
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;


// 普通模式下的容器View
@property (weak, nonatomic) IBOutlet UIView *normalBackView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;


// 编辑模式下的View
@property (weak, nonatomic) IBOutlet UIView *editBackView;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UILabel *editCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIView *editDetailView;
@property (weak, nonatomic) IBOutlet UILabel *editDetailTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *downArrowButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;


// sectionHeader
@property (weak, nonatomic) IBOutlet UIButton *headerSelectedButton;
@property (weak, nonatomic) IBOutlet UIImageView *buyerImageView;
@property (weak, nonatomic) IBOutlet UIView *buyerNameBackView;
@property (weak, nonatomic) IBOutlet UIButton *editSectionHeaderButton;
@property (weak, nonatomic) IBOutlet UILabel *buyerNameLabel;
@property (nonatomic,assign) NSInteger sectionIndex;



@end
