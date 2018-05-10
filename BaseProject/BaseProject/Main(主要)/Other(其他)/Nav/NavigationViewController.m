//
//  NavigationViewController.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/7/7.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import "NavigationViewController.h"
#import "UIImage+Extension.h"

@interface NavigationViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *popPanGesture;
@property (nonatomic, strong) id popGestureDelegate;

@end

@implementation NavigationViewController

+ (void)initialize {
    UINavigationBar *appearance = [UINavigationBar appearance];
    // 设置导航栏背景
    [appearance setTintColor:[UIColor redColor]];
    [appearance setBackgroundImage:[UIImage imageWithColor:RGB(35, 38, 43)] forBarMetrics:UIBarMetricsDefault];
    NSMutableDictionary *titleAttrs = [NSMutableDictionary dictionary];
    titleAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    titleAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    [appearance setTitleTextAttributes:titleAttrs];
    appearance.shadowImage = [[UIImage alloc] init];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 导航栏透明度
    self.navigationBar.translucent = NO;
    
    // 2. Fullscreen Pop Gesture
    !fullscreenPopGestureRecognizer?:[self addFullScreenPopGestureAction];
}

/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 自定义返回按钮
        UIButton *btn = [[UIButton alloc] init];
        [btn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
        // 如果自定义返回按钮后, 滑动返回可能失效, 需要添加下面的代码
        __weak typeof(viewController)Weakself = viewController;
        self.interactivePopGestureRecognizer.delegate = (id)Weakself;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back{
    // 判断两种情况: push 和 present
    if ((self.presentedViewController || self.presentingViewController) && self.childViewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else
        [self popViewControllerAnimated:YES];
}


#pragma mark - Private Methods
#pragma mark -
#pragma mark Add Fullscreen Pop Gesture
- (void)addFullScreenPopGestureAction
{
    self.popGestureDelegate = self.interactivePopGestureRecognizer.delegate;
    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    self.popPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.popGestureDelegate action:action];
    self.popPanGesture.maximumNumberOfTouches = 1;
    self.popPanGesture.delegate = self;
    [self.view addGestureRecognizer: self.popPanGesture];
}

#pragma mark - UIGesture Delegate
#pragma mark -
#pragma mark Should Begin
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    // Prevent Pan Gesture From Right To Left
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) return NO;
    
    // Root View Controller Can Not Begin The Pop Gesture
    if (self.viewControllers.count <= 1) return NO;
    
    return YES;
}


@end
