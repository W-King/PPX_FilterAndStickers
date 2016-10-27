//
//  PPX_PhotoEditorsViewController.h
//  PPX_FilterAndStickers
//
//  Created by pipixia on 2016/10/26.
//  Copyright © 2016年 pipixia. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PPX_PhotoEditorsViewControllerDelegate <NSObject>
- (void)pasterAddFinished:(UIImage *)imageFinished ;
@end

@interface PPX_PhotoEditorsViewController : UIViewController

@property (nonatomic,weak)   id <PPX_PhotoEditorsViewControllerDelegate> delegate ;

@property (nonatomic,strong) UIImage *imageWillHandle;


@end
