//
//  NewFeatureViewController.m
//  CDDBaseProject
//
//  Created by 曹冬冬 on 16/1/29.
//  Copyright © 2016年 CDD. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "TabBarViewController.h"

#define NewfeatureCount 4

@interface NewFeatureViewController ()

@end

@implementation NewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.创建一个ScrollView,显示所有新特性图片
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = M_SCREEN_BOUNDS;
    [self.view addSubview:scrollView];
    
    // 2.添加图片到ScrollView
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    for (NSInteger i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.left = scrollW * i;
        imageView.top = 0;
        
        imageView.backgroundColor = RANDOM_COLOR;
//        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"new_feature%zd", i]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [scrollView addSubview:imageView];
        
        // 若是最后一页,添加立即体验按钮
        if(i == NewfeatureCount - 1){
            [self setupLastImageView:imageView];
        }
    }
    
    // 3.scrollView属性设置
    scrollView.contentSize = CGSizeMake(NewfeatureCount * scrollW, 0);
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;

}

/**
 *  设置最后一个图片的立即体验按钮
 *
 *  @param imageView
 */
- (void)setupLastImageView:(UIImageView *)imageView{
    
    // 开启ImageView的交互
    imageView.userInteractionEnabled = YES;
    
    // 添加立即体验按钮
    UIButton *btn = [[UIButton alloc] init];
    //    [btn setTitle:@"立即体验" forState:UIControlStateNormal];
    btn.width = 200;
    btn.height = 50;
    btn.centerX = imageView.width * 0.5;
    btn.centerY = imageView.height * 0.68;
    
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [imageView addSubview:btn];
}

/**
 *  点击立即体验
 */
- (void)btnClick{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //window.rootViewController = [[HomeViewController alloc] init];
    window.rootViewController = [[TabBarViewController alloc] init];
}


@end
