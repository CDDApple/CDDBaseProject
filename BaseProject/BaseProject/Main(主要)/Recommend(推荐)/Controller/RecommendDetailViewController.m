//
//  RecommendDetailViewController.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/9/5.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import "RecommendDetailViewController.h"

@interface RecommendDetailViewController ()

@end

@implementation RecommendDetailViewController

#pragma mark - Life cycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"表单键盘遮挡验证";
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    for (NSInteger i = 0; i<8; i++) {
        UITextField *textField = [[UITextField alloc] init];
        [textField setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
        textField.placeholder = [NSString stringWithFormat:@"文本框%zd", i];
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.returnKeyType = UIReturnKeyDone;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
        [scrollView addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(scrollView);
            make.top.mas_offset(80.0f * i + 20);
            make.height.mas_offset(40);
        }];
    }
    
}
#pragma mark - Private method 私有方法
#pragma mark - Interface 接口
#pragma mark - Event response 事件
#pragma mark - Delegate 代理
#pragma mark - Getters and Setters

@end
