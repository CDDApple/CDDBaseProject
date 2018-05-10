//
//  DynamicViewController.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/9/2.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//  动态控制器

#import "DynamicViewController.h"
#import "CDDTopScrollView.h"
#import "CDDBottomScrollView.h"
#import "DynamicTestViewController.h"

@interface DynamicViewController ()<CDDTopScrollViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) CDDTopScrollView *topScrollView;
@property (nonatomic, strong) CDDBottomScrollView *bottomScrollView;

@end

@implementation DynamicViewController
#pragma mark - Life cycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}
#pragma mark - Private method 私有方法
- (void)setupUI{
    self.navigationItem.title = @"动态";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //
    self.topScrollView = [CDDTopScrollView segmentedControlWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49) delegate:self childVcTitle:@[@"推荐 ",@"朋友圈",@"iOS",@"阿里巴巴",@"篮球",@"足球",@"乒乓球"] isScaleText:NO];
    [self.view addSubview:self.topScrollView];
    
    DynamicTestViewController *oneVc = [[DynamicTestViewController alloc] init];
    [self addChildViewController:oneVc];
    DynamicTestViewController *twoVc = [[DynamicTestViewController alloc] init];
    [self addChildViewController:twoVc];
    DynamicTestViewController *threeVc = [[DynamicTestViewController alloc] init];
    [self addChildViewController:threeVc];
    DynamicTestViewController *fourVc = [[DynamicTestViewController alloc] init];
    [self addChildViewController:fourVc];
    DynamicTestViewController *fiveVc = [[DynamicTestViewController alloc] init];
    [self addChildViewController:fiveVc];
    DynamicTestViewController *sixVc = [[DynamicTestViewController alloc] init];
    [self addChildViewController:sixVc];
    DynamicTestViewController *sevenVc = [[DynamicTestViewController alloc] init];
    [self addChildViewController:sevenVc];
    self.bottomScrollView = [CDDBottomScrollView bottomScrollViewWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_BAR_H - 49 - TabBar_HEIGHT)];
    self.bottomScrollView.childViewController = @[oneVc, twoVc, threeVc, fourVc, fiveVc, sixVc, sevenVc];
    self.bottomScrollView.delegate = self;
    [self.view addSubview:self.bottomScrollView];
    
}
#pragma mark - Interface 接口
#pragma mark - Event response 事件
#pragma mark - Delegate 代理
- (void)topScrollView:(CDDTopScrollView *)topScrollView didSelectTitleAtIndex:(NSInteger)index{
    NSLog(@"index - - %ld", (long)index);
    // 计算滚动的位置
    CGFloat offsetX = index * self.view.frame.size.width;
    self.bottomScrollView.contentOffset = CGPointMake(offsetX, 0);
    [self.bottomScrollView showChildVCViewWithIndex:index outsideVC:self];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 1.添加子控制器view
    [self.bottomScrollView showChildVCViewWithIndex:index outsideVC:self];
    
    // 2.把对应的标题选中
    [self.topScrollView changeThePositionOfTheSelectedBtnWithScrollView:scrollView];
}
#pragma mark - Getters and Setters

@end
