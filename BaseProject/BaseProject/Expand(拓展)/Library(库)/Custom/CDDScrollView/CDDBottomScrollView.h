//
//  CDDBottomScrollView.h
//  BaseProject
//
//  Created by 曹冬冬 on 2017/4/6.
//  Copyright © 2017年 曹冬冬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDDBottomScrollView : UIScrollView

/** 子控制器的个数 */
@property (nonatomic, strong) NSArray *childViewController;

/** 对象方法创建 */
- (instancetype)initWithFrame:(CGRect)frame;
/** 快速创建类方法 */
+ (instancetype)bottomScrollViewWithFrame:(CGRect)frame;

/**
 *  展示对应下标的对应子控制器的view（给外界提供的方法 -> 必须实现）
 *  @param index    外界控制器子控制器View的下标
 *  @param outsideVC    外界控制器（主控制器、self的父控制器）
 */
- (void)showChildVCViewWithIndex:(NSInteger)index outsideVC:(UIViewController *)outsideVC;

@end
