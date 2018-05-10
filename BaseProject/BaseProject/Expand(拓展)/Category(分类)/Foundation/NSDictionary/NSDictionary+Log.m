//
//  NSDictionary+Log.m
//  CDDBaseProject
//
//  Created by 曹冬冬 on 16/1/29.
//  Copyright © 2016年 CDD. All rights reserved.
//

#import "NSDictionary+Log.h"

@implementation NSDictionary (Log)

-(NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    //初始化可变字符串
    NSMutableString *string = [NSMutableString string];
    //拼接开头[
    [string appendString:@"["];
    
    //拼接字典中所有的键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [string appendFormat:@"%@:",key];
        [string appendFormat:@"%@",obj];
    }];
    
    //拼接结尾]
    [string appendString:@"]"];
    
    return string;
}

- (void)propertyCode {
    
    // 属性跟字典的key一一对应
    NSMutableString *codes = [NSMutableString string];
    // 遍历字典中所有key取出来
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        // key:属性名
        NSString *code;
        if ([obj isKindOfClass:[NSString class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;",key];
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;",key];
        }else if ([obj isKindOfClass:[NSNumber class]]){
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) NSInteger %@;",key];
        }else if ([obj isKindOfClass:[NSArray class]]){
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@;",key];
            NSLog(@"----%@列表", key);
            for (NSDictionary *dict in obj) {
                if ([dict isKindOfClass:[NSDictionary class]]) {
                    [dict propertyCode];
                }
            }NSLog(@"----%@列表", key);
        }else if ([obj isKindOfClass:[NSDictionary class]]){
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@;",key];
            [(NSDictionary *)obj propertyCode];
        }
        [codes appendFormat:@"%@\n",code];
        
    }];
    NSLog(@"%@", codes);
}
@end
