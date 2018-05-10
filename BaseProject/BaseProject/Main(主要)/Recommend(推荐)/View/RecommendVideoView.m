//
//  RecommendVideoView.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/9/2.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import "RecommendVideoView.h"

@interface RecommendVideoView()
@property (nonatomic, strong) UIImageView *videoImage;
@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UIButton *playVideoBtn;
@property (nonatomic, strong) UILabel *timeLable;
@end

@implementation RecommendVideoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self setupViewAtuoLayout];
        [self setModel];
    }
    return self;
}


-(void)setupUI{
    // 视频封面
    self.videoImage = [[UIImageView alloc] init];
    self.videoImage.backgroundColor = RANDOM_COLOR;
    [self addSubview:self.videoImage];
    
    self.avatar = [[UIImageView alloc] init];
    self.avatar.layer.cornerRadius = 5;
    self.avatar.layer.masksToBounds = YES;
    self.avatar.backgroundColor = RANDOM_COLOR;
    [self.videoImage addSubview:self.avatar];
    
    self.name = [[UILabel alloc] init];
    self.name.textAlignment = NSTextAlignmentCenter;
    self.name.backgroundColor = RGBA(0, 0, 0, 0.6);
    self.name.font = S_FONT(15);
    self.name.textColor = [UIColor whiteColor];
    [self.videoImage addSubview:self.name];
    
    self.playVideoBtn = [[UIButton alloc] init];
    self.playVideoBtn.backgroundColor = RANDOM_COLOR;
    [self.videoImage addSubview:self.playVideoBtn];
    
    self.timeLable = [[UILabel alloc] init];
    self.timeLable.textAlignment = NSTextAlignmentCenter;
    self.timeLable.layer.borderColor = [UIColor whiteColor].CGColor;
    self.timeLable.layer.borderWidth = 0.25;
    self.timeLable.backgroundColor = RGBA(0, 0, 0, 0.6);
    self.timeLable.font = S_FONT(12);
    self.timeLable.textColor = [UIColor whiteColor];
    [self.videoImage addSubview:self.timeLable];
}

- (void)setupViewAtuoLayout{
    // 视频封面
    [self.videoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.height.equalTo(@200);
        make.bottom.equalTo(@(0));
    }];
    
    // 头像
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(@15);
        make.width.height.equalTo(@30);
    }];
    
    // 名字
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.avatar);
        make.left.equalTo(self.avatar.mas_right).with.offset(0);
        make.height.equalTo(@20);
    }];
    
    // 播放按钮
    [self.playVideoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.mas_offset(60);
    }];
    
    // 时长
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self).with.offset(-5);
        make.height.equalTo(@18);
    }];
}

- (void)setModel{
    self.name.text = @"梦想开始室";
    [self.name sizeToFit];
    self.name.width += 20;
    CGRect nameBounds = CGRectMake(0, 0, self.name.width, 20);
    [self.name mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(self.name.width);
    }];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:nameBounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = nameBounds;
    maskLayer.path = maskPath.CGPath;
    self.name.layer.mask  = maskLayer;
    
    
    self.timeLable.text = @"01:32:06";
    [self.timeLable sizeToFit];
    self.timeLable.width += 10;
    [self.timeLable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(self.timeLable.width);
    }];
}
@end
