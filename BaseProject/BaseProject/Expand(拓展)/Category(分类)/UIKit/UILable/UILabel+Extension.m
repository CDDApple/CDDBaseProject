//
//  UILabel+Extension.m
//  shangke
//
//  Created by WorkSpace on 16/2/29.
//  Copyright © 2016年 YG. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)
+ (UILabel *)labelWithRect:(CGRect)rect addFont:(UIFont *)font addtextColor:(UIColor *)textColor addLines:(NSInteger)lines addTextAlignment:(NSTextAlignment)textAlignment{
    
    UILabel *lable = [[UILabel alloc] init];
    lable.frame = rect;
    lable.font = font;
    lable.textColor = textColor;
    lable.numberOfLines = lines;
    lable.textAlignment = textAlignment;
    return lable;
}
@end
