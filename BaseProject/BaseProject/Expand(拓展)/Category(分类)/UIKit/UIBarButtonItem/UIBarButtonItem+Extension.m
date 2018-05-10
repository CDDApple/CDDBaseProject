//
//  UIBarButtonItem+Extension.m
//  CDDBaseProject
//
//  Created by 曹冬冬 on 16/2/15.
//  Copyright © 2016年 CDD. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    btn.size = btn.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
{
    UILabel *navLeftItem = [[UILabel alloc] init];
    UIFont *font = [UIFont systemFontOfSize:18];
    CGSize LeftItemSize =[title sizeWithAttributes:@{NSFontAttributeName:font}];
    CGFloat LeftItemW = ceil(LeftItemSize.width);
    navLeftItem.frame = CGRectMake(0, 0, LeftItemW, TOP_BAR_H);
    navLeftItem.text = title;
    navLeftItem.textColor = [UIColor whiteColor];
    navLeftItem.font = font;
    return [[UIBarButtonItem alloc] initWithCustomView:navLeftItem];
}
@end
