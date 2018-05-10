//
//  NSString+Extension.m
//  shangke
//
//  Created by 曹冬冬 on 16/3/1.
//  Copyright © 2016年 YG. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
- (BOOL)checkUserName
{
    NSString *regex = @"^[a-zA-Z0-9_\u4e00-\u9fa5]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}
- (BOOL)isEmpty
{
    if (!self) {
        return true;
    } else {
        
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        NSString *trimedString = [self stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}
+ (BOOL)isEmptyOrNull:(NSString *)string{
    if (string == nil) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
// 说明：手机号仅验证11位数字，且以1开头
+ (BOOL)isPhoneNum:(NSString *)phoneNum{

    if ([self isEmptyOrNull:phoneNum]) return NO;
    if (phoneNum.length != 11) return NO;
    if (! [phoneNum hasPrefix:@"1"]) return NO;
    return YES;
}

- (BOOL)checkPWD{
    NSString *regex = @"^[^\\s]{6,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

/**
 *  不进行四舍五入
 */
+(NSString *)notRounding:(NSString *)price afterPoint:(int)position
{
    /*
     Mode的枚举类型
     NSRoundPlain, // 四舍五入
     NSRoundDown, // 只舍不入
     NSRoundUp, // 不舍只入
     NSRoundBankers //
     */
    
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *ouncesDecimal = [NSDecimalNumber decimalNumberWithString:price];
    
    
    NSDecimalNumber *roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

- (NSString *)readCountString
{
    CGFloat readCount = [self floatValue];
    
    if(readCount < 1000)
    {
        return self;
    }else if(readCount < 10000)
    {
        NSString *value = [NSString stringWithFormat:@"%f", readCount / 1000];
        return [NSString stringWithFormat:@"%@千", [NSString notRounding:value afterPoint:1]];
    }else
    {
        NSString *value = [NSString stringWithFormat:@"%f", readCount / 10000];
        return [NSString stringWithFormat:@"%@万", [NSString notRounding:value afterPoint:1]];
    }

}


- (NSString *)documentDirectory
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    return [path stringByAppendingPathComponent:self];
}
- (NSString *)cachesDirectory
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    return [path stringByAppendingPathComponent:self];
}
- (NSString *)temporaryDirectory
{
    NSString *path = NSTemporaryDirectory();
    return [path stringByAppendingPathComponent:self];
}
@end
