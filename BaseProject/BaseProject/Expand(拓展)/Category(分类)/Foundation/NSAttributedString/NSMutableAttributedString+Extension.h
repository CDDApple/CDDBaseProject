//
//  NSMutableAttributedString+Extension.h
//  shangke
//
//  Created by 曹冬冬 on 16/3/23.
//  Copyright © 2016年 YG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (Extension)

/**
 指定行高的内容

 @param content   内容
 @param lineSpace 行高

 @return 指定行高的内容

 */
+ (NSMutableAttributedString *)attributedString:(NSString *)content lineSpace:(CGFloat)lineSpace;
@end
