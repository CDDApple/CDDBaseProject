//
//  DiscoverViewController.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/9/2.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//  发现控制器

#import "DiscoverViewController.h"
#import "DiscoverHotCell.h"
#import "DiscoverHotTopicCell.h"

#import "DiscoverDetailViewController.h"

@interface DiscoverViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *discoverTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UIView *headerView;
@end

@implementation DiscoverViewController
#pragma mark - Life cycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (hiddenType == CDDNavigationHiddenTypeOnlyViewWillAppear) {
        [self.navigationController setNavigationBarHidden: NO animated: animated];
    }
}
#pragma mark - Private method 私有方法
- (void)setupUI{
    self.navigationItem.title = @"发现";
    self.discoverTableView.tableHeaderView = self.headerView;
    // 添加下拉刷新
    self.discoverTableView.mj_header = self.refreshHeader;
    
}



#pragma mark - Interface 接口
- (void)loadData{
    [super loadData];
    
    [self loadNewData];
}

- (void)loadNewData{
    [super loadNewData];
    DLog(@"-页数-%zd", self.pageIndex);
    [self loadDataSource];
}
- (void)loadMoreData{
    [super loadMoreData];
    
    DLog(@"-页数-%zd", self.pageIndex);
    [self loadDataSource];
}

- (void)loadDataSource{
    
    NSInteger count = 17;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pro_state"] = @"2";
    params[@"page"] = [NSString stringWithFormat:@"%zd", self.pageIndex];
    params[@"count"] = [NSString stringWithFormat:@"%zd", count];
    
    [CDDNetWorkingManager POST:kRecommendListAPI params:params result:^(NSString *stateCode, NSDictionary *result, NSError *error) {
        // 1.视图
        [self hideLoadingAnimation];
        
        if([stateCode integerValue] == 0){
            if(error != nil){
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.label.text = NSLocalizedString(@"服务器加载失败,请重试!", @"HUD loading title");
                [hud hideAnimated:YES afterDelay:1.f];
            }
            [self.discoverTableView.mj_header endRefreshing];
            [self.discoverTableView.mj_footer endRefreshing];
            return;
        }
        
        // 数据初始化
        if(self.pageIndex == 1){
            [self.dataSource removeAllObjects];
        }
        
        // 2.数据解析
        NSMutableArray *arrM = [NSMutableArray arrayWithArray:@[@{@"title":@"今日最热",@"type":@"0",@"body":@[@{@"title":@"蓝色情人节",@"image":@"http://res.eshangke.com/boss_collect/avatar/000/000/000/48.jpg?v=1791",@"tag":@"搞笑"},@{@"title":@"澳门风云",@"image":@"http://res.eshangke.com/boss_collect/avatar/000/000/000/46.jpg?v=4224",@"tag":@"动作"},@{@"title":@"小黄人",@"image":@"http://res.eshangke.com/boss_collect/avatar/000/000/000/48.jpg?v=1791",@"tag":@"搞笑"},@{@"title":@"迷幻",@"image":@"http://res.eshangke.com/boss_collect/avatar/000/000/000/46.jpg?v=4224",@"tag":@"动作"}]},@{@"title":@"本月最热",@"type":@"1",@"body":@[@{@"title":@"蓝色情人节",@"image":@"http://res.eshangke.com/boss_collect/avatar/000/000/000/46.jpg?v=4224",@"tag":@"搞笑"},@{@"title":@"灵魂摆渡3",@"image":@"http://res.eshangke.com/boss_collect/avatar/000/000/000/48.jpg?v=1791",@"tag":@"搞笑"},@{@"title":@"驴得水",@"image":@"http://res.eshangke.com/boss_collect/avatar/000/000/000/46.jpg?v=4224",@"tag":@"动作"}]},@{@"title":@"最新主题",@"type":@"2",@"body":@[@{@"title":@"梦想开始室",@"image":@"http://res.eshangke.com/boss_collect/avatar/000/000/000/48.jpg?v=1791",@"tag":@"搞笑"},@{@"title":@"教育ing",@"image":@"http://res.eshangke.com/boss_collect/avatar/000/000/000/46.jpg?v=4224",@"tag":@"动作"},@{@"title":@"开心动漫",@"image":@"http://res.eshangke.com/boss_collect/avatar/000/000/000/48.jpg?v=1791",@"tag":@"搞笑"},@{@"title":@"喜剧之王",@"image":@"http://res.eshangke.com/boss_collect/avatar/000/000/000/46.jpg?v=4224",@"tag":@"动作"}]},@{@"title":@"热门主题",@"type":@"3",@"body":@[@{@"title":@"梦想开始室",@"image":@"http://res.eshangke.com/boss_collect/avatar/000/000/000/48.jpg?v=1791",@"tag":@"搞笑"},@{@"title":@"教育ing",@"image":@"http://res.eshangke.com/boss_collect/avatar/000/000/000/46.jpg?v=4224",@"tag":@"动作"},@{@"title":@"开心动漫",@"image":@"http://res.eshangke.com/boss_collect/avatar/000/000/000/48.jpg?v=1791",@"tag":@"搞笑"},@{@"title":@"喜剧之王",@"image":@"http://res.eshangke.com/boss_collect/avatar/000/000/000/46.jpg?v=4224",@"tag":@"动作"}]}]];
        for (NSDictionary *dict in arrM) {
            DiscoverModel *discoverModel = [DiscoverModel mj_objectWithKeyValues:dict];
            [self.dataSource addObject:discoverModel];
        }
        
        // 3.返回数据个数 等于 每页个数 添加上拉刷新
//        if(self.dataSource.count == 4){
//            self.discoverTableView.mj_footer = self.refreshFooter;
//        }
        
        // 4.刷新表格&结束刷新
        [self.discoverTableView reloadData];
        [self.discoverTableView.mj_header endRefreshing];
        [self.discoverTableView.mj_footer endRefreshing];
    }];
}



