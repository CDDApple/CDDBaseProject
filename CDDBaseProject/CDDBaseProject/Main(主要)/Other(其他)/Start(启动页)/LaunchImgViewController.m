//
//  LaunchImgViewController.m
//  CDDBaseProject
//
//  Created by 曹冬冬 on 16/2/15.
//  Copyright © 2016年 CDD. All rights reserved.
//

#import "LaunchImgViewController.h"
#import "NewFeatureViewController.h"
#import "TabBarViewController.h"

@interface LaunchImgViewController ()
// 启动页背景图片
@property (nonatomic ,strong) UIImageView *launchBgImage;
// 启动页logo的背景图片
@property (nonatomic ,strong) UIImageView *launchLogoImage;
// 启动页logo图片
@property (nonatomic ,weak) UIImageView *centerLaunchLogoImage;
@end

@implementation LaunchImgViewController

#pragma mark - Life cycle 生命周期
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO]; //隐藏
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.launchBgImage.backgroundColor = RGB(64, 64, 64);
    
    self.launchLogoImage.backgroundColor = [UIColor clearColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self launchWithLocalimage];
}


#pragma mark - Private method 私有方法
- (void)launchWithLocalimage{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *docPath =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *loadImageURL = [[NSUserDefaults standardUserDefaults] objectForKey:@"loadImageURL"];
    NSString *loadImagePath = [docPath stringByAppendingPathComponent:loadImageURL];
    BOOL hasLoadImagePath = [fileManager fileExistsAtPath:loadImagePath];
    if (loadImageURL.length > 0 && hasLoadImagePath) {//如果存在
        self.launchBgImage.image = [UIImage imageWithContentsOfFile:loadImagePath];
    }else{//如果不存在,即第一次启动
        self.launchBgImage.image = [UIImage imageNamed:@"ads"];
    }
    self.launchBgImage.contentMode = UIViewContentModeScaleAspectFill;
    self.launchBgImage.clipsToBounds = YES;
    //    self.cover.hidden = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 定时切换控制器
        [self switchRootViewController];
    });
}

/**
 *  定时切换根控制器
 */
- (void)switchRootViewController
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    // 判断应用显示新特性还是欢迎界面
    // 1.获取沙盒中的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *key = @"CFBundleShortVersionString";
    NSString *sandboxVersion = [defaults objectForKey:key];
    
    // 2.获取软件当前的版本号
    NSDictionary *dict = [NSBundle mainBundle].infoDictionary;
    NSString *currentVersion = dict[key];
    
    // 3.比较沙盒中的版本号和软件当前的版本号
    if([currentVersion compare:sandboxVersion] == NSOrderedDescending )
    {
        // 显示新特性
        window.rootViewController = [[NewFeatureViewController alloc] init];
        
        // 存储软件当前的版本号
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
        
    }else
    {
        window.rootViewController = [[TabBarViewController alloc] init];
    }
}
#pragma mark - Interface 接口
#pragma mark - event response
#pragma mark - Delegate 代理
#pragma mark - Getters and Setters
- (UIImageView *)launchBgImage{
    
    if (_launchBgImage == nil) {
        _launchBgImage = [[UIImageView alloc] init];
        _launchBgImage.contentMode = UIViewContentModeScaleAspectFill;
//        if(iPhone6Plus)
//        {
//            _launchBgImage.frame = (CGRect){0,0,SCREEN_WIDTH,SCREEN_HEIGHT - 95};
//        }else if(iPhone6)
//        {
//            _launchBgImage.frame = (CGRect){0,0,SCREEN_WIDTH,SCREEN_HEIGHT - 90};
//        }else
//        {
            _launchBgImage.frame = (CGRect){0,0,M_SCREEN_W,M_SCREEN_H - 75};
//        }
        
        [self.view addSubview:_launchBgImage];
    }
    return _launchBgImage;
}
- (UIImageView *)launchLogoImage{
    
    if (!_launchLogoImage) {
        _launchLogoImage = [[UIImageView alloc] init];
        
        _launchLogoImage.clipsToBounds = YES;
        _launchLogoImage.image = [UIImage imageNamed:@"Load_logo"];
//        if(iPhone6)
//        {
//            _launchLogoImage.contentMode = UIViewContentModeLeft;
//            _launchLogoImage.frame = CGRectMake(26, SCREEN_HEIGHT - 60, 320, 35);
//        }else if(iPhone6Plus)
//        {
//            _launchLogoImage.contentMode = UIViewContentModeScaleToFill;
//            _launchLogoImage.frame = CGRectMake(29, SCREEN_HEIGHT - 66, 265, 38);
//        }else
//        {
            _launchLogoImage.contentMode = UIViewContentModeScaleToFill;
            _launchLogoImage.frame = CGRectMake(22, M_SCREEN_H - 51, 205, 30);
//        }
        
        _launchLogoImage.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_launchLogoImage];
    }
    return _launchLogoImage;
}

@end
