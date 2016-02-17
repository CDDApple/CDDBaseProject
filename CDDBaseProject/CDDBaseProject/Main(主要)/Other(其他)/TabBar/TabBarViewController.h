//
//  TabBarViewController.h
//  CDDBaseProject
//
//  Created by 曹冬冬 on 16/2/15.
//  Copyright © 2016年 CDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBar.h"

@interface TabBarViewController : UITabBarController
@property (nonatomic, strong) MainTabBar *customTabBar;

//- (void)loginOut:(NSString *)messageStr;
//-(void)switchSeletedIndex:(NSInteger)aIndex;
@end
