//
//  ZXConfirmOrderThreeCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 16/10/13.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXConfirmOrderThreeCell.h"

@interface ZXConfirmOrderThreeCell()

@property (nonatomic,weak) UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;


@end


@implementation ZXConfirmOrderThreeCell

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

- (IBAction)didClickSelectPayStyle:(UIButton *)sender {
    if (sender != self.previousButton) {
        sender.selected = self.previousButton.selected;
        self.previousButton.selected = NO;
        self.previousButton = sender;
    }
}



static NSString *confirmOrderThreeCell = @"ZXConfirmOrderThreeCell";
+(instancetype)cellWithTableView:(UITableView *)tableview
{
    ZXConfirmOrderThreeCell *cell = [tableview dequeueReusableCellWithIdentifier:confirmOrderThreeCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZXConfirmOrderThreeCell class]) owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

@end
