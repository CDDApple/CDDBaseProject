//
//  DiscoverHotCell.h
//  BaseProject
//
//  Created by 曹冬冬 on 16/11/2.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import "CDDBaseTableViewCell.h"
#import "DiscoverModel.h"

typedef void (^cellItemClickBlock) (Body * body);
typedef void (^goRankClickBlock) ();
typedef void (^goMoreClickBlock) ();

@interface DiscoverHotCell : CDDBaseTableViewCell

@property(nonatomic,assign) CGFloat viewWidth;
@property(nonatomic,assign) CGFloat viewHeight;
@property(nonatomic,assign) CGFloat cellHeight;

@property (nonatomic, strong) DiscoverModel *discoverModel;
@property (nonatomic, strong) NSMutableArray *body;

@property(nonatomic,copy) cellItemClickBlock block;
@property(nonatomic,copy) goRankClickBlock goRankBlock;
@property(nonatomic,copy) goMoreClickBlock goMoreBlock;


+ (instancetype)cellWithTableview:(UITableView *)tableview;
-(void)cellClickWithBlock:(cellItemClickBlock)block;
-(void)goRankBlockWithBlock:(goRankClickBlock)block;
-(void)goMoreBlockWithBlock:(goMoreClickBlock)block;
@end
