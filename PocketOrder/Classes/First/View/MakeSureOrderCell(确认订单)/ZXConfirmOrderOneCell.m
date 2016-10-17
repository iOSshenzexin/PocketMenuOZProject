//
//  ZXConfirmOrderOneCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/13.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXConfirmOrderOneCell.h"

@interface ZXConfirmOrderOneCell ()

@property (nonatomic,weak) UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;

@end


@implementation ZXConfirmOrderOneCell

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    [super setFrame:frame];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.previousButton = self.firstBtn;

}

static NSString *confirmOrderOneCell = @"ConfirmOrderOneCell";
+(instancetype)cellWithTableView:(UITableView *)tableview
{
    ZXConfirmOrderOneCell *cell = [tableview dequeueReusableCellWithIdentifier:confirmOrderOneCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZXConfirmOrderOneCell class]) owner:nil options:nil] lastObject];
           }
    
    return cell;
}

- (IBAction)distribution:(UIButton *)sender {
    if (sender != self.previousButton) {
        sender.selected = self.previousButton.selected;
        self.previousButton.selected = NO;
        self.previousButton = sender;
    }

}


@end
