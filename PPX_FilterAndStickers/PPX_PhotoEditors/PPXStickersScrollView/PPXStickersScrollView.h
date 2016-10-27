//
//  PPXStickersScrollView.h
//  PPX_FilterAndStickers
//
//  Created by pipixia on 2016/10/26.
//  Copyright © 2016年 pipixia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PPXStickersScrollViewDelegate <NSObject>
@required;
- (void)stickersImage:(UIImage *)editedImage;

@end


@interface PPXStickersScrollView : UIScrollView

@property (nonatomic,weak) id<PPXStickersScrollViewDelegate> StickersDelegate;

/**名字数组*/
@property (nonatomic, copy) NSArray *titleArray;

/**
 *  开始加载滤镜的scrollView
 */
- (void)loadScrollView;

@end
