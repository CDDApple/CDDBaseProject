//
//  CDDNetWorking.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/7/8.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import "CDDNetWorking.h"
#import "ResponseModel.h"

@implementation CDDNetWorking


+ (instancetype)shareManager
{
    static CDDNetWorking *_manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        _manager.requestSerializer.timeoutInterval = 5.f;
        //申明返回的结果是json类型
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //申明请求的数据是json类型
        _manager.requestSerializer=[AFJSONRequestSerializer serializer];
        //如果报接受类型不一致请替换一致text/html或别的
        _manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
        
    });
    return _manager;
}

- (void)POST:(NSString *)url params:(NSDictionary *)params result:(ResultBlock)requestBlock{
    // 有网络
    if (self.isReachable) {
        // 拼接请求地址
        NSString *urlString = [NSString stringWithFormat:@"%@%@", BaseUrl, url];
        
        [self POST:urlString parameters:[self appendCommonParms:params] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (requestBlock) {
                ResponseModel *responseModel = [ResponseModel mj_objectWithKeyValues:responseObject];
                requestBlock(responseModel.response_head.response_code, responseModel.response_body,nil);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (requestBlock) {
                requestBlock(0,nil,error);
            }
        }];
    }
    else{
        if (requestBlock) {
            requestBlock(0,nil,nil);
        }
    }
}

#pragma mark - 网络请求的类方法 --- get / post / put / delete




/**
 *   拼接请求参数
 */
- (NSDictionary *)appendCommonParms:(NSDictionary *)params{
    
    NSString *access_token = @"";
    NSString *device_code = @"123123123"; //[NSKeyedUnarchiver unarchiveObjectWithFile:DevicecCodePath];
    
    NSMutableDictionary *requestHeadParame = [NSMutableDictionary dictionary];
    [requestHeadParame setObject:[self uuidString] forKey:@"request_id"];             // 由app生成唯一的请求ID
    [requestHeadParame setObject:access_token forKey:@"access_token"];  //用户认证的token，登录后不能为空
    [requestHeadParame setObject:device_code forKey:@"device_code"];    //设备标识码，用户安装app后生成唯一标识码
    [requestHeadParame setObject:[NSString stringWithFormat:@"ios%@", @"2.4.0"] forKey:@"version"];  //app版本信息   android1.1或者ios1.1等
    [requestHeadParame setObject:[self getCurrentTime] forKey:@"request_time"];           //客户端请求发起时间yyyyMMddHHmmss
    
    NSMutableDictionary *requestParame = [NSMutableDictionary dictionary];
    [requestParame setObject:requestHeadParame forKey:@"request_head"];
    if(params){
        [requestParame setObject:params forKey:@"request_body"];
    }
    
    return requestParame;
}

- (NSString *)uuidString
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}

- (NSString *)getCurrentTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMDDHHmmss"];
    return [formatter stringFromDate:[NSDate date]];
}

/**
 *   取消所有正在执行的网络请求项
 */
- (void)cancelAllNetworkingRequest{
    
}
/**
 *   是否连接网络
 */
- (BOOL)isReachable{
    return [CDDNetWorking getNetworkStates] != NetworkStatesNone;
}

/**
 *   判断网络类型
 */
+ (NetworkStates)getNetworkStates{
    
    NSArray *subviews = [[[[UIApplication sharedApplication] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    // 保存网络状态
    NetworkStates states = NetworkStatesNone;
    for (id child in subviews) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏码
            int networkType = [[child valueForKeyPath:@"dataNetworkType"] intValue];
            switch (networkType) {
                case 0:
                    states = NetworkStatesNone;
                    break;
                case 1:
                    states = NetworkStates2G;
                    break;
                case 2:
                    states = NetworkStates3G;
                    break;
                case 3:
                    states = NetworkStates4G;
                    break;
                case 5:
                    states = NetworkStatesWIFI;
                    break;
                default:
                    break;
            }
        }
    }
    //根据状态选择
    return states;
}



@end
