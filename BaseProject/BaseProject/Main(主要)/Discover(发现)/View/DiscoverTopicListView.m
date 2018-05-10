//
//  DiscoverTopicListView.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/11/9.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import "DiscoverTopicListView.h"

@interface DiscoverTopicListView()
@property (nonatomic, weak) UIImageView *image;
@property (nonatomic, weak) UILabel *title;

@property (nonatomic, weak) UILabel *topicTitle;
@property (nonatomic, weak) UILabel *topicSubtitle;
@property (nonatomic, weak) UILabel *followCount;
@end

@implementation DiscoverTopicListView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setupView];
    }
    return self;
}

- (void)setupView{
 
    UIImageView *image = [[UIImageView alloc] init];
    image.backgroundColor = RANDOM_COLOR;
    image.layer.cornerRadius = 3.0f;
    image.layer.masksToBounds = YES;
    [self addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(15);
        make.left.equalTo(self);
        make.width.height.mas_offset(70);
    }];
    self.image = image;
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"动漫";
    title.font = S_FONT(10);
    title.textAlignment = NSTextAlignmentCenter;
    title.backgroundColor = RANDOM_COLOR;
    [image addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(image);
        make.height.mas_offset(15);
    }];
    self.title = title;
    
    UIView *rightContentView = [[UIView alloc] init];
    rightContentView.backgroundColor = RANDOM_COLOR;
    [self addSubview:rightContentView];
    [rightContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(image);
        make.left.equalTo(image.mas_right).with.offset(15);
        make.right.equalTo(self);
    }];
    
    UILabel *topicTitle = [[UILabel alloc] init];
    topicTitle.text = @"梦想开始室";
    topicTitle.font = S_FONT(14);
    topicTitle.backgroundColor = RANDOM_COLOR;
    [rightContentView addSubview:topicTitle];
    [topicTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(rightContentView);
    }];
    self.topicTitle = topicTitle;
    
    UILabel *topicSubtitle = [[UILabel alloc] init];
    topicSubtitle.text = @"有梦想,才有动力";
    topicSubtitle.font = S_FONT(10);
    topicSubtitle.backgroundColor = RANDOM_COLOR;
    [rightContentView addSubview:topicSubtitle];
    [topicSubtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topicTitle.mas_bottom).with.offset(10);
        make.left.right.equalTo(rightContentView);
    }];
    self.topicSubtitle = topicSubtitle;
    
    UILabel *followCount = [[UILabel alloc] init];
    followCount.text = @"1236人关注";
    followCount.font = S_FONT(10);
    followCount.backgroundColor = RANDOM_COLOR;
    [rightContentView addSubview:followCount];
    [followCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topicSubtitle.mas_bottom).with.offset(15);
        make.left.right.equalTo(rightContentView);
    }];
    self.followCount = followCount;
    
    [rightContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(followCount.mas_bottom);
    }];
}

- (void)setDataBody:(Body *)dataBody{
    _dataBody = dataBody;
    
    self.title.text = dataBody.title;
    self.topicTitle.text = dataBody.tag;
    [self.image sd_setImageWithURL:[NSURL URLWithString:dataBody.image]];
}

@end
