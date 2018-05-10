//
//  CDDTopScrollView.h
//  BaseProject
//
//  Created by 曹冬冬 on 2017/4/6.
//  Copyright © 2017年 曹冬冬. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CDDTopScrollView;

@protocol CDDTopScrollViewDelegate <NSObject>

- (void)topScrollView:(CDDTopScrollView *)topScrollView didSelectTitleAtIndex:(NSInteger)index;
@end

@interface CDDTopScrollView : UIScrollView


/** Delegate */
@property (nonatomic, weak) id<CDDTopScrollViewDelegate> delegate_TS;

/**
 *  对象方法创建
 *
 *  @param frame            frame
 *  @param delegate         delegate
 *  @param childVcTitle     子控制器标题数组
 *  @param isScaleText      是否开启文字缩放功能；默认不开启
 */
- (instancetype)initWithFrame:(CGRect)frame delegate:(id<CDDTopScrollViewDelegate>)delegate childVcTitle:(NSArray *)childVcTitle isScaleText:(BOOL)isScaleText;

/**
 *  类方法创建
 *
 *  @param frame            frame
 *  @param delegate         delegate
 *  @param childVcTitle     子控制器标题数组
 *  @param isScaleText      是否开启文字缩放功能；默认不开启
 */
+ (instancetype)segmentedControlWithFrame:(CGRect)frame delegate:(id<CDDTopScrollViewDelegate>)delegate childVcTitle:(NSArray *)childVcTitle isScaleText:(BOOL)isScaleText;


- (void)changeThePositionOfTheSelectedBtnWithScrollView:(UIScrollView *)scrollView;

@end
