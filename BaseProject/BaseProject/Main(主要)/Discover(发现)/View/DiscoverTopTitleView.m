//
//  DiscoverTopTitleView.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/11/2.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import "DiscoverTopTitleView.h"

@interface DiscoverTopTitleView()
@property (nonatomic, weak) UIButton *rankBtn;
@end

@implementation DiscoverTopTitleView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setupView];
    }
    return self;
}

- (void)setupView{
    UIView *leftView = [[UIView alloc] init];
    leftView.backgroundColor = RANDOM_COLOR;
    [self addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self);
        make.width.mas_offset(5);
    }];

    UILabel *title = [[UILabel alloc] init];
    title.font = S_FONT(16);
    title.backgroundColor = RANDOM_COLOR;
    [self addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(leftView);
        make.left.equalTo(leftView.mas_right).with.offset(10);
    }];
    self.title = title;

    UIButton *rankBtn = [[UIButton alloc] init];
    [rankBtn setTitle:@"排行榜>>" forState:UIControlStateNormal];
    rankBtn.titleLabel.font = S_FONT(14);
    rankBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    rankBtn.backgroundColor = RANDOM_COLOR;
    [rankBtn addTarget:self action:@selector(rankClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rankBtn];
    [rankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(leftView);
        make.right.equalTo(self).with.offset(-15);
    }];
    self.rankBtn = rankBtn;
}

- (void)rankClick{
    if (self.goRankBlock) {
        self.goRankBlock();
    }
}

-(void)setIsHiddenRankBtn:(BOOL)isHiddenRankBtn{
    _isHiddenRankBtn = isHiddenRankBtn;
    
    self.rankBtn.hidden = isHiddenRankBtn;
}

@end
