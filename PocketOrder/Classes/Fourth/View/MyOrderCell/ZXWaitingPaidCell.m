//
//  ZXWaitingPaidCell.m
//  PocketOrder
//
//  Created by 青岛商通天下 on 2016/10/27.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXWaitingPaidCell.h"

@implementation ZXWaitingPaidCell

- (IBAction)didClickCancleOrder:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didClickCancleWaitingOrder:)]) {
        [self.delegate didClickCancleWaitingOrder:self];
    }
}

- (IBAction)didClickPayMoney:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didClickPayMoney:)]) {
        [self.delegate didClickPayMoney:self];
    }
}



-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 5;
    [super setFrame:frame];
}

static NSString *waitingPaidCell = @"ZXWaitingPaidCell";
+(instancetype)cellWithTableView:(UITableView *)tableview
{
    ZXWaitingPaidCell *cell = [tableview dequeueReusableCellWithIdentifier:waitingPaidCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZXWaitingPaidCell class]) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self startOrderTimer];
}

- (void)startOrderTimer{
    __block int timeout= 900; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){
            //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
#warning - 回到主线程出来事情
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                self.countdownLbl.text = [NSString stringWithFormat:@"%d%d:%d%d",(timeout/60)/10,(timeout/60) % 10,(timeout%60) / 10,(timeout%60) %10];
                [UIView commitAnimations];
            });
            timeout--;
        }
    });
    //启动定时器
    dispatch_resume(_timer);
}

@end