#pragma mark - Event response 事件
#pragma mark - Delegate 代理
#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DiscoverModel *discoverModel = self.dataSource[indexPath.row];
    
    if([discoverModel.type isEqualToString:@"0"] || [discoverModel.type isEqualToString:@"1"]){ // 今日最热
        DiscoverHotCell *cell = [DiscoverHotCell cellWithTableview:tableView];
        cell.discoverModel = discoverModel;
        cell.body = discoverModel.body;

        [cell goRankBlockWithBlock:^{ // 排行榜
            DiscoverDetailViewController *discoverDetailVC = [[DiscoverDetailViewController alloc] init];
            discoverDetailVC.title = @"排行榜";
            [self pushVc:discoverDetailVC];
        }];
        
        [cell cellClickWithBlock:^(Body *body) {
            DiscoverDetailViewController *discoverDetailVC = [[DiscoverDetailViewController alloc] init];
            discoverDetailVC.title = body.title;
            [self pushVc:discoverDetailVC];
        }];
        
        [cell goMoreBlockWithBlock:^{ // 更多
            DiscoverDetailViewController *discoverDetailVC = [[DiscoverDetailViewController alloc] init];
            discoverDetailVC.title = @"更多";
            [self pushVc:discoverDetailVC];
        }];
        
        return cell;
    }else{ // 最热主题
        DiscoverHotTopicCell *cell = [DiscoverHotTopicCell cellWithTableview:tableView];
        cell.discoverModel = discoverModel;
        cell.body = discoverModel.body;
        
        [cell cellClickWithBlock:^(Body *body) {
            DiscoverDetailViewController *discoverDetailVC = [[DiscoverDetailViewController alloc] init];
            discoverDetailVC.title = body.title;
            [self pushVc:discoverDetailVC];
        }];
        
        [cell goMoreBlockWithBlock:^{ // 更多
            DiscoverDetailViewController *discoverDetailVC = [[DiscoverDetailViewController alloc] init];
            discoverDetailVC.title = @"更多";
            [self pushVc:discoverDetailVC];
        }];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DiscoverModel *discoverModel = self.dataSource[indexPath.row];
    return discoverModel.cellHeight;
}

#pragma mark - Getters and Setters
- (UITableView *)discoverTableView{
    if(!_discoverTableView){
        _discoverTableView = [[UITableView alloc] init];
        _discoverTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_BAR_H);
        _discoverTableView.delegate = self;
        _discoverTableView.dataSource = self;
        _discoverTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _discoverTableView.backgroundColor = RGB(244, 244, 244);
        [self.view addSubview:_discoverTableView];
    }
    return _discoverTableView;
}
- (NSMutableArray *)dataSource{
    if(!_dataSource){
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (UIView *)headerView{
    if(!_headerView){
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        _headerView.backgroundColor = RANDOM_COLOR;
    }
    return _headerView;
}
@end
