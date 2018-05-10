//
//  ResponseModel.h
//  BaseProject
//
//  Created by 曹冬冬 on 16/11/4.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ResponseHeadModel;

@interface ResponseModel : NSObject

@property (nonatomic, strong) ResponseHeadModel *response_head;

@property (nonatomic, strong) NSDictionary *response_body;

@end

@interface ResponseHeadModel : NSObject
/** 由app生成唯一的请求ID */
@property (nonatomic, copy) NSString *requet_id;
/** 1、系统处理成功；-1、系统处理异常 */
@property (nonatomic, copy) NSString *response_code;
/** 异常信息(前600字) */
@property (nonatomic, copy) NSString *error_content;
/** 服务器处理耗时，单位毫秒 */
@property (nonatomic, copy) NSString *consume;
@end
