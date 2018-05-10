//
//  DiscoverHotTopicCell.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/11/2.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import "DiscoverHotTopicCell.h"
#import "DiscoverTopTitleView.h"
#import "DiscoverBottomToolView.h"
#import "DiscoverTopicListView.h"

static NSString *identifier = @"DiscoverHotTopicCell";

@interface DiscoverHotTopicCell()
@property (nonatomic, weak) DiscoverTopTitleView *topTitleView;
@property(nonatomic,copy) NSMutableArray * dataArray;
@end

@implementation DiscoverHotTopicCell

+ (instancetype)cellWithTableview:(UITableView *)tableview{
    DiscoverHotTopicCell *cell = [tableview dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[DiscoverHotTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    CALayer * topLayer = [CALayer layer];
    topLayer.backgroundColor = RGB(244, 244, 244).CGColor;
    [self.contentView.layer addSublayer:topLayer];
    topLayer.size = CGSizeMake(kScreenWidth, 15);
    
    // 标题
    DiscoverTopTitleView *topTitleView = [[DiscoverTopTitleView alloc] init];
    topTitleView.isHiddenRankBtn = YES;
    topTitleView.backgroundColor = RANDOM_COLOR;
    [self.contentView addSubview:topTitleView];
    [topTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(kLineToTopTitleMargin+kLineHeight);
        make.left.right.equalTo(self.contentView);
        make.height.mas_offset(kTopTitleHeight);
    }];
    self.topTitleView = topTitleView;

    // 工具条
    DiscoverBottomToolView *bottomToolView = [[DiscoverBottomToolView alloc] init];
    bottomToolView.backgroundColor = RANDOM_COLOR;
    [self.contentView addSubview:bottomToolView];
    [bottomToolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.mas_offset(kBottomToolHeight);
    }];
    
    bottomToolView.goMoreBlock = ^{
        if(self.goMoreBlock){
            self.goMoreBlock();
        }
    };
    
}

- (void)contentViewClick:(UITapGestureRecognizer *)tap{
    DiscoverTopTitleView *imageView = (DiscoverTopTitleView *)tap.view;
    if (self.block && imageView.tag < self.body.count) {
        self.block(self.body[imageView.tag]);
    }
}

-(void)cellClickWithBlock:(cellItemClickBlock)block{
    self.block = block;
}

- (void)goMoreBlockWithBlock:(goMoreClickBlock)block{
    self.goMoreBlock = block;
}

- (void)setDiscoverModel:(DiscoverModel *)discoverModel{
    _discoverModel = discoverModel;
    
    self.topTitleView.title.text = discoverModel.title;
}

- (void)setBody:(NSMutableArray *)body{
    _body = body;
    
    if (body && body.count>0) {
        for (int i=0; i<body.count; i++) {
            DiscoverTopicListView *listView = self.dataArray[i];
            Body *bodys = body[i];
            listView.dataBody = bodys;
        }
    }
}
- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [NSMutableArray array];
        for (NSInteger i = 0; i<4; i++) {
            CGFloat row = i/2;
            CGFloat col = i%2;
            
            DiscoverTopicListView *contentView = [[DiscoverTopicListView alloc] init];
            contentView.backgroundColor = RANDOM_COLOR;
            contentView.tag = i;
            [self.contentView addSubview:contentView];
            [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.topTitleView.mas_bottom).with.offset(row*self.viewHeight);
                make.left.equalTo(self.contentView).with.offset(10 + (self.viewWidth + 10) * col);
                make.width.mas_offset(self.viewWidth);
                make.height.mas_offset(self.viewHeight);
            }];
            [_dataArray addObject:contentView];
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewClick:)];
            [contentView addGestureRecognizer:tap];
        }
    }
    return _dataArray;
}
-(CGFloat)viewWidth{
    return (SCREEN_WIDTH - (10 * 3)) / 2;
}

-(CGFloat)viewHeight{
    return kTopicImageTopMargin + kTopicImageHeight;
}

@end
