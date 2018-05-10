//
//  WelcomeViewController.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/7/7.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()
@property (nonatomic, strong) UIButton *experienceBtn;
@end

@implementation WelcomeViewController
#pragma mark - Life cycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.experienceBtn];
    [self.experienceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.right.equalTo(@-40);
        make.bottom.equalTo(@-60);
        make.height.equalTo(@40);
    }];
}
#pragma mark - Private method 私有方法
#pragma mark - Interface 接口
#pragma mark - Event response 事件
- (void)experienceBtnClick{
    [[NSNotificationCenter defaultCenter] postNotificationName:kSKRootViewControllerSwitchNotification object:nil];
}
#pragma mark - Delegate 代理
#pragma mark - Getters and Setters
- (UIButton *)experienceBtn
{
    if (!_experienceBtn) {
        _experienceBtn = [[UIButton alloc] init];
        _experienceBtn.backgroundColor = [UIColor yellowColor];
        [_experienceBtn setTitle:@"立即体验" forState:UIControlStateNormal];
        [_experienceBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
        [_experienceBtn addTarget:self action:@selector(experienceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _experienceBtn;
}
@end
