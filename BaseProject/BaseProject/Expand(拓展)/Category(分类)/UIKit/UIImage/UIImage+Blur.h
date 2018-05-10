//
//  UIImage+Blur.h
//  shangke
//
//  Created by 郭玉富 on 16/6/22.
//  Copyright © 2016年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Blur)

+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

@end
