//
//  NSMutableAttributedString+Extension.m
//  shangke
//
//  Created by 曹冬冬 on 16/3/23.
//  Copyright © 2016年 YG. All rights reserved.
//

#import "NSMutableAttributedString+Extension.h"
#import "NSString+Extension.h"

@implementation NSMutableAttributedString (Extension)
+ (NSMutableAttributedString *)attributedString:(NSString *)content lineSpace:(CGFloat)lineSpace
{
    if([NSString isEmptyOrNull:content]){
        return nil;
    }
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content length])];
    return attributedString;
}
@end
