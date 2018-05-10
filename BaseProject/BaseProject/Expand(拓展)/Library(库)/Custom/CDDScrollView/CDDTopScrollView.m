//
//  CDDTopScrollView.m
//  BaseProject
//
//  Created by 曹冬冬 on 2017/4/6.
//  Copyright © 2017年 曹冬冬. All rights reserved.
//

#import "CDDTopScrollView.h"


/** 指示器的高度 */
static CGFloat SG_indicatorHeight = 2;
/** 指示器的动画移动时间 */
static CGFloat SG_indicatorAnimationTime = 0.1;
/** 默认标题字体大小 */
static CGFloat SG_defaultTitleFont = 15;
/** 按钮之间的间距(滚动时按钮之间的间距) */
static CGFloat SG_btnMargin = 15;
/** 标题按钮文字的缩放倍数 */
static CGFloat SG_btnScale = 0.14;
/** 默认SGImageButton_Horizontal图片的宽度 */
static CGFloat SG_defaultHorizontalImageWidth = 20;

@interface CDDTopScrollView()
/** 标题数组 */
@property (nonatomic, strong) NSArray *title_Arr;
/** 存入所有标题按钮 */
@property (nonatomic, strong) NSMutableArray *storageAlltitleBtn_mArr;

/** 临时button用来转换button的点击状态 */
@property (nonatomic, strong) UIButton *temp_btn;
@end

@implementation CDDTopScrollView


- (instancetype)initWithFrame:(CGRect)frame delegate:(id<CDDTopScrollViewDelegate>)delegate childVcTitle:(NSArray *)childVcTitle isScaleText:(BOOL)isScaleText {
    
    if (self = [super initWithFrame:frame]) {
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        
        self.delegate_TS = delegate;
        self.title_Arr = childVcTitle;
        
        [self setupSubviews];
    }
    return self;
}

+ (instancetype)segmentedControlWithFrame:(CGRect)frame delegate:(id<CDDTopScrollViewDelegate>)delegate childVcTitle:(NSArray *)childVcTitle isScaleText:(BOOL)isScaleText {
    return [[self alloc] initWithFrame:frame delegate:delegate childVcTitle:childVcTitle isScaleText:isScaleText];
}

- (void)setupSubviews{
    
    CGFloat button_X = 0;
    CGFloat button_Y = 0;
    CGFloat button_H = self.frame.size.height;
    
    for (NSInteger i = 0; i < _title_Arr.count; i++) {
        UIButton *titleBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:SG_defaultTitleFont];
        titleBtn.tag = i;
        
        CGSize titleBtnSize = [self sizeWithText:_title_Arr[i] font:[UIFont systemFontOfSize:SG_defaultTitleFont] maxSize:CGSizeMake(MAXFLOAT, button_H)];
        // 计算内容的宽度
        CGFloat button_W = 2 * SG_btnMargin + titleBtnSize.width;
        titleBtn.frame = CGRectMake(button_X, button_Y, button_W, button_H);
        
        [titleBtn setTitle:_title_Arr[i] forState:(UIControlStateNormal)];
        [titleBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [titleBtn setTitleColor:[UIColor redColor] forState:(UIControlStateSelected)];
        
        // 计算每个button的X值
        button_X = button_X + button_W;
        
        // 点击事件
        [titleBtn addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        // 选中第一个
        if(i == 0){
            [self buttonAction:titleBtn];
        }
        [self.storageAlltitleBtn_mArr addObject:titleBtn];
        [self addSubview:titleBtn];
    }
    
    DLog(@"height:%f", self.frame.size.height);
    
    // 计算scrollView的宽度
    CGFloat scrollViewWidth = CGRectGetMaxX(self.subviews.lastObject.frame);
    self.contentSize = CGSizeMake(scrollViewWidth, 0);
}


- (void)buttonAction:(UIButton *)sender{
    // 1、代理方法实现
    if([_delegate_TS respondsToSelector:@selector(topScrollView:didSelectTitleAtIndex:)]){
        [_delegate_TS topScrollView:self didSelectTitleAtIndex:sender.tag];
    }
    
    // 2、改变选中的button的位置
    [self selectedBtnLocation:sender];
    
}


/**
 *  计算文字尺寸
 *
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


/** 改变选中button的位置以及指示器位置变化（给外界scrollView提供的方法 -> 必须实现） */
- (void)changeThePositionOfTheSelectedBtnWithScrollView:(UIScrollView *)scrollView {
    // 1、计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 防止下标越界引起程序崩溃
    if (index >= self.storageAlltitleBtn_mArr.count) {
        return;
    }
    
    // 2、把对应的标题选中
    UIButton *selectedBtn = self.storageAlltitleBtn_mArr[index];
    
    // 3、滚动时，改变标题选中
    [self selectedBtnLocation:selectedBtn];
}


/** 标题选中颜色改变以及指示器位置变化 */
- (void)selectedBtnLocation:(UIButton *)button {

    // 1、选中的button
    if (_temp_btn == nil) {
        button.selected = YES;
        _temp_btn = button;
    }else if (_temp_btn != nil && _temp_btn == button){
        button.selected = YES;
    }else if (_temp_btn != button && _temp_btn != nil){
        _temp_btn.selected = NO;
        button.selected = YES; _temp_btn = button;
    }
    
    // 3、滚动标题选中居中
    [self selectedBtnCenter:button];
}

/** 滚动标题选中居中 */
- (void)selectedBtnCenter:(UIButton *)centerBtn {
    // 计算偏移量
    CGFloat offsetX = centerBtn.center.x - self.frame.size.width * 0.5;
    
    if (offsetX < 0) offsetX = 0;
    
    // 获取最大滚动范围
    CGFloat maxOffsetX = self.contentSize.width - self.frame.size.width;
    
    if (offsetX > maxOffsetX) offsetX = maxOffsetX;
    
    // 滚动标题滚动条
    [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (NSMutableArray *)storageAlltitleBtn_mArr {
    if (!_storageAlltitleBtn_mArr) {
        _storageAlltitleBtn_mArr = [NSMutableArray array];
    }
    return _storageAlltitleBtn_mArr;
}
@end
