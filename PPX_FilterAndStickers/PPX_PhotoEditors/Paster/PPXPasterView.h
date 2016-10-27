//
//  XTPasterView.h
//  XTPasterManager
//
//  Created by apple on 15/7/8.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPXPasterStageView.h"

@class PPXPasterView ;

@protocol XTPasterViewDelegate <NSObject>
- (void)makePasterBecomeFirstRespond:(int)pasterID ;
- (void)removePaster:(int)pasterID ;
@end

@interface PPXPasterView : UIView

@property (nonatomic,strong)    UIImage *imagePaster ;
@property (nonatomic)           int     pasterID ;
@property (nonatomic)           BOOL    isOnFirst ;
@property (nonatomic,weak)    id <XTPasterViewDelegate> delegate ;
- (instancetype)initWithBgView:(PPXPasterStageView *)bgView
                      pasterID:(int)pasterID
                           img:(UIImage *)img ;
- (void)remove ;

@end
