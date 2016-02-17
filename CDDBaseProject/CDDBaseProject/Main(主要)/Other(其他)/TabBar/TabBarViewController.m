//
//  TabBarViewController.m
//  CDDBaseProject
//
//  Created by 曹冬冬 on 16/2/15.
//  Copyright © 2016年 CDD. All rights reserved.
//

#import "TabBarViewController.h"
#import "MainTabBar.h"
#import "NavigationViewController.h"

#import "IndexViewController.h"
#import "ClassViewController.h"
#import "ReadViewController.h"
#import "MeViewController.h"

@interface TabBarViewController ()<MainTabBarDelegate>
@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加tabbar
    [self setupTabBar];
    
    // 添加子控制器
    [self setupChildsViewController];
    
    // 删除系统自带的
    for (UIView *tabButton in self.tabBar.subviews) {
        if(![tabButton isKindOfClass:[MainTabBar class]])
        {
            [tabButton removeFromSuperview];
        }
    }
}

- (void)setupTabBar{
    MainTabBar *tabBar = [MainTabBar tabBar];
    tabBar.delegate = self;
    _customTabBar = tabBar;
    tabBar.frame = self.tabBar.bounds;
    
    [self.tabBar addSubview:tabBar];
}


/**
 *  创建自控制
 */
- (void)setupChildsViewController
{
    // 首页
    IndexViewController *indexVC = [[IndexViewController alloc] init];
    [self addOneChildVcClass:indexVC image:@"read1" selectedImage:@"read_selected1"];

    // 读刻
    ReadViewController *readVC = [[ReadViewController alloc] init];
    [self addOneChildVcClass:readVC image:@"read1" selectedImage:@"read_selected1"];
    
    // 班级
    ClassViewController *courseVC = [[ClassViewController alloc] init];
    [self addOneChildVcClass:courseVC image:@"read1" selectedImage:@"read_selected1"];
    
    // 我
    MeViewController *meVC = [[MeViewController alloc] init];
    [self addOneChildVcClass:meVC image:@"read1" selectedImage:@"read_selected1"];
    
}

/**
 *  添加一个子控制器
 *
 *  @param vcClass       控制器类名
 *  @param title         文字
 *  @param image         默认图片
 *  @param selectedImage 选中图片
 *
 *  @return 返回一个控制器
 */
- (void)addOneChildVcClass:(UIViewController *)vc image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    // 包装一个导航控制器后,再成为tabbar的子控制器
    NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
    // 添加按钮
    [self.customTabBar addTabBarButtonWithItem:vc.tabBarItem];
}

/**
 *  退出登录
 */
- (void)loginOut:(NSString *)messageStr
{
    
}

#pragma mark tabBar点击代理
- (BOOL)tabBar:(MainTabBar *)tabBar didSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
//    if (![AccountTool account] && (toIndex == 3 || toIndex == 4)) {
//        [LoginTool showLoginVc:self];
//        self.selectedIndex = fromIndex - 1;
//        return YES;
//    }else{
//        self.selectedIndex = toIndex - 1;
        return NO;
//    }
}

-(void)switchSeletedIndex:(NSInteger)aIndex{
    
    self.selectedIndex =aIndex;
    [self.customTabBar selectTabBarButtonWithIndex:aIndex];
    
}


@end
