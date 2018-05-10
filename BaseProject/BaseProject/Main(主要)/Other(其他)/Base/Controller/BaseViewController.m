//
//  BaseViewController.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/7/7.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import "BaseViewController.h"
#import "CDDLoadingAnimationView.h"
#import "CDDNoNetworkEmptyView.h"
#import "NavigationViewController.h"
#import "DiscoverDetailViewController.h"

@interface BaseViewController ()<UINavigationControllerDelegate>

@property (nonatomic, weak) CDDLoadingAnimationView *loadingAnimationView;
@property (nonatomic, weak) CDDNoNetworkEmptyView *noNetworkEmptyView;

@property (nonatomic, strong) MJRefreshNormalHeader *asd;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RANDOM_COLOR;
}

#pragma mark ViewWillAppear
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    // 1. 返回手势代理
    if (!fullscreenPopGestureRecognizer) {
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    }
    
    // 2. 导航控制器代理
    if (hiddenType == CDDNavigationHiddenTypeNavigationControllerDelegate) {
        self.navigationController.delegate = self;
    }
}

#pragma mark ViewDidAppear
- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    
    // 1. 根试图手势失效
    if (!fullscreenPopGestureRecognizer) {
        if (self == [self.navigationController.viewControllers firstObject]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        } else {
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
    }
}

-(void)dealloc{
    NSLog(@"我被释放了。。。");
    // 取消正在请求的数据
    [CDDNetWorkingManager.operationQueue cancelAllOperations];
    // 清除所有通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)pop {
    if (self.navigationController == nil) return ;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popToRootVc {
    if (self.navigationController == nil) return ;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)popToVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    if (self.navigationController == nil) return ;
    [self.navigationController popToViewController:vc animated:YES];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissWithCompletion:(void(^)())completion {
    [self dismissViewControllerAnimated:YES completion:completion];
}

- (void)presentVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    [self presentVc:vc completion:nil];
}

- (void)presentVc:(UIViewController *)vc completion:(void (^)(void))completion {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    [self presentViewController:vc animated:YES completion:completion];
}

- (void)pushVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    if (self.navigationController == nil) return ;
    if (vc.hidesBottomBarWhenPushed == NO) {
        vc.hidesBottomBarWhenPushed = YES;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)removeChildVc:(UIViewController *)childVc {
    if ([childVc isKindOfClass:[UIViewController class]] == NO) {
        return ;
    }
    [childVc.view removeFromSuperview];
    [childVc willMoveToParentViewController:nil];
    [childVc removeFromParentViewController];
}

- (void)addChildVc:(UIViewController *)childVc {
    if ([childVc isKindOfClass:[UIViewController class]] == NO) {
        return ;
    }
    [childVc willMoveToParentViewController:self];
    [self addChildViewController:childVc];
    [self.view addSubview:childVc.view];
    childVc.view.frame = self.view.bounds;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


- (void)showLoadingAnimation {
    CDDLoadingAnimationView *animation = [[CDDLoadingAnimationView alloc] init];
    [animation showInView:self.view];
    _loadingAnimationView = animation;
    [self.view bringSubviewToFront:animation];
}

- (void)hideLoadingAnimation {
    [_loadingAnimationView dismiss];
    _loadingAnimationView = nil;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.view bringSubviewToFront:self.loadingAnimationView];
}

- (CDDNoNetworkEmptyView *)noNetworkEmptyView {
    if (!_noNetworkEmptyView) {
        CDDNoNetworkEmptyView *empty = [[CDDNoNetworkEmptyView alloc] init];
        empty.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:empty];
        _noNetworkEmptyView = empty;
        
        WeakSelf(weakSelf);
        [empty mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.view);
        }];
        empty.customNoNetworkEmptyViewDidClickRetryHandle = ^(CDDNoNetworkEmptyView *emptyView) {
            [weakSelf loadData];
            
        };
    }
    return _noNetworkEmptyView;
}

- (void)loadData{
    // 数据加载动画
    [self showLoadingAnimation];

    // 网络不可用
    if ([self isNetworkReachable] == NO) {
        // 隐藏动画
        [self hideLoadingAnimation];
        // 显示无网络视图
        self.noNetworkEmptyView.hidden = NO;
        return;
    } else { // 网络可用
        // 移除无网络视图
        [self.noNetworkEmptyView removeFromSuperview];
        _noNetworkEmptyView = nil;
    }
}

- (void)loadNewData{
    if ([self isNetworkReachable]) {
        _pageIndex = 1;
    }else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = NSLocalizedString(@"网络有问题", @"HUD loading title");
        [hud hideAnimated:YES afterDelay:1.f];
    }
}

- (void)loadMoreData{
    if ([self isNetworkReachable]) {
        _pageIndex++;
    }else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = NSLocalizedString(@"网络有问题", @"HUD loading title");
        [hud hideAnimated:YES afterDelay:1.f];
    }
}

- (BOOL)isNetworkReachable {
    return [CDDNetWorking getNetworkStates];
}


#pragma mark - Private Methods
#pragma mark -
#pragma mark Whether need Navigation Bar Hidden
- (BOOL) needHiddenBarInViewController:(UIViewController *)viewController {
    
    BOOL needHideNaivgaionBar = NO;
    
    if ([viewController isKindOfClass: [DiscoverDetailViewController class]]) {
        needHideNaivgaionBar = YES;
    }
    return needHideNaivgaionBar;
}

#pragma mark - UINaivgationController Delegate
#pragma mark -
#pragma mark Will Show ViewController
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden: [self needHiddenBarInViewController: viewController]
                                             animated: animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [[[YYWebImageManager sharedManager] cache].diskCache removeAllObjects];
    [[[YYWebImageManager sharedManager] cache].memoryCache removeAllObjects];
}

- (MJRefreshNormalHeader *)refreshHeader {
    if (_refreshHeader == nil) {
        _refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _refreshHeader.automaticallyChangeAlpha = YES;
//        _refreshHeader.lastUpdatedTimeLabel.hidden = YES;
//        _refreshHeader.stateLabel.hidden = YES;
    }
    return _refreshHeader;
}
- (MJRefreshAutoNormalFooter *)refreshFooter {
    if (_refreshFooter == nil) {
        _refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        [_refreshFooter setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
        [_refreshFooter setTitle:@"全部加载完毕" forState:MJRefreshStateNoMoreData];
        _refreshFooter.stateLabel.font = [UIFont systemFontOfSize:14];
        _refreshFooter.stateLabel.textColor = RANDOM_COLOR;
    }
    return _refreshFooter;
}

@end
