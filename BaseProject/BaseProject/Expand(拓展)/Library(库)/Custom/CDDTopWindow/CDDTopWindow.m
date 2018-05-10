//
//  CDDTopWindow.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/10/25.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import "CDDTopWindow.h"

@implementation CDDTopWindow

static UIWindow *window_;

+(void)show
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
        
        // 解决iOS9之后 状态栏左侧会出现返回其他应用的操作
        NSArray *subviews = [[[[UIApplication sharedApplication] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
        for (UIView *child in subviews) {
            if ([child isKindOfClass:NSClassFromString(@"UIStatusBarBreadcrumbItemView")]) {
                CGFloat X = CGRectGetMaxX(child.frame);
                CGFloat W = SCREEN_WIDTH - X;
                statusBarFrame = CGRectMake(X, statusBarFrame.origin.y, W, statusBarFrame.size.height);
            }
        }
        
        window_ = [[UIWindow alloc]init];
        window_.frame = statusBarFrame;
        window_.backgroundColor = [UIColor whiteColor];
        window_.windowLevel = UIWindowLevelAlert;
        window_.hidden = NO;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(topWindowClick)];
        [window_ addGestureRecognizer:tap];
    });
}

+(void)topWindowClick
{
    UIWindow *keiwindow = [UIApplication sharedApplication].keyWindow;
    [self findscrollViewsInView:keiwindow];
}

+(void)findscrollViewsInView:(UIView *)view
{
    for (UIView *subview in view.subviews) {
        [self findscrollViewsInView:subview];
    }
    if (![view isKindOfClass:[UIScrollView class]]) return;
    if(![view intersectWithView:[UIApplication sharedApplication].keyWindow])return;
    
    UIScrollView *scrollView = (UIScrollView *)view;
    // 修改offset
    
    CGPoint offset = scrollView.contentOffset;
    offset.y = - scrollView.contentInset.top;
    [scrollView setContentOffset:offset animated:YES];
    // 这是使scrollView显示出某个区域
    //    [scrollView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}
@end
