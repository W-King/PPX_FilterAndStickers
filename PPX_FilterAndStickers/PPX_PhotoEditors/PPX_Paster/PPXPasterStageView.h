//
//  PPXPasterStageView.h
//  PPX_FilterAndStickers
//
//  Created by pipixia on 2016/10/26.
//  Copyright © 2016年 pipixia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPXPasterStageView : UIView

@property (nonatomic,strong) UIImage *originImage ;

- (instancetype)initWithFrame:(CGRect)frame ;
- (void)addPasterWithImg:(UIImage *)imgP ;
- (UIImage *)doneEdit ;

@end
