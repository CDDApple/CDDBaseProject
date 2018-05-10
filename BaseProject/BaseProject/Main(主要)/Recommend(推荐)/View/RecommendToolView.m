//
//  RecommendToolView.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/9/2.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import "RecommendToolView.h"

@interface RecommendToolView()
@property (strong, nonatomic) UIButton *likeBtn;
@end

@implementation RecommendToolView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
        self.backgroundColor = RANDOM_COLOR;
    }
    return self;
}
-(void)createUI{
    
    self.likeBtn = [[UIButton alloc] init];
    [self.likeBtn setTitle:@"工具" forState:UIControlStateNormal];
    self.likeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.likeBtn];
    
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.width.mas_equalTo(@100);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

-(void)setViewAtuoLayout{
    
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.width.mas_equalTo(@13);
        make.bottom.equalTo(self.mas_bottom);
        
    }];
}
@end
