//
//  MainTabButton.m
//  BaseProject
//
//  Created by 曹冬冬 on 16/9/2.
//  Copyright © 2016年 曹冬冬. All rights reserved.
//

#import "MainTabButton.h"

#define kBadgeValueLabelWidth  17
#define kBadgeValueLabelHeight kBadgeValueLabelWidth
#define kBadgeValueLabelMinTopMargin 3
#define kBadgeValueLabelFont [UIFont systemFontOfSize:12]

@interface MainTabButton ()

@property (strong, nonatomic) UILabel *badgeValueLabel;

@property (strong, nonatomic) NSLayoutConstraint *widthConstraint;

@end

@implementation MainTabButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType {
    id button = [super buttonWithType:buttonType];
    if (button) {
        [button addCustomSubviews];
    }
    return button;
}

- (void)addCustomSubviews {
    UILabel *badgeValueLabel = [UILabel new];
    self.badgeValueLabel = badgeValueLabel;
    badgeValueLabel.textColor = [UIColor whiteColor];
    badgeValueLabel.textAlignment = NSTextAlignmentCenter;
    badgeValueLabel.layer.cornerRadius = kBadgeValueLabelHeight * 0.5;
    badgeValueLabel.layer.masksToBounds = YES;
    badgeValueLabel.backgroundColor = [UIColor redColor];
    [self addSubview:badgeValueLabel];
    badgeValueLabel.hidden = YES;
    
    badgeValueLabel.translatesAutoresizingMaskIntoConstraints = NO;
    // 左右
    [self addConstraint:[NSLayoutConstraint constraintWithItem:badgeValueLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.25 constant:0]];
    // 上下
    [self addConstraint:[NSLayoutConstraint constraintWithItem:badgeValueLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:0.4 constant:0]];
    // 顶部低于button顶部
    [self addConstraint:[NSLayoutConstraint constraintWithItem:badgeValueLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:kBadgeValueLabelMinTopMargin]];
    // 宽度
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:badgeValueLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kBadgeValueLabelWidth];
    self.widthConstraint = widthConstraint;
    [self addConstraint:widthConstraint];
    // 高度
    [self addConstraint:[NSLayoutConstraint constraintWithItem:badgeValueLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kBadgeValueLabelHeight]];
    
}

- (void)setBadgeValue:(NSInteger)badgeValue {
    _badgeValue = badgeValue;
    
    if (badgeValue < 0) {
        self.badgeValueLabel.hidden = YES;
        return;
    }
    if (badgeValue == 0) {
        self.badgeValueLabel.text = @"";
        self.badgeValueLabel.hidden = YES;
    }
    // 未操作的申请数量
    if ( badgeValue > 0) {
        NSString *showd_count;
        if (badgeValue <= 99) {
            showd_count = [NSString stringWithFormat:@"%@", @(badgeValue)];
        } else {
            showd_count = @"99+";
        }
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:showd_count];
        [attrStr addAttribute:NSFontAttributeName value:kBadgeValueLabelFont range:NSMakeRange(0, showd_count.length)];
        [attrStr addAttribute:NSKernAttributeName value:@(-0.5) range:NSMakeRange(0, showd_count.length)];
        self.badgeValueLabel.attributedText = attrStr;
        self.badgeValueLabel.hidden = NO;
        
        [self resizeBadgeValueLabelToFit];
    }
}

/**
 *  取消按钮高亮状态的做法
 */
- (void)setHighlighted:(BOOL)highlighted {}

- (void)resizeBadgeValueLabelToFit {
    NSString *s = self.badgeValueLabel.text;
    CGSize size = CGSizeMake(320,2000);
    
    NSDictionary *attrs = @{NSFontAttributeName: kBadgeValueLabelFont, NSKernAttributeName:@(-0.5)};
    CGRect sRect = [s boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
    
    if (kBadgeValueLabelWidth < (sRect.size.width + 4)) {
        [self removeConstraint:self.widthConstraint];
        NSLayoutConstraint *newWidthConstraint = [NSLayoutConstraint constraintWithItem:self.badgeValueLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:(sRect.size.width + 4)];
        [self addConstraint:newWidthConstraint];
        self.widthConstraint = newWidthConstraint;
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
    
}
@end
