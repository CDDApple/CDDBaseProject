//
//  UILabel+JJKAlertActionFont.m
//  shangke
//
//  Created by WorkSpace on 16/3/31.
//  Copyright © 2016年 YG. All rights reserved.
//

#import "UILabel+JJKAlertActionFont.h"

@implementation UILabel (JJKAlertActionFont)
- (void)setAppearanceFont:(UIFont *)appearanceFont
{
    if(appearanceFont)
    {
        [self setFont:appearanceFont];
    }
}

- (UIFont *)appearanceFont
{
    return self.font;
}
@end
