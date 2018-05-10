//
//  UIView+Extension.m
//  CDDBaseProject
//
//  Created by 曹冬冬 on 16/1/29.
//  Copyright © 2016年 CDD. All rights reserved.
//

#import "UIView+Extension.h"
/**
 *  动态添加手势
 */
static const char *ActionHandlerTapGestureKey;

@implementation UIView (Extension)

+ (instancetype)getSeperateLine{
    return [self getSeperateLine:0.45 color:[UIColor blackColor]];
}

+ (instancetype)getSeperateLine:(CGFloat)height color:(UIColor *)color{
    return [self viewWithFrame:(CGRect){0,0,M_SCREEN_W,height} bgColor:color];
}

+ (instancetype)viewWithFrame:(CGRect)frame bgColor:(UIColor *)bgColor{
    UIView *view = [[UIView alloc] init];
    view.frame = frame;
    view.backgroundColor = bgColor;
    return view;
}
- (instancetype)addLineOptions:(AddLineOption)option{
    return [self addLineOptions:option withColor:[UIColor blackColor] lineCap:0.45 lineWidth:self.width];
}

- (instancetype)addLineOptions:(AddLineOption)option withColor:(UIColor *)color lineCap:(CGFloat)linecap lineWidth:(CGFloat)lineWidth{

    CGFloat lineCap = linecap;
    UIColor *lineColor = color;
    if (option & AddLineOptionTop) {
        [self addSubview:[UIView viewWithFrame:CGRectMake(0,0,lineWidth,lineCap) bgColor:lineColor]];
    }
    if (option & AddLineOptionBottom){
        [self addSubview:[UIView viewWithFrame:CGRectMake(0,self.height-lineCap,lineWidth,lineCap) bgColor:lineColor]];
    }
    if (option & AddLineOptionLeft){
        [self addSubview:[UIView viewWithFrame:CGRectMake(0,0,lineCap,self.height) bgColor:lineColor]];
    }
    if (option & AddLineOptionRight){
        [self addSubview:[UIView viewWithFrame:CGRectMake(0,self.width-lineCap,lineCap,self.height) bgColor:lineColor]];
    }
    return self;
}
- (UIView*)findFirstResponder{
    
    if (self.isFirstResponder) return self;
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView findFirstResponder];
        if (firstResponder != nil) return firstResponder;
    }
    return nil;
}

- (UIImage *)snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (UIImage *)snapshotImageAfterScreenUpdates:(BOOL)afterUpdates {
    if (![self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        return [self snapshotImage];
    }
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:afterUpdates];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (NSData *)snapshotPDF {
    CGRect bounds = self.bounds;
    NSMutableData* data = [NSMutableData data];
    CGDataConsumerRef consumer = CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)data);
    CGContextRef context = CGPDFContextCreate(consumer, &bounds, NULL);
    CGDataConsumerRelease(consumer);
    if (!context) return nil;
    CGPDFContextBeginPage(context, NULL);
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [self.layer renderInContext:context];
    CGPDFContextEndPage(context);
    CGPDFContextClose(context);
    CGContextRelease(context);
    return data;
}

- (void)setLayerShadow:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius {
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = 1;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)removeAllSubviews {
    //[self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}


- (UIViewController *)viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (CGFloat)visibleAlpha {
    if ([self isKindOfClass:[UIWindow class]]) {
        if (self.hidden) return 0;
        return self.alpha;
    }
    if (!self.window) return 0;
    CGFloat alpha = 1;
    UIView *v = self;
    while (v) {
        if (v.hidden) {
            alpha = 0;
            break;
        }
        alpha *= v.alpha;
        v = v.superview;
    }
    return alpha;
}

- (CGPoint)convertPoint:(CGPoint)point toViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertPoint:point toWindow:nil];
        } else {
            return [self convertPoint:point toView:nil];
        }
    }
    
    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    if ((!from || !to) || (from == to)) return [self convertPoint:point toView:view];
    point = [self convertPoint:point toView:from];
    point = [to convertPoint:point fromWindow:from];
    point = [view convertPoint:point fromView:to];
    return point;
}

