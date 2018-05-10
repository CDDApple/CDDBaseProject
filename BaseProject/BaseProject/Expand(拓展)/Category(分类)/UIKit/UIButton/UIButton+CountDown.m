//
//  UIButton+CountDown.m
//  CDDBaseProject
//
//  Created by 曹冬冬 on 16/2/15.
//  Copyright © 2016年 CDD. All rights reserved.
//

#import "UIButton+CountDown.h"

const char  timekkey;
const char titlekey;
const char colorkey;

@implementation UIButton (CountDown)
- (void)startTime:(NSInteger )timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle{
    __block NSInteger timeOut=timeout; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    objc_setAssociatedObject(self, &timekkey, _timer, OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, &titlekey, tittle, OBJC_ASSOCIATION_RETAIN);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeOut<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setTitle:tittle forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeOut % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
                [self setTitle:[NSString stringWithFormat:@"重新获取（%@s）",strTime] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
                
            });
            timeOut--;
            
        }
    });
    dispatch_resume(_timer);
    
}

- (void)stopTime {
    dispatch_source_t _timer = objc_getAssociatedObject(self, &timekkey);
    dispatch_source_cancel(_timer);
    dispatch_async(dispatch_get_main_queue(), ^{
        self.backgroundColor = objc_getAssociatedObject(self, &colorkey);
        self.titleLabel.text = objc_getAssociatedObject(self, &titlekey);
        self.userInteractionEnabled = YES;
    });
}
@end
