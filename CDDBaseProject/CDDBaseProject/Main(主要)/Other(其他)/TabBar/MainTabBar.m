//
//  MainTabBar.m
//  CDDBaseProject
//
//  Created by 曹冬冬 on 16/2/15.
//  Copyright © 2016年 CDD. All rights reserved.
//

#import "MainTabBar.h"
#import "MainTabButton.h"

#define MainButtonCount 4
static NSInteger tabBarIndex = 1;

@interface MainTabBar()
@property (nonatomic, assign) UIButton *selectedButton;
@property (nonatomic, assign) UIButton *PreSelectedButton;
@property (nonatomic, assign) UIView *line;
@end

@implementation MainTabBar

+ (instancetype)tabBar
{
    MainTabBar *tabBar = [[MainTabBar alloc] init];
    
    return tabBar;
}

/**
 *  按钮状态
 *
 *  Selected：必须手动设置才能达到这个状态 button.selected = YES;
 *  Highlighted:用户长按的时候达到这种状态
 *  Disabled:必须手动设置才能达到这个状态 button.enabled = NO;
 */
- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    if(tabBarIndex != 1){
        // 分隔线
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = RGB(232.0, 233.0, 232.0);
        [self addSubview:line];
        self.line = line;
    }
    
    UIButton *button = [MainTabButton buttonWithType:UIButtonTypeCustom];
    
    button.tag = tabBarIndex;
    
    [button setImage:item.image forState:UIControlStateNormal];
    [button setImage:item.selectedImage forState:UIControlStateSelected];
    button.backgroundColor = [UIColor whiteColor];
    
    if (tabBarIndex == 1) { // 默认选中第一个按钮
        [self btnClick:button];
    }
    
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:button];
    
    tabBarIndex++;
}
// 监听按钮点击
- (void)btnClick:(UIButton *)button
{
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectedFromIndex:toIndex:)]) {
        if([_delegate tabBar:self didSelectedFromIndex:_selectedButton.tag toIndex:button.tag])
        {
            button = _selectedButton;
        }
    }
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    
}

- (void)selectTabBarButtonWithIndex:(NSInteger)toIndex{
    _selectedButton.selected = NO;
    MainTabButton *btn = (MainTabButton*)[self viewWithTag:toIndex + 1];
    btn.selected = YES;
    _selectedButton = btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat lineH = 0;
    self.line.frame = CGRectMake(0, 0, M_SCREEN_W, lineH);
    
    NSInteger no = 0;
    NSUInteger count = self.subviews.count;
    for (int i = 0;i < count;i++){
        UIView *view = self.subviews[i];
        if([view isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)view;
            CGFloat btnW = self.bounds.size.width / MainButtonCount;
            CGFloat btnH = self.bounds.size.height - lineH;
            CGFloat btnX = no++ * btnW;
            
            btn.frame = CGRectMake(btnX, lineH, btnW, btnH);
        }
    }
    
}


@end
