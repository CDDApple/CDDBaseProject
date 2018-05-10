//
//  DiscoverTopTitleView.h
//  BaseProject
//
//  Created by 曹冬冬 on 16/11/2.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverModel.h"

typedef void (^goRankClickBlock)();

@interface DiscoverTopTitleView : UIView

@property (nonatomic, strong) UILabel *title;

@property (nonatomic, strong) DiscoverModel *discoverModel;

@property(nonatomic,copy) goRankClickBlock goRankBlock;

@property (nonatomic, assign) BOOL isHiddenRankBtn;

@end
