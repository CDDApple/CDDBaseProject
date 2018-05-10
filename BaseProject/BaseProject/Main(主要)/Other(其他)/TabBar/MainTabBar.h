//
//  MainTabBar.h
//  BaseProject
//
//  Created by 曹冬冬 on 16/9/2.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MainTabBarItemType) {
    MainTabBarItemTypeRecommend = 0,
    MainTabBarItemTypeDiscover,
    MainTabBarItemTypeDynamic,
    MainTabBarItemTypeProfile,
};

@class MainTabBar;
@protocol MainTabBarDelegate <NSObject>
@optional
- (BOOL)tabBar:(MainTabBar *)tabBar didSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;
@end

@interface MainTabBar : UIView

@property (nonatomic, weak) id<MainTabBarDelegate> delegate;

- (void)addTabBarButtonWithImage:(NSString *)image selectedImage:(NSString *)selectedImage;
- (void)selectTabBarButtonWithIndex:(NSInteger)toIndex;

- (NSInteger)budgeValueForItem:(MainTabBarItemType)itemType;
- (void)setBudgeValue:(NSInteger)budgeValue forItem:(MainTabBarItemType)itemType;
- (void)replaceImage:(NSString *)image selectedImage:(NSString *)selectedImage forItem:(MainTabBarItemType)itemType;
@end
