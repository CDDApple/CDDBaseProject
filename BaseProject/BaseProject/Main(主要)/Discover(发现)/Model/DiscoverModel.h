//
//  DiscoverModel.h
//  BaseProject
//
//  Created by 曹冬冬 on 16/11/2.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 分隔线高度 */
#define kLineHeight 15
/** 分隔线到标题的间距 */
#define kLineToTopTitleMargin 15
/** 标题的高度 */
#define kTopTitleHeight 25

/** 图片到标题的间距 */
#define kImageTopMargin 15
/** 图片到名称的间距 */
#define kImageToTitleMargin 10
/** 名称的字体大小 */
#define kTitleFont 14
/** 名称到标签的间距 */
#define kTitleToTagMargin 10
/** 标签的高度 */
#define kTagHeight 10

/** 工具条高度 */
#define kBottomToolHeight 55

/******专题******/
/** 专题图片到标题的间距 */
#define kTopicImageTopMargin 15
/** 专题图片的高度 */
#define kTopicImageHeight 70


@class Body;
@interface DiscoverModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSMutableArray<Body *> *body;
@property (nonatomic, assign) CGFloat cellHeight;

@end

@interface Body : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *tag;

@end
