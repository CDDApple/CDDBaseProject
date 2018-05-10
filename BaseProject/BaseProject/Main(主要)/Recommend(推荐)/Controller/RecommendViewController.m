//
//  RecommendViewController.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/9/2.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//  推荐控制器

#import "RecommendViewController.h"
#import "RecommendCell.h"

#import "RecommendDetailViewController.h"

NSString *RecommendCellIdentifier = @"RecommendCell";

@interface RecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation RecommendViewController
#pragma mark - Life cycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
#pragma mark - Private method 私有方法
- (void)setupUI{
    self.navigationItem.title = @"推荐";
    
    [self.tableView registerClass:[RecommendCell class] forCellReuseIdentifier:RecommendCellIdentifier];
    [self.tableView.mj_header beginRefreshing];
}
#pragma mark - Interface 接口

- (void)loadNewData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *jsonArray = dict[@"feed"];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [self.dataArray addObject:[RecommendModel mj_objectWithKeyValues:obj]];
            
        }];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    });
}
#pragma mark - Event response 事件
#pragma mark - Delegate 代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.tableView fd_heightForCellWithIdentifier:RecommendCellIdentifier cacheByIndexPath:indexPath configuration:^(RecommendCell *cell) {
        cell.recommendModel = [self.dataArray objectAtIndex:indexPath.row];
    }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:RecommendCellIdentifier];
    cell.recommendModel = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self pushVc:[[RecommendDetailViewController alloc] init]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
}
#pragma mark - Getters and Setters
- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_BAR_H) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self loadNewData];
        }];
    }
    return _tableView;
}
@end
