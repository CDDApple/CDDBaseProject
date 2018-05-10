//
//  AppDelegate.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/7/6.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarViewController.h"
#import "WelcomeViewController.h"
#import "ADViewController.h"

@interface AppDelegate ()
{
    Reachability *_reacha;
    NetworkStates _preStatus;
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self setupAppSubject];
    [self addNotification];
    [self checkNetworkStates];
    [self setupKeyWindow];

    [[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarByPosition];
    
    return YES;
}

- (void)setupAppSubject{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchViewController:) name:kADImageLoadSecussedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMainTabbarController) name:kADImageLoadFailNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMainTabbarController) name:kSKRootViewControllerSwitchNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChange) name:kReachabilityChangedNotification object:nil];
}

- (void)setupKeyWindow{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self loadRootViewController];
    [self.window makeKeyAndVisible];
}
/**
 *  根控制器
 */
- (void)loadRootViewController{
    if ([self isNewUpdate]) {
        WelcomeViewController *welcomeVC = [[WelcomeViewController alloc] init];
        self.window.rootViewController = welcomeVC;
    } else {
        ADViewController *adVC = [[ADViewController alloc] init];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            adVC.imageName = @"http://img01.bqstatic.com/upload/activity/2016011111271981.jpg";
        });
        self.window.rootViewController = adVC;
    }
}

- (void)switchViewController:(NSNotification *)n {
    UIImage *adImage = (UIImage *)n.object;
    MainTabBarViewController *mainTabBarVC = [[MainTabBarViewController alloc] init];
    mainTabBarVC.adImage = adImage;
    self.window.rootViewController = mainTabBarVC;
}

- (void)showMainTabbarController{
    self.window.rootViewController = [[MainTabBarViewController alloc] init];
}
/**
 *  检测是否为新版本
 */
- (BOOL)isNewUpdate {
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    NSString *sandboxVersionKey = @"CFBundleShortVersionString";
    NSString *sandboxVersion = [[NSUserDefaults standardUserDefaults] objectForKey:sandboxVersionKey];
    
    BOOL isNewUpdate = NO;
    if ([currentVersion compare:sandboxVersion] == NSOrderedDescending) {
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:sandboxVersionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        isNewUpdate = YES;
    }
    
    return isNewUpdate;
}
/**
 *  实时监控网络状态
 */
- (void)checkNetworkStates{
    _reacha = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];
    [_reacha startNotifier];
}
/**
 *  网络变化提醒
 */
- (void)networkChange{
    NSString *tips;
    NetworkStates currentStates = [CDDNetWorking getNetworkStates];
    if (currentStates == _preStatus) {
        return;
    }
    _preStatus = currentStates;
    switch (currentStates) {
        case NetworkStatesNone:
            tips = @"当前无网络, 请检查您的网络状态";
            break;
        case NetworkStates2G:
            tips = @"切换到了2G网络";
            break;
        case NetworkStates3G:
            tips = @"切换到了3G网络";
            break;
        case NetworkStates4G:
            tips = @"切换到了4G网络";
            break;
        case NetworkStatesWIFI:
            tips = nil;
            break;
        default:
            break;
    }
    
    if (tips.length) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:tips delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // 给状态栏添加一个按钮可以进行点击, 可以让屏幕上的scrollView滚到最顶部
//    [SLTopWindow show];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
