//
//  UILabel+Extension.h
//  shangke
//
//  Created by WorkSpace on 16/2/29.
//  Copyright © 2016年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)
+ (UILabel *)labelWithRect:(CGRect)rect addFont:(UIFont *)font addtextColor:(UIColor *)textColor addLines:(NSInteger)lines addTextAlignment:(NSTextAlignment)textAlignment;
@end
