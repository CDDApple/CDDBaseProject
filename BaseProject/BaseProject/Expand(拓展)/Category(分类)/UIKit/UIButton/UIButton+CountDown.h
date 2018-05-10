//
//  UIButton+CountDown.h
//  CDDBaseProject
//
//  Created by 曹冬冬 on 16/2/15.
//  Copyright © 2016年 CDD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CountDown)
- (void)startTime:(NSInteger )timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle;
- (void)stopTime;
@end
