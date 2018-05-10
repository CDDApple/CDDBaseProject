//
//  NSString+Extension.h
//  shangke
//
//  Created by 曹冬冬 on 16/3/1.
//  Copyright © 2016年 YG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
- (BOOL)isEmpty;
/**
 *  为空(nil)的验证
 */
+ (BOOL)isEmptyOrNull:(NSString *)string;
/**
 *  手机号验证
 */
+ (BOOL)isPhoneNum:(NSString *)phoneNum;
- (BOOL)checkPWD;
- (BOOL)checkUserName;

/**
 *  处理阅读数
 */
- (NSString *)readCountString;

/**
 *  不进行四舍五入
 */
+(NSString *)notRounding:(NSString *)price afterPoint:(int)position;
/**
 *  document目录后面
 */
- (NSString *)documentDirectory;
/**
 *  caches目录后面
 */
- (NSString *)cachesDirectory;
/**
 *  temp目录后面
 */
- (NSString *)temporaryDirectory;
@end
