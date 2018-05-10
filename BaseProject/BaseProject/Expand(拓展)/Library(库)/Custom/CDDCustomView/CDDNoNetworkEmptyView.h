//
//  CDDNoNetworkEmptyView.h
//  BaseProject
//
//  Created by 曹冬冬 on 16/10/28.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDDNoNetworkEmptyView : UIView
/** 没有网络，重试*/
@property (nonatomic, copy) void(^customNoNetworkEmptyViewDidClickRetryHandle)(CDDNoNetworkEmptyView *view);
@end
