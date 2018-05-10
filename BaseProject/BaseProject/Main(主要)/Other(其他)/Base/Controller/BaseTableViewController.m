//
//  BaseTableViewController.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/10/28.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

/**
 *  加载tableview
 */
- (CDDBaseTableView *)tableView {
    if(!_tableView){
        CDDBaseTableView *tab = [[CDDBaseTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self.view addSubview:tab];
        _tableView = tab;
        tab.dataSource = self;
        tab.delegate = self;
        tab.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
        tab.separatorColor = RANDOM_COLOR;
    }
    return _tableView;
}

@end
