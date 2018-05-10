//
//  NSObject+HasIvar.h
//  shangke
//
//  Created by 曹冬冬 on 16/3/1.
//  Copyright © 2016年 YG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HasIvar)

+ (BOOL)hasIvarNamed:(NSString *)ivarName;

@end
