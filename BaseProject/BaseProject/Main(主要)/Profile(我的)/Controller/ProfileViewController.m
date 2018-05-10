//
//  ProfileViewController.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/7/7.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//  我的控制器

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController
#pragma mark - Life cycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}
#pragma mark - Private method 私有方法
- (void)setupUI{
    self.navigationItem.title = @"我的";
    
}
#pragma mark - Interface 接口
#pragma mark - Event response 事件
#pragma mark - Delegate 代理
#pragma mark - Getters and Setters

@end
