//
//  RecommendContentView.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/9/2.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import "RecommendContentView.h"
#import "RecommendModel.h"

@interface RecommendContentView()

@property (nonatomic, strong) UIImageView *icon;

@property (nonatomic, strong) UILabel *contentLabel;
@end

@implementation RecommendContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self setupViewAtuoLayout];
    }
    return self;
}


-(void)setupUI{
    // 图标
    self.icon = [[UIImageView alloc]init];
    [self addSubview:self.icon];
    
    //文字内容
    self.contentLabel = [[UILabel alloc]init];
    self.contentLabel.font = [UIFont systemFontOfSize:15];
    self.contentLabel.numberOfLines = 0;
    [self addSubview:self.contentLabel];
    
}

- (void)setupViewAtuoLayout{
    
    //文字内容
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
    }];
    
    //图片
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(self.contentLabel.mas_bottom).with.offset(5);
        make.bottom.equalTo(self.mas_bottom).with.offset(-5);
    }];
}

- (void)setRecommendModel:(RecommendModel *)recommendModel{
    _recommendModel = recommendModel;

    self.contentLabel.text = recommendModel.content;
}

@end
