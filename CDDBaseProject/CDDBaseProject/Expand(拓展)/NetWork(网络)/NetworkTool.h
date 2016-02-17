//
//  NetworkTool.h
//  RACDemo
//
//  Created by 郭玉富 on 16/1/26.
//  Copyright © 2016年 郭玉富. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
//#import "NSArray+Log.h"
@import ReactiveCocoa;


typedef void(^SuccessBlock)(NSDictionary *responseDict);
typedef void(^ErrorBlock)(NSError *error);


#define YGNetworkTool [NetworkTool sharedNetworkTool]


@interface NetworkTool : AFHTTPSessionManager

+ (instancetype)sharedNetworkTool;

#pragma mark - RAC方法
/** *  获取名称 * */
- (RACSignal *)rac_getName:(NSMutableDictionary *)parameters;

#pragma mark - 普通方法
/** *  获取名称 * */
- (void)getName:(NSMutableDictionary *)parameters success:(SuccessBlock)successBlock error:(ErrorBlock)errorBlock;

@end
