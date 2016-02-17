//
//  NetworkTool.m
//  RACDemo
//
//  Created by 郭玉富 on 16/1/26.
//  Copyright © 2016年 郭玉富. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YGNetworkMethod) {
    YGNetworkMethodGET = 0,
    YGNetworkMethodPOST,
};

#define baseUrl @"http://httpbin.org/"
#define YGErrorDomainName  @"cn.tianmabang.error.network"

#import "NetworkTool.h"

@implementation NetworkTool

+ (instancetype)sharedNetworkTool {
    
    static NetworkTool *instance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        NSURL *baseURL = [[NSURL alloc] initWithString:baseUrl];
        
        instance = [[self alloc] initWithBaseURL:baseURL sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        instance.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
    });
    return instance;
}

#pragma mark - RAC调用方法
/** *  获取名称 * */
- (RACSignal *)rac_getName:(NSMutableDictionary *)parameters {

    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [self getName:parameters success:^(NSDictionary *responseDict) {
            [subscriber sendNext:responseDict];
            [subscriber sendCompleted];
        } error:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }];
}

#pragma mark - 普通接口调用方法
/** *  获取名称 * */
- (void)getName:(NSMutableDictionary *)parameters success:(SuccessBlock)successBlock error:(ErrorBlock)errorBlock {
    [self requestMethod:YGNetworkMethodGET urlString:@"get" params:parameters success:successBlock error:errorBlock];
}

#pragma mark - 封装的统一访问方法
- (void)requestMethod:(YGNetworkMethod)method urlString:(NSString *)UrlString params:(NSMutableDictionary *)parameters success:(SuccessBlock)successBlock error:(ErrorBlock)errorBlock {
    
    // 成功请求的Block
    void (^success)(NSURLSessionDataTask *task, id responseObject) = ^ (NSURLSessionDataTask *task, id responseObject){
        if ([responseObject isKindOfClass:[NSDictionary class]] && (responseObject!= nil)) {
            
            NSLog(@"正常返回数据");
            NSInteger status = [responseObject[@"status"] integerValue];
            
            // 不要把所有的错误都在这拦截了，只拦截-1，scode过期
            if( -1 == status) {
                // 如果当前导航控制器堆栈中有登陆控制器则返回
                return;
            }
            
            if (successBlock) {
                successBlock(responseObject);
            }
        } else {
            NSLog(@"网络单例请求到空数据");
            NSError *error = [[NSError alloc] initWithDomain:YGErrorDomainName code:-1 userInfo:[NSDictionary dictionaryWithObject:@"空数据" forKey:YGErrorDomainName]];
            if (errorBlock) {
                errorBlock(error);
            }
        }
        
    };
    
    // 失败的Block
    void(^failed)(NSURLSessionDataTask *task, NSError *error) = ^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"网络单例未能请求到数据，请求返回错误");
        if (errorBlock) {
            errorBlock(error);
        }
    };
    
    // 公共参数
    if (parameters == nil) {
        parameters = [NSMutableDictionary dictionary];
    }
//    [parameters setValue:@"" forKey:""];

    switch (method) {
        case YGNetworkMethodGET:
            [self GET:UrlString parameters:parameters progress:nil success:success failure:failed];
            break;
        case YGNetworkMethodPOST:
            [self POST:UrlString parameters:parameters progress:nil success:success failure:failed];
            break;
        default:
            break;
    }
    
}

@end
