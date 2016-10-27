//
//  ViewController.m
//  PPX_FilterAndStickers
//
//  Created by pipixia on 2016/10/26.
//  Copyright © 2016年 pipixia. All rights reserved.
//

#import "ViewController.h"
#import "PPX_PhotoEditorsViewController.h"

@interface ViewController ()<PPX_PhotoEditorsViewControllerDelegate>
{
    UIImageView *imageView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"5804dd84a5989.jpg"];
    imageView.frame = CGRectMake(0, 70, 300, 300);
    [self.view addSubview:imageView];
    
    UIButton *cc = [UIButton buttonWithType:UIButtonTypeCustom];
    cc.frame = CGRectMake(0, 400, 50, 50);
    cc.backgroundColor = [UIColor redColor];
    [cc addTarget:self action:@selector(ccClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cc];
}
- (void)ccClicked
{
    PPX_PhotoEditorsViewController *ppx = [[PPX_PhotoEditorsViewController alloc]init];
    ppx.delegate = self;
    ppx.imageWillHandle = imageView.image;
    [self.navigationController pushViewController:ppx animated:YES];
}
- (void)pasterAddFinished:(UIImage *)imageFinished
{
    imageView.image = imageFinished;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
