//
//  DiscoverHotTopicCell.h
//  BaseProject
//
//  Created by 曹冬冬 on 16/11/2.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverModel.h"

typedef void (^cellItemClickBlock) (Body * body);
typedef void (^goRankClickBlock) ();
typedef void (^goMoreClickBlock) ();

@interface DiscoverHotTopicCell : UITableViewCell

@property (nonatomic, strong) DiscoverModel *discoverModel;
@property (nonatomic, strong) NSMutableArray *body;

@property(nonatomic,copy) cellItemClickBlock block;
@property(nonatomic,copy) goMoreClickBlock goMoreBlock;

+ (instancetype)cellWithTableview:(UITableView *)tableview;

-(void)cellClickWithBlock:(cellItemClickBlock)block;
-(void)goMoreBlockWithBlock:(goMoreClickBlock)block;

@end
