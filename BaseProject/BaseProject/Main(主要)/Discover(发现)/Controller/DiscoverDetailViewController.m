//
//  DiscoverDetailViewController.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/11/8.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import "DiscoverDetailViewController.h"

@interface DiscoverDetailViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *navTitleView;
@property (nonatomic, strong) UILabel *refreshLab;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
//是否应该刷新
@property(nonatomic,assign) BOOL shouldRefresh;
//偏移量
@property(nonatomic,assign) NSInteger lastContentOffY;
//是否在刷新
@property(nonatomic,assign) BOOL isRefreshing;
@end

@implementation DiscoverDetailViewController

#pragma mark - Life cycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = self.navTitleView;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 800);
    
}
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
}
#pragma mark - Private method 私有方法
/**
 将要刷新
 */
-(void)willRefresh{

}
/**
 刷新
 */
-(void)refresh{
    self.isRefreshing = YES;
    self.refreshLab.text = @"加载中...";
    [self.activityIndicatorView startAnimating];
    
    // 加载数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self endRefresh];
    });
}

/**
 结束刷新
 */
-(void)endRefresh
{
    self.isRefreshing = NO;
    self.refreshLab.text = @"";
    [self.activityIndicatorView stopAnimating];
}
#pragma mark - Interface 接口
#pragma mark - Event response 事件
#pragma mark - Delegate 代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y <= -64 && scrollView.contentOffset.y < self.lastContentOffY) {
        self.shouldRefresh = YES;
    }else{
        self.shouldRefresh = NO;
    }
    
    if (scrollView.contentOffset.y < 0 && !self.isRefreshing && scrollView.contentOffset.y < self.lastContentOffY && self.lastContentOffY < 0) {
        if(!self.isRefreshing){
            [self refresh];
        }else{
            [self endRefresh];
        }
    }
    
    self.lastContentOffY = scrollView.contentOffset.y;
}
#pragma mark - Getters and Setters
- (UIView *)navTitleView{
    if(!_navTitleView){
        _navTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        _navTitleView.backgroundColor = RANDOM_COLOR;
        self.refreshLab = [[UILabel alloc] init];
        self.refreshLab.text = @"";
        [_navTitleView addSubview:self.refreshLab];
        [self.refreshLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_navTitleView);
        }];
    
        self.activityIndicatorView = [[UIActivityIndicatorView alloc] init];
        [_navTitleView addSubview:self.activityIndicatorView];
        [self.activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.refreshLab.mas_left).with.offset(-5);
            make.centerY.equalTo(self.refreshLab);
        }];
    }
    return _navTitleView;
}
@end
