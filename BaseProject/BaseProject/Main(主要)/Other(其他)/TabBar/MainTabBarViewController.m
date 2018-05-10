//
//  MainTabBarViewController.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/7/7.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "NavigationViewController.h"

#import "RecommendViewController.h"
#import "DiscoverViewController.h"
#import "DynamicViewController.h"
#import "ProfileViewController.h"

@interface MainTabBarViewController ()<MainTabBarDelegate>
@property (nonatomic, strong) UIImageView *adImageView;
@property (nonatomic, strong) MainTabBar *customTabBar;
@end

@implementation MainTabBarViewController
#pragma mark - Life cycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChildsViewController];
    self.tabBar.shadowImage = [[UIImage alloc] init];
    [self.tabBar addSubview:self.customTabBar];
    
}
#pragma mark - Private method 私有方法
- (void)setupChildsViewController {
    [self addOneChildViewController:[[RecommendViewController alloc] init] image:@"v2_home" title:@"推荐"];
    [self addOneChildViewController:[[DiscoverViewController alloc] init] image:@"v2_my" title:@"发现"];
    [self addOneChildViewController:[[DynamicViewController alloc] init] image:@"v2_order" title:@"动态"];
    [self addOneChildViewController:[[ProfileViewController alloc] init] image:@"v2_my" title:@"我的"];
}

- (void)addOneChildViewController:(UIViewController *)childController image:(NSString *)image title:(NSString *)title{
    NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
    // 添加按钮
    [self.customTabBar addTabBarButtonWithImage:image selectedImage:[NSString stringWithFormat:@"%@_r", image]];
}
#pragma mark - Interface 接口
#pragma mark - Event response 事件
#pragma mark - Delegate 代理
#pragma mark MainTabBarDelegate, 自定义tabBar的代理方法
- (BOOL)tabBar:(MainTabBar *)tabBar didSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    self.selectedIndex = toIndex;
    return NO;
}

#pragma mark - Getters and Setters
- (MainTabBar *)customTabBar {
    if (_customTabBar == nil) {
        _customTabBar = [[MainTabBar alloc] init];
        _customTabBar.delegate = self;
        _customTabBar.frame = self.tabBar.bounds;
    }
    return _customTabBar;
}
- (void)setAdImage:(UIImage *)adImage{
    _adImage = adImage;
    
    _adImageView = [[UIImageView alloc] init];
    _adImageView.frame = [UIScreen mainScreen].bounds;
    _adImageView.image = adImage;
    [self.view addSubview:_adImageView];
    
    __weak typeof(self) weekSelf = self;
    [UIImageView animateWithDuration:1 animations:^{
        weekSelf.adImageView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        weekSelf.adImageView.alpha = 0;
    } completion:^(BOOL finished) {
        [weekSelf.adImageView removeFromSuperview];
        weekSelf.adImageView = nil;
    }];
    
}
@end
