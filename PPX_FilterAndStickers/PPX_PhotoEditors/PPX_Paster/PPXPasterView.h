//
//  PPXPasterView.h
//  PPX_FilterAndStickers
//
//  Created by pipixia on 2016/10/26.
//  Copyright © 2016年 pipixia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPXPasterStageView.h"

@class PPXPasterView ;

@protocol PPXPasterViewDelegate <NSObject>
- (void)makePasterBecomeFirstRespond:(int)pasterID ;
- (void)removePaster:(int)pasterID ;
@end

@interface PPXPasterView : UIView

@property (nonatomic,strong)    UIImage *imagePaster ;
@property (nonatomic)           int     pasterID ;
@property (nonatomic)           BOOL    isOnFirst ;
@property (nonatomic,weak)    id <PPXPasterViewDelegate> delegate ;
- (instancetype)initWithBgView:(PPXPasterStageView *)bgView
                      pasterID:(int)pasterID
                           img:(UIImage *)img ;
- (void)remove ;

@end
