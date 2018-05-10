//
//  ADViewController.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/7/7.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import "ADViewController.h"

@interface ADViewController ()
@property (nonatomic, strong) UIImageView *adImageView;
@end

@implementation ADViewController

#pragma mark - Life cycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}
#pragma mark - Private method 私有方法
#pragma mark - Interface 接口
#pragma mark - Event response 事件
#pragma mark - Delegate 代理
#pragma mark - Getters and Setters
- (void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    
    [self.view addSubview:self.adImageView];
    [self.adImageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if(error != nil){
            [[NSNotificationCenter defaultCenter] postNotificationName:kADImageLoadFailNotification object:nil];
        }
        
        if(image != nil){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] setStatusBarHidden:NO];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:kADImageLoadSecussedNotification object:image];
                });
            });
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:kADImageLoadFailNotification object:nil];
        }
    }];
}

- (UIImageView *)adImageView{
    if(!_adImageView){
        _adImageView = [[UIImageView alloc] init];
        _adImageView.frame = [UIScreen mainScreen].bounds;
    }
    return _adImageView;
}
@end
