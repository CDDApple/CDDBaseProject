//
//  UIButton+Extension.m
//  shangke
//
//  Created by WorkSpace on 16/2/29.
//  Copyright © 2016年 YG. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)
+ (UIButton *)buttonWithFrame:(CGRect)rect normalImage:(NSString *)normalImage Target:(id)target Action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    [button setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}
+ (UIButton *)buttonWithNormalTitle:(NSString *)normalTitle normalTextColor:(UIColor *)normalColor normalTextFount:(UIFont *)normalFont bgColor:(UIColor *)bgColor Target:(id)target Action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:normalTitle forState:UIControlStateNormal];
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    button.backgroundColor = bgColor;
    button.titleLabel.font = normalFont;
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}
@end
