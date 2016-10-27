//
//  PPXStickersScrollView.m
//  PPX_FilterAndStickers
//
//  Created by pipixia on 2016/10/26.
//  Copyright © 2016年 pipixia. All rights reserved.
//

#import "PPXStickersScrollView.h"

@interface PPXStickersScrollView ()
{
    CGFloat inset_space;
    CGFloat filterBtnW_H;
}

@end

@implementation PPXStickersScrollView


- (void)loadScrollView {
    
    // 初始化内部控件
    [self initViews];
}
- (void)initViews
{
    [self dataUI];
    [self initUI];
    
}
- (void)dataUI
{
    filterBtnW_H = 100;
    inset_space = 10;
    
}
- (void)initUI
{
    for (int i = 0; i < _titleArray.count; i ++)
    {
        UIButton *filterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [filterBtn setBackgroundImage:[UIImage imageNamed:_titleArray[i]] forState:UIControlStateNormal];
        filterBtn.tag = i;
        filterBtn.frame = CGRectMake((i+1)*inset_space*2/3 + filterBtnW_H*i, 5, filterBtnW_H, filterBtnW_H);
        [filterBtn addTarget:self action:@selector(filterClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:filterBtn];
    }
}
- (void)filterClick:(UIButton *)button
{    
    UIImage *image = [UIImage imageNamed:_titleArray[button.tag]] ;
    [self.StickersDelegate stickersImage:image];
}

@end