- (CGPoint)convertPoint:(CGPoint)point fromViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertPoint:point fromWindow:nil];
        } else {
            return [self convertPoint:point fromView:nil];
        }
    }
    
    UIWindow *from = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    UIWindow *to = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    if ((!from || !to) || (from == to)) return [self convertPoint:point fromView:view];
    point = [from convertPoint:point fromView:view];
    point = [to convertPoint:point fromWindow:from];
    point = [self convertPoint:point fromView:to];
    return point;
}

- (CGRect)convertRect:(CGRect)rect toViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect toWindow:nil];
        } else {
            return [self convertRect:rect toView:nil];
        }
    }
    
    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    if (!from || !to) return [self convertRect:rect toView:view];
    if (from == to) return [self convertRect:rect toView:view];
    rect = [self convertRect:rect toView:from];
    rect = [to convertRect:rect fromWindow:from];
    rect = [view convertRect:rect fromView:to];
    return rect;
}

- (CGRect)convertRect:(CGRect)rect fromViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect fromWindow:nil];
        } else {
            return [self convertRect:rect fromView:nil];
        }
    }
    
    UIWindow *from = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    UIWindow *to = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    if ((!from || !to) || (from == to)) return [self convertRect:rect fromView:view];
    rect = [from convertRect:rect fromView:view];
    rect = [to convertRect:rect fromWindow:from];
    rect = [self convertRect:rect fromView:to];
    return rect;
}

- (CGFloat)dd_left {
    return self.frame.origin.x;
}

- (void)setDd_left:(CGFloat)dd_left {
    CGRect frame = self.frame;
    frame.origin.x = dd_left;
    self.frame = frame;
}

- (CGFloat)dd_top {
    return self.frame.origin.y;
}

- (void)setDd_top:(CGFloat)dd_top {
    CGRect frame = self.frame;
    frame.origin.y = dd_top;
    self.frame = frame;
}

- (CGFloat)dd_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setDd_right:(CGFloat)dd_right {
    CGRect frame = self.frame;
    frame.origin.x = dd_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)dd_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setDd_bottom:(CGFloat)dd_bottom {
    CGRect frame = self.frame;
    frame.origin.y = dd_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)dd_width {
    return self.frame.size.width;
}

- (void)setDd_width:(CGFloat)dd_width {
    CGRect frame = self.frame;
    frame.size.width = dd_width;
    self.frame = frame;
}

- (CGFloat)dd_height {
    return self.frame.size.height;
}

- (void)setDd_height:(CGFloat)dd_height {
    CGRect frame = self.frame;
    frame.size.height = dd_height;
    self.frame = frame;
}

- (CGFloat)dd_centerX {
    return self.center.x;
}

- (void)setDd_centerX:(CGFloat)dd_centerX {
    self.center = CGPointMake(dd_centerX, self.center.y);
}

- (CGFloat)dd_centerY {
    return self.center.y;
}

- (void)setDd_centerY:(CGFloat)dd_centerY {
    self.center = CGPointMake(self.center.x, dd_centerY);
}

- (CGPoint)dd_origin {
    return self.frame.origin;
}

- (void)setDd_origin:(CGPoint)dd_origin {
    CGRect frame = self.frame;
    frame.origin = dd_origin;
    self.frame = frame;
}

- (CGSize)dd_size {
    return self.frame.size;
}

- (void)setDd_size:(CGSize)dd_size {
    CGRect frame = self.frame;
    frame.size = dd_size;
    self.frame = frame;
}

- (void)setTapActionWithBlock:(void (^)(void))block {
    
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &ActionHandlerTapGestureKey);
    
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &ActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    objc_setAssociatedObject(self, &ActionHandlerTapGestureKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForTapGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized)  {
        void(^action)(void) = objc_getAssociatedObject(self, &ActionHandlerTapGestureKey);
        if (action)  {
            action();
        }
    }
}

-(BOOL)intersectWithView:(UIView *)view
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    CGRect newRect = [self convertRect:self.bounds toView:window];
    CGRect newView = [view convertRect:view.bounds toView:window];
    
    return CGRectIntersectsRect(newRect, newView);
}
@end
