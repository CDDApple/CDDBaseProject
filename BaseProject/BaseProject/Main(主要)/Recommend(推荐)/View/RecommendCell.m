//
//  RecommendCell.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/9/2.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import "RecommendCell.h"
#import "RecommendVideoView.h"
#import "RecommendContentView.h"
#import "RecommendToolView.h"

@interface RecommendCell()
@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) RecommendVideoView *recommendVideoView;
@property (nonatomic, strong) RecommendContentView *recommendContentView;
@property (nonatomic, strong) RecommendToolView *recommendToolView;

@end
@implementation RecommendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor = RGBA(0, 0, 0, 0.6);
        self.backgroundColor = [UIColor whiteColor];
        [self setupView];
        [self setViewAtuoLayout];
    }
    return self;
}

- (void)setupView{
    CALayer * topLayer = [CALayer layer];
    topLayer.backgroundColor = RGB(244, 244, 244).CGColor;
    [self.contentView.layer addSublayer:topLayer];
    topLayer.size = CGSizeMake(kScreenWidth, CGFloatFromPixel(30));
    
    self.bgView = [[UIView alloc]init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bgView];

    /** 视频区域 */
    self.recommendVideoView =[[RecommendVideoView alloc]init];
    [self.bgView addSubview:self.recommendVideoView];
    

    /** 内容区域 */
    self.recommendContentView =[[RecommendContentView alloc]init];
    [self.bgView addSubview:self.recommendContentView];


    /** 工具区域 */
    self.recommendToolView =[[RecommendToolView alloc]init];
    [self.bgView addSubview:self.recommendToolView];

}
- (void)setViewAtuoLayout{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(CGFloatFromPixel(30));
        make.left.equalTo(@10);
        make.right.equalTo(@(-10));
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
    }];
    
    [self.recommendVideoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.bottom.equalTo(self.recommendVideoView.mas_bottom);
    }];
    
    [self.recommendContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.recommendVideoView.mas_bottom).with.offset(0);
        make.left.equalTo(@0);
        make.right.equalTo(@(0));
        make.bottom.equalTo(self.recommendToolView.mas_top);
    }];
    
    [self.recommendToolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.recommendContentView.mas_bottom).with.offset(0);
        make.left.equalTo(@0);
        make.right.equalTo(@(0));
        make.bottom.equalTo(self.bgView.mas_bottom);
    }];
}

- (void)setRecommendModel:(RecommendModel *)recommendModel{
    _recommendModel = recommendModel;
    
    self.recommendContentView.recommendModel = recommendModel;
}
@end
