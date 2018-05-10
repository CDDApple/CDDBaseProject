//
//  NSNotificationCenter+Extension.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/9/18.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import "NSNotificationCenter+Extension.h"

@implementation NSNotificationCenter (Extension)

+ (void)postNotification:(NSString *)notiname {
    [[NSNotificationCenter defaultCenter] postNotificationName:notiname object:nil];
}

+ (void)postNotification:(NSString *)notiname object:(id)object {
    if (object == nil) {
        [self postNotification:notiname];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:notiname object:object userInfo:nil];
    }
}

+ (void)removeAllObserverForObj:(id)obj {
    [[NSNotificationCenter defaultCenter] removeObserver:obj];
}

+ (void)addObserver:(id)observer action:(SEL)action name:(NSString *)name {
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:action name:name object:nil];
}

@end
