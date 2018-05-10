//
//  UIImageView+Extension.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/9/18.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import "UIImageView+Extension.h"
#import <UIImageView+WebCache.h>
#import "UIImage+Extension.h"

@implementation UIImageView (Extension)

/** 默认为圆形头像 */
- (void)setHeader:(NSString *)url
{
    [self setCircleHeader:url];
}
/** 设置圆形头像 */
- (void)setCircleHeader:(NSString *)url
{
    // 将占位图片也转化为圆形 其实占位图片本来就是圆形
    UIImage *placeholder = [UIImage circleImageNamed:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        // 如果image为空则返回占位图片
        if (image == nil) return;
        
        self.image = [image circleImage];
    }];
}
/** 设置方形头像 */
- (void)setRectHeader:(NSString *)url
{
    UIImage *placeholder = [UIImage imageNamed:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder];
}

- (instancetype)initWithTarget:(id)target
                        action:(SEL)action {
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:target action:action]];
    }
    return self;
}

- (void)addTarget:(id)target action:(SEL)action {
    
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:target action:action]];
}
@end
