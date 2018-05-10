//
//  DiscoverBottomToolView.h
//  BaseProject
//
//  Created by 曹冬冬 on 16/11/9.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^goMoreClickBlock)();

@interface DiscoverBottomToolView : UIView

@property(nonatomic,copy) goMoreClickBlock goMoreBlock;

@end
