//
//  UIMacros.h
//  BaseProject
//
//  Created by 曹冬冬 on 16/7/8.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#ifndef UIMacros_h
#define UIMacros_h

/** 字体大小 */
#define NAME_FONT(NAME,FONTSIZE)     [UIFont fontWithName:(NAME) size:(FONTSIZE)]
#define S_FONT(FONTSIZE)        [UIFont systemFontOfSize:FONTSIZE]
#define S_BOLD_FONT(FONTSIZE)   [UIFont boldSystemFontOfSize:FONTSIZE]

/** 颜色类 */
#ifndef UIColorHex
#define UIColorHex(_hex_)   [UIColor colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]
#endif
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
// 随机色
#define RANDOM_COLOR RGB(arc4random_uniform(255.0f), arc4random_uniform(255.0f), arc4random_uniform(255.0f))
//背景色
#define BACKGROUND_COLOR [UIColor colorWithRed:242.0/255.0 green:236.0/255.0 blue:231.0/255.0 alpha:1.0]
//清除背景色
#define CLEARCOLOR [UIColor clearColor]

/** 资源路径 */
#define PNG_PATH(NAME) [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"png"]
#define JPG_PATH(NAME) [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"jpg"]
#define PATH(NAME,EXT) [[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]

/**
 *  弱指针
 */
#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#endif /* UIMacros_h */
