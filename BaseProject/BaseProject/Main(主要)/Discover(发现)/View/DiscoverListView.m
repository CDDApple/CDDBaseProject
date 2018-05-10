//
//  DiscoverListView.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/11/8.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import "DiscoverListView.h"

@interface DiscoverListView()
@property (nonatomic, weak) UIImageView *image;
@property (nonatomic, weak) UILabel *title;
@property (nonatomic, weak) UILabel *titleTag;
@end

@implementation DiscoverListView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setupView];
    }
    return self;
}

- (void)setupView{
    
    UIImageView *image = [[UIImageView alloc] init];
    image.backgroundColor = RANDOM_COLOR;
    [self addSubview:image];
    self.image = image;
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"蓝色情人节";
    title.font = S_FONT(kTitleFont);
    title.backgroundColor = RANDOM_COLOR;
    [self addSubview:title];
    self.title = title;
    
    UILabel *titleTag = [[UILabel alloc] init];
    titleTag.text = @"动漫 | 搞笑  点击:3000";
    titleTag.backgroundColor = RANDOM_COLOR;
    titleTag.font = S_FONT(kTagHeight);
    [self addSubview:titleTag];
    self.titleTag = titleTag;

    [titleTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.right.equalTo(self);
        make.height.mas_offset(kTagHeight);
    }];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(titleTag.mas_top).with.offset(-kTitleToTagMargin);
        make.left.right.equalTo(self);
        make.height.mas_offset(kTitleFont);
    }];

    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(kImageTopMargin);
        make.left.right.equalTo(self);
        make.bottom.equalTo(title.mas_top).with.offset(-kImageToTitleMargin);
    }];
}
- (void)setDataBody:(Body *)dataBody{
    _dataBody = dataBody;
    
    self.title.text = dataBody.title;
    self.titleTag.text = dataBody.tag;
    [self.image sd_setImageWithURL:[NSURL URLWithString:dataBody.image]];
}
@end
