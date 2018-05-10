//
//  UIButton+Extension.h
//  shangke
//
//  Created by WorkSpace on 16/2/29.
//  Copyright © 2016年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)
+ (UIButton *)buttonWithFrame:(CGRect)rect normalImage:(NSString *)normalImage Target:(id)target Action:(SEL)action;
+ (UIButton *)buttonWithNormalTitle:(NSString *)normalTitle normalTextColor:(UIColor *)normalColor normalTextFount:(UIFont *)normalFont bgColor:(UIColor *)bgColor Target:(id)target Action:(SEL)action;
@end
