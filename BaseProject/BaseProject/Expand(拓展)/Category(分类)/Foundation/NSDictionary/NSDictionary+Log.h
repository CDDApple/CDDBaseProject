//
//  NSDictionary+Log.h
//  CDDBaseProject
//
//  Created by 曹冬冬 on 16/1/29.
//  Copyright © 2016年 CDD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Log)
/**
 *  打印的值是一个字典
 */
-(NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level;

/**
 属性代码
 */
- (void)propertyCode;
@end
