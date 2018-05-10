//
//  DiscoverModel.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/11/2.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import "DiscoverModel.h"



@implementation DiscoverModel
+ (NSDictionary *)objectClassInArray{
    return @{@"body" : [Body class]};
}

- (CGFloat)cellHeight{

    CGFloat imageW = (SCREEN_WIDTH - 3 * 10) / 2;
    CGFloat imageH = imageW * 9 / 16;
    CGFloat height = kLineHeight + kLineToTopTitleMargin + kTopTitleHeight + kBottomToolHeight;
    
    switch ([self.type integerValue]) {
        case 0:
        case 1:
            height += (kImageTopMargin + imageH + kImageToTitleMargin + kTitleFont + kTitleToTagMargin + kTagHeight) * 2;
            break;
        case 2:
        case 3:
            height += (kTopicImageTopMargin + kTopicImageHeight) * 2;
            break;
        default:
            break;
    }
    return height;
}

@end

@implementation Body

@end
