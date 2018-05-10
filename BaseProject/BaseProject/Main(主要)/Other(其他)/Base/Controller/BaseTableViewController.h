//
//  BaseTableViewController.h
//  BaseProject
//
//  Created by 曹冬冬 on 16/10/28.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import "BaseViewController.h"
#import "CDDBaseTableViewCell.h"
#import "CDDBaseTableView.h"

typedef void(^CDDTableVcCellSelectedHandle)(CDDBaseTableViewCell *cell, NSIndexPath *indexPath);

typedef NS_ENUM(NSUInteger, CDDBaseTableVcRefreshType) {
    /** 无法刷新*/
    CDDBaseTableVcRefreshTypeNone = 0,
    /** 只能刷新*/
    CDDBaseTableVcRefreshTypeOnlyCanRefresh,
    /** 只能上拉加载*/
    CDDBaseTableVcRefreshTypeOnlyCanLoadMore,
    /** 能刷新*/
    CDDBaseTableVcRefreshTypeRefreshAndLoadMore
};

@interface BaseTableViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *_dataSource;
}
/** 刚才执行的是刷新*/
@property (nonatomic, assign) NSInteger isRefresh;

/** 刚才执行的是上拉加载*/
@property (nonatomic, assign) NSInteger isLoadMore;

/** 添加空界面文字*/
- (void)dd_addEmptyPageWithText:(NSString *)text;

/** 设置导航栏右边的item*/
- (void)dd_setUpNavRightItemTitle:(NSString *)itemTitle handle:(void(^)(NSString *rightItemTitle))handle;

/** 设置导航栏左边的item*/
- (void)dd_setUpNavLeftItemTitle:(NSString *)itemTitle handle:(void(^)(NSString *rightItemTitle))handle;

/** 监听通知*/
- (void)dd_observeNotiWithNotiName:(NSString *)notiName action:(SEL)action;

/** 隐藏statusBar*/
@property (nonatomic, assign) BOOL hiddenStatusBar;

/** statusBar风格*/
@property (nonatomic, assign) UIStatusBarStyle barStyle;

/** 导航右边Item*/
@property (nonatomic, strong) UIBarButtonItem *navRightItem;

/** 导航左边Item*/
@property (nonatomic, strong) UIBarButtonItem *navLeftItem;

/** 标题*/
@property (nonatomic, copy) NSString *navItemTitle;

/** 表视图*/
@property (nonatomic, weak) CDDBaseTableView *tableView;

/** 表视图偏移*/
@property (nonatomic, assign) UIEdgeInsets tableEdgeInset;

/** 分割线颜色*/
@property (nonatomic, assign) UIColor *sepLineColor;

/** 数据源数量*/
@property (nonatomic, strong) NSMutableArray *dataArray;

/** 加载刷新类型*/
@property (nonatomic, assign) CDDBaseTableVcRefreshType refreshType;

/** 是否需要系统的cell的分割线*/
@property (nonatomic, assign) BOOL needCellSepLine;

/** 刷新数据*/
- (void)dd_reloadData;

/** 开始下拉*/
- (void)dd_beginRefresh;

/** 停止刷新*/
- (void)dd_endRefresh;

/** 停止上拉加载*/
- (void)dd_endLoadMore;

/** 隐藏刷新*/
- (void)dd_hiddenRrefresh;

/** 隐藏上拉加载*/
- (void)dd_hiddenLoadMore;

/** 提示没有更多信息*/
- (void)dd_noticeNoMoreData;

/** 配置数据*/
- (void)dd_commonConfigResponseWithResponse:(id)response isRefresh:(BOOL)isRefresh modelClass:(__unsafe_unretained Class)modelClass;

/** 配置数据*/
- (void)dd_commonConfigResponseWithResponse:(id)response isRefresh:(BOOL)isRefresh modelClass:(__unsafe_unretained Class)modelClass emptyText:(NSString *)emptyText;

/** 是否在下拉刷新*/
@property (nonatomic, assign, readonly) BOOL isHeaderRefreshing;

/** 是否在上拉加载*/
@property (nonatomic, assign, readonly) BOOL isFooterRefreshing;

#pragma mark - 子类去重写
/** 分组数量*/
- (NSInteger)dd_numberOfSections;

/** 某个分组的cell数量*/
- (NSInteger)dd_numberOfRowsInSection:(NSInteger)section;

/** 某行的cell*/
- (CDDBaseTableViewCell *)dd_cellAtIndexPath:(NSIndexPath *)indexPath;

/** 点击某行*/
- (void)dd_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(CDDBaseTableViewCell *)cell;

/** 某行行高*/
- (CGFloat)dd_cellheightAtIndexPath:(NSIndexPath *)indexPath;

/** 某个组头*/
- (UIView *)dd_headerAtSection:(NSInteger)section;

/** 某个组尾*/
- (UIView *)dd_footerAtSection:(NSInteger)section;

/** 某个组头高度*/
- (CGFloat)dd_sectionHeaderHeightAtSection:(NSInteger)section;

/** 某个组尾高度*/
- (CGFloat)dd_sectionFooterHeightAtSection:(NSInteger)section;

/** 分割线偏移*/
- (UIEdgeInsets)dd_sepEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - 子类去继承
/** 刷新方法*/
- (void)dd_refresh;

/** 上拉加载方法*/
- (void)dd_loadMore;

@property (nonatomic, assign) BOOL showRefreshIcon;

- (void)endRefreshIconAnimation;

@property (nonatomic, weak, readonly) UIView *refreshHeader;

#pragma mark - loading & alert
- (void)dd_showLoading;

- (void)dd_hiddenLoading;

- (void)dd_showTitle:(NSString *)title after:(NSTimeInterval)after;

@end
