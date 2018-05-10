//
//  DiscoverBottomToolView.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/11/9.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import "DiscoverBottomToolView.h"

@implementation DiscoverBottomToolView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setupView];
    }
    return self;
}

- (void)setupView{
    UIButton *more = [[UIButton alloc] init];
    [more setTitle:@"更多..." forState:UIControlStateNormal];
    more.titleLabel.font = S_FONT(15);
    more.titleLabel.textAlignment = NSTextAlignmentRight;
    more.backgroundColor = RANDOM_COLOR;
    [more addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:more];
    [more mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

}
- (void)moreClick{
    if (self.goMoreBlock) {
        self.goMoreBlock();
    }
}
@end
