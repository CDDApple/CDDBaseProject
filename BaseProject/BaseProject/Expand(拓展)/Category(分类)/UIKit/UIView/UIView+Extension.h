//
//  UIView+Extension.h
//  CDDBaseProject
//
//  Created by 曹冬冬 on 16/1/29.
//  Copyright © 2016年 CDD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AddLineOption) {
    AddLineOptionTop         = 1 << 0,
    AddLineOptionBottom      = 1 << 1,
    AddLineOptionLeft        = 1 << 2,
    AddLineOptionRight       = 1 << 3,
    AddLineOptionTopBottom   = 1 << 4,
    AddLineOptionLeftRight   = 1 << 5,
    AddLineOptionAll         = ~0L
};

@interface UIView (Extension)
+ (instancetype)getSeperateLine;
+ (instancetype)getSeperateLine:(CGFloat)height color:(UIColor *)color;
+ (instancetype)viewWithFrame:(CGRect)frame bgColor:(UIColor *)bgColor;
- (instancetype)addLineOptions:(AddLineOption)option withColor:(UIColor *)color lineCap:(CGFloat)linecap lineWidth:(CGFloat)lineWidth;
- (instancetype)addLineOptions:(AddLineOption)option;
- (UIView*)findFirstResponder;

/**
 创建一个完整的视图截屏
 */
- (UIImage *)snapshotImage;

/**
 Create a snapshot image of the complete view hierarchy.
 @discussion It's faster than "snapshotImage", but may cause screen updates.
 See -[UIView drawViewHierarchyInRect:afterScreenUpdates:] for more information.
 */
- (UIImage *)snapshotImageAfterScreenUpdates:(BOOL)afterUpdates;

/**
 创建一个完整的视图PDF
 */
- (NSData *)snapshotPDF;

/**
 视图的阴影
 
 @param color  阴影颜色
 @param offset 阴影尺寸
 @param radius 阴影半径
 */
- (void)setLayerShadow:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;

/**
 移除所有子视图
 
 @warning Never call this method inside your view's drawRect: method.
 */
- (void)removeAllSubviews;

/**
 返回视图所属控制器
 */
@property (nonatomic, readonly) UIViewController *viewController;

/**
 Returns the visible alpha on screen, taking into account superview and window.
 */
@property (nonatomic, readonly) CGFloat visibleAlpha;

/**
 坐标转移到指定视图
 
 @param point A point specified in the local coordinate system (bounds) of the receiver.
 @param view  The view or window into whose coordinate system point is to be converted.
 If view is nil, this method instead converts to window base coordinates.
 @return The point converted to the coordinate system of view.
 */
- (CGPoint)convertPoint:(CGPoint)point toViewOrWindow:(UIView *)view;

/**
 接收一个坐标从指定的视图
 
 @param point A point specified in the local coordinate system (bounds) of view.
 @param view  The view or window with point in its coordinate system.
 If view is nil, this method instead converts from window base coordinates.
 @return The point converted to the local coordinate system (bounds) of the receiver.
 */
- (CGPoint)convertPoint:(CGPoint)point fromViewOrWindow:(UIView *)view;

/**
 转移一个矩形到指定视图
 
 @param rect A rectangle specified in the local coordinate system (bounds) of the receiver.
 @param view The view or window that is the target of the conversion operation. If view is nil, this method instead converts to window base coordinates.
 @return The converted rectangle.
 */
- (CGRect)convertRect:(CGRect)rect toViewOrWindow:(UIView *)view;

/**
 接收一个矩形从指定的视图
 
 @param rect A rectangle specified in the local coordinate system (bounds) of view.
 @param view The view or window with rect in its coordinate system.
 If view is nil, this method instead converts from window base coordinates.
 @return The converted rectangle.
 */
- (CGRect)convertRect:(CGRect)rect fromViewOrWindow:(UIView *)view;


@property (nonatomic) CGFloat dd_left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat dd_top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat dd_right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat dd_bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat dd_width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat dd_height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat dd_centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat dd_centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint dd_origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  dd_size;        ///< Shortcut for frame.size.


/**
 *  动态添加手势
 */
- (void)setTapActionWithBlock:(void (^)(void))block ;

-(BOOL)intersectWithView:(UIView *)view;

@end
