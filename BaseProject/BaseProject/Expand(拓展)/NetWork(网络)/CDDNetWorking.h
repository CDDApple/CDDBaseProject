//
//  CDDNetWorking.h
//  BaseProject
//
//  Created by 曹冬冬 on 16/7/8.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "APIConstant.h"

#define CDDNetWorkingManager [CDDNetWorking shareManager]

typedef NS_ENUM(NSUInteger, NetworkStates) {
    NetworkStatesNone,  // 没有网络
    NetworkStates2G,    // 2G
    NetworkStates3G,    // 3G
    NetworkStates4G,    // 4G
    NetworkStatesWIFI   // WIFI
};
typedef NS_ENUM(NSUInteger, HTTPClientRequestCachePolicy){
    HTTPClientReturnCacheDataThenLoad = 0,  // 有缓存就先返回缓存，同步请求数据
    HTTPClientReloadIgnoringLocalCacheData, // 忽略缓存，重新请求
    HTTPClientReturnCacheDataElseLoad,      // 有缓存就用缓存，没有缓存就重新请求(用于数据不变时)
    HTTPClientReturnCacheDataDontLoad,      // 有缓存就用缓存，没有缓存就不发请求，当做请求出错处理（用于离线模式）
};
typedef NS_ENUM(NSInteger, RequestMethodType){
    RequestMethodTypePost = 0,  // POST请求
    RequestMethodTypeGet,       // GET请求
    RequestMethodTypePut,       // PUT请求
    RequestMethodTypePatch,       // PUT请求
    RequestMethodTypeDelete     // Delete请求
};

/**
 *  HTTP访问回调
 *
 *  @param urlString 状态码 0 访问失败   200 正常  500 空 其他异常
 *  @param result    返回数据 nil 为空
 *  @param error     错误描述
 */
typedef void(^ResultBlock)(NSString *stateCode, NSDictionary *result, NSError *error);

@interface CDDNetWorking : AFHTTPSessionManager

/**
 *  单例
 *
 *  @return 请求
 */
+ (instancetype)shareManager;

/**
 *  POST请求
 *
 *  @param url     API地址
 *  @param params  参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
- (void)POST:(NSString *)url params:(NSDictionary *)params result:(ResultBlock)requestBlock;

/**
 *  是否连接网络
 * */
- (BOOL)isReachable;

/**
 *  获取网络状态
 *
 *  @return 网络状态
 */
+ (NetworkStates)getNetworkStates;
@end
