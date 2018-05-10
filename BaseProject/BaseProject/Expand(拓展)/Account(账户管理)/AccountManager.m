//
//  AccountManager.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/8/31.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import "AccountManager.h"

#define AccountPath [AccountFilePath stringByAppendingPathComponent:@"account.plist"]
#define AccountFilePath [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"UserAccount"]

@implementation AccountManager

+ (instancetype)shareAccountManager{
    static AccountManager *_manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
        [_manager checkPath];
    });
    return _manager;
}

- (void)save:(NSDictionary *)dict{
    
    UserAccount *userAcount = [UserAccount mj_objectWithKeyValues:dict];
    // 归档
    [NSKeyedArchiver archiveRootObject:userAcount toFile:AccountPath];
    
    self.userAccount = userAcount;
}

- (void)remove{
    
    _userAccount = nil;
    if ([self isFileExist]) {
        NSError *err;
        [[NSFileManager defaultManager] removeItemAtPath:AccountPath error:&err];
    }
    
}

- (UserAccount *)userAccount {
    if (_userAccount == nil) {
        if ([self isFileExist]) {
            _userAccount = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
        }
    }
    return _userAccount;
}

/**
 *  是否登录
 */
- (BOOL)isUserLogin{
    return [self isFileExist] && self.userAccount != nil;
}

/**
 *  文件路径检查
 */
- (void)checkPath{
    if (!([self isFileExist])) {
        [self createDirectory];
    };
}

/**
 *  判断文件是否已经在沙盒中已经存在
 */
- (BOOL)isFileExist{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:AccountPath];
    return result;
}
/**
 *  创建目录
 */
- (BOOL)createDirectory{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL result = [fileManager createDirectoryAtPath:AccountFilePath withIntermediateDirectories:YES attributes:nil error:&error];
    return result;
}
@end
