//
//  MainTabBar.h
//  CDDBaseProject
//
//  Created by 曹冬冬 on 16/2/15.
//  Copyright © 2016年 CDD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainTabBar;

@protocol MainTabBarDelegate <NSObject>

@optional
- (BOOL)tabBar:(MainTabBar *)tabBar didSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;

@end

@interface MainTabBar : UIView

@property (nonatomic, weak) id<MainTabBarDelegate> delegate;

+ (instancetype)tabBar;
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;
- (void)selectTabBarButtonWithIndex:(NSInteger)toIndex;
@end
