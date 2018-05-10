//
//  BaseViewController.h
//  BaseProject
//
//  Created by 曹冬冬 on 16/7/7.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  导航栏隐藏类型: 通过设置这个属性, 控制整个工程导航栏隐藏的方式
 */
typedef NS_ENUM(NSInteger, CDDNavigationHiddenType) {
    /**
     *  普通模式: [self.navigationController setNavigationBarHidden: YES];
     */
    CDDNavigationHiddenTypeNormal = 0,
    /**
     *  无动画模式: [self.navigationController setNavigationBarHidden: YES animated: NO];
     */
    CDDNavigationHiddenTypeNoAnimation = 1,
    /**
     *  有动画模式: [self.navigationController setNavigationBarHidden: YES animated: YES];
     */
    CDDNavigationHiddenTypeAnimation = 2,
    /**
     *  自动动画模式: [self.navigationController setNavigationBarHidden: YES animated: animated];
     */
    CDDNavigationHiddenTypeAutoAnimation = 3,
    /**
     *  导航控制器代理模式: self.navigationController.delegate = self;
     */
    CDDNavigationHiddenTypeNavigationControllerDelegate = 4,
    /**
     *  在 ViewWillAppear 中 设置导航栏的隐藏.
     */
    CDDNavigationHiddenTypeOnlyViewWillAppear = 5,
    
};

/**
 *  全局控制导航栏隐藏的模式
 */
static CDDNavigationHiddenType hiddenType = CDDNavigationHiddenTypeOnlyViewWillAppear;

@interface BaseViewController : UIViewController

- (void)pop;

- (void)popToRootVc;

- (void)popToVc:(UIViewController *)vc;

- (void)dismiss;

- (void)dismissWithCompletion:(void(^)())completion;

- (void)presentVc:(UIViewController *)vc;

- (void)presentVc:(UIViewController *)vc completion:(void (^)(void))completion;

- (void)pushVc:(UIViewController *)vc;

- (void)removeChildVc:(UIViewController *)childVc;

- (void)addChildVc:(UIViewController *)childVc;

/** 加载中*/
- (void)showLoadingAnimation;

/** 停止加载*/
- (void)hideLoadingAnimation;

/** 请求数据，交给子类去实现*/
// 页面首次加载
- (void)loadData;
// 下拉刷新
- (void)loadNewData;
// 上拉刷新
- (void)loadMoreData;

@property (nonatomic, assign) BOOL isNetworkReachable;


@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) MJRefreshNormalHeader *refreshHeader;
@property (nonatomic, strong) MJRefreshAutoNormalFooter *refreshFooter;
@end
