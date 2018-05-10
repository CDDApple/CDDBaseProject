//
//  AccountManager.h
//  BaseProject
//
//  Created by 曹冬冬 on 16/8/31.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserAccount.h"

#define AccountTool [AccountManager shareAccountManager]

@interface AccountManager : NSObject
/** * 用户数据 */
@property (nonatomic, strong) UserAccount *userAccount;
/** * 是否登录 */
@property (nonatomic, assign, getter=isUserLogin) BOOL userLogin;

/**
 *  用户单例
 */
+ (instancetype)shareAccountManager;
/**
 *  保存账户信息
 */
- (void)save:(NSDictionary *)dict;
/**
 *  移除
 */
- (void)remove;
@end
