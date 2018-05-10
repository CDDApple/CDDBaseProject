//
//  UIImageView+Extension.h
//  BaseProject
//
//  Created by 曹冬冬 on 16/9/18.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extension)

- (void)setHeader:(NSString *)url;

- (void)setCircleHeader:(NSString *)url;

- (void)setRectHeader:(NSString *)url;


- (instancetype)initWithTarget:(id)target action:( SEL)action;

- (void)addTarget:(id)target action:( SEL)action;

@end
