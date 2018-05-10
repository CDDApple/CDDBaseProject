//
//  NSFileManager+Paths.h
//  BaseProject
//
//  Created by 曹冬冬 on 16/9/18.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Paths)

/**
 获取文件目录的URL

 @return 获取文件目录的URL
 */
+ (NSURL *)documentsURL;

/**
 获取文件目录的路径
 
 @return 获取文件目录的路径
 */
+ (NSString *)documentsPath;

/**
 获取Library目录的URL
 
 @return 获取Library目录的URL
 */
+ (NSURL *)libraryURL;

/**
 获取Library目录的路径
 
 @return 获取Library目录的路径
 */
+ (NSString *)libraryPath;

/**
 获取缓存目录的RUL
 
 @return 获取缓存目录的RUL
 */
+ (NSURL *)cachesURL;

/**
 获取缓存目录的路径
 
 @return 获取缓存目录的路径
 */
+ (NSString *)cachesPath;

/**
 可用磁盘空间。
 
 @return 可用磁盘空间(M)。
 */
+ (double)availableDiskSpace;
@end
