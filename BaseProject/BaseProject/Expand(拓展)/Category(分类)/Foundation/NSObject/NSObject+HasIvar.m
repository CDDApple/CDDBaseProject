//
//  NSObject+HasIvar.m
//  shangke
//
//  Created by 曹冬冬 on 16/3/1.
//  Copyright © 2016年 YG. All rights reserved.
//

#import "NSObject+HasIvar.h"

@implementation NSObject (HasIvar)

+ (BOOL)hasIvarNamed:(NSString *)ivarName {
    
    BOOL hasKey = NO;
    
    unsigned int numIvars; // 成员变量个数
    Ivar *vars = class_copyIvarList([self class], &numIvars);
    NSString *key = nil;
    for(int i = 0; i < numIvars; i++) {
        Ivar thisIvar = vars[i];
        key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];  // 获取成员变量的名字
        if ([key isEqualToString:ivarName]) {
            hasKey = YES;
            break;
        }
//        key = [NSString stringWithUTF8String:ivar_getTypeEncoding(thisIvar)]; //获取成员变量的数据类型
    }
    free(vars);
    return hasKey;
}

@end
