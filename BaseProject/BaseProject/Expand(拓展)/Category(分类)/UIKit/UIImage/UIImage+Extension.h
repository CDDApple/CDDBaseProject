//
//  UIImage+Extension.h
//  shangke
//
//  Created by 曹冬冬 on 16/2/29.
//  Copyright © 2016年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/**
 *  视图生成UIImage
 */
+ (UIImage *)createImageFromView:(UIView*)view;
/**
 *  根据颜色生成一张尺寸为1*1的相同颜色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
/**
 *  取某个位子的色值
 */
- (UIColor *)colorAtPixel:(CGPoint)point;
/**
 *  返回圆形图片
 */
-(instancetype)circleImage;
/**
 *  直接根据image name设置圆角
 */
+(instancetype)circleImageNamed:(NSString *)name;
@end
