//
//  MainTabBar.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/9/2.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import "MainTabBar.h"
#import "MainTabButton.h"

#define kMainButtonCount 4

@interface MainTabBar()
@property (nonatomic, assign) UIButton *selectedButton;
@property (nonatomic, assign) UIButton *PreSelectedButton;
@property (nonatomic, assign) UIView *line;
@property (nonatomic, assign) NSInteger tabBarIndex;
@end

@implementation MainTabBar

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarIndex = MainTabBarItemTypeRecommend;
        self.tag = 999;
        self.backgroundColor = RGB(35, 38, 43);
    }
    return self;
}

- (void)addTabBarButtonWithImage:(NSString *)image selectedImage:(NSString *)selectedImage {
    if(self.tabBarIndex != MainTabBarItemTypeRecommend){
        // 分隔线
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = RGB(0, 0, 0);
        line.tag = 999;
        [self addSubview:line];
        self.line = line;
    }
    
    MainTabButton *button = [MainTabButton buttonWithType:UIButtonTypeCustom];
    button.tag = self.tabBarIndex;
    
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    button.backgroundColor = [UIColor clearColor];
    
    if (self.tabBarIndex == MainTabBarItemTypeRecommend) { // 默认选中第一个按钮
        [self btnClick:button];
    }
    
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:button];
    
    self.tabBarIndex ++;
}

- (void)selectTabBarButtonWithIndex:(NSInteger)toIndex {
    MainTabButton *btn = (MainTabButton *)[self viewWithTag:toIndex];
    [self btnClick:btn];
}

// 更新button的image
- (void)replaceImage:(NSString *)image selectedImage:(NSString *)selectedImage forItem:(MainTabBarItemType)itemType {
    UIView *tempView = [self viewWithTag:itemType];
    if ([tempView isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)tempView;
        [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    }
}

// 获取button的budgeValue
- (NSInteger)budgeValueForItem:(MainTabBarItemType)itemType {
    NSInteger budgeValue = 0;
    UIView *tempView = [self viewWithTag:itemType];
    if ([tempView isKindOfClass:[MainTabButton class]]) {
        MainTabButton *mainTabButton = (MainTabButton *)tempView;
        budgeValue = mainTabButton.badgeValue;
    }
    return budgeValue;
}

// 更新button的budgeValue
- (void)setBudgeValue:(NSInteger)budgeValue forItem:(MainTabBarItemType)itemType {
    UIView *tempView = [self viewWithTag:itemType];
    if ([tempView isKindOfClass:[MainTabButton class]]) {
        MainTabButton *mainTabButton = (MainTabButton *)tempView;
        mainTabButton.badgeValue = budgeValue;
    }
}

// 按钮点击
- (void)btnClick:(UIButton *)button {
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectedFromIndex:toIndex:)]) {
        if([_delegate tabBar:self didSelectedFromIndex:_selectedButton.tag toIndex:button.tag]) {
            button = _selectedButton;
        }
    }
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat lineH = 0.45;
    self.line.frame = CGRectMake(0, 0, M_SCREEN_W, lineH);
    
    NSInteger no = 0;
    NSUInteger count = self.subviews.count;
    for (int i = 0; i < count; i++){
        UIView *view = self.subviews[i];
        if([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            CGFloat btnW = self.bounds.size.width / kMainButtonCount;
            CGFloat btnH = self.bounds.size.height - lineH;
            CGFloat btnX = no++ * btnW;
            
            btn.frame = CGRectMake(btnX, lineH, btnW, btnH);
            //            btn.backgroundColor = RANDOM_COLOR;
        }
    }
}
@end
