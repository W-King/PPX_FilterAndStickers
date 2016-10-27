//
//  PPX_PhotoEditorsViewController.m
//  PIC
//
//  Created by pipixia on 2016/10/20.
//  Copyright © 2016年 pipixia. All rights reserved.
//

#import "PPX_PhotoEditorsViewController.h"

//滤镜
#import "YBFilterScrollView.h"
#import "StickersScrollView.h"

//
#import "XTPasterStageView.h"
#import "XTPasterView.h"

//
#define FULL_SCREEN_H [UIScreen mainScreen].bounds.size.height
#define FULL_SCREEN_W [UIScreen mainScreen].bounds.size.width
//

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

/**底部的scrollView的高*/
const CGFloat pasterScrollView_H = 120;
/**空白的距离间隔*/
const CGFloat inset_space = 10;

/**底部按钮的高度*/
static CGFloat bottomButtonH = 52;
//

@interface PPX_PhotoEditorsViewController ()<YBFilterScrollViewDelegate,StickersScrollViewDelegate>


/**装多个滤镜样式的scrollView*/
@property (nonatomic, strong) YBFilterScrollView *filterScrollView;
//
@property (nonatomic, strong) StickersScrollView *stickersScrollView;

@property (strong, nonatomic) XTPasterStageView *stageView ;


@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable" //消除没有用到的变量产生的警告

@implementation PPX_PhotoEditorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    //设置UI
    [self setupUI];
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.frame = CGRectMake(0, FULL_SCREEN_H - 52, FULL_SCREEN_W, 52);
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    
    UIButton *btnOne = [UIButton buttonWithType:UIButtonTypeCustom];
    btnOne.tag = 10;
    btnOne.frame = CGRectMake(0, 0, 52, 52);
    btnOne.backgroundColor = [UIColor redColor];
    [btnOne setTitle:@"滤镜" forState:UIControlStateNormal];
    [btnOne addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:btnOne];
    
    UIButton *btnTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    btnTwo.tag = 11;
    btnTwo.frame = CGRectMake(100, 0, 52, 52);
    btnTwo.backgroundColor = [UIColor redColor];
    [btnTwo setTitle:@"贴纸" forState:UIControlStateNormal];
    [btnTwo addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:btnTwo];
    
    
    UIButton *btnThree = [UIButton buttonWithType:UIButtonTypeCustom];
    btnThree.frame = CGRectMake(250, 0, 52, 52);
    btnThree.backgroundColor = [UIColor redColor];
    [btnThree setTitle:@"完成" forState:UIControlStateNormal];
    [btnThree addTarget:self action:@selector(btnThreeClicked) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:btnThree];
}
/**
 *  设置UI
 */
- (void)setupUI
{
    [self setup] ;

    _filterScrollView = [[YBFilterScrollView alloc]initWithFrame:CGRectMake(0, FULL_SCREEN_H - 120 - bottomButtonH, FULL_SCREEN_W, 120)];
    _filterScrollView.backgroundColor = [UIColor redColor];
    NSArray *titleArray = @[@"原图",@"LOMO",@"黑白",@"复古",@"哥特",@"瑞华",@"淡雅",@"酒红",@"青柠",@"浪漫",@"光晕",@"蓝调",@"梦幻",@"夜色"];
    _filterScrollView.titleArray = titleArray;
    _filterScrollView.filterScrollViewW = pasterScrollView_H;
    _filterScrollView.insert_space = inset_space*2/3;
    _filterScrollView.labelH = 30;
    _filterScrollView.originImage = self.imageWillHandle;
    _filterScrollView.perButtonW_H = _filterScrollView.filterScrollViewW - 2*_filterScrollView.insert_space - 30;
    
    _filterScrollView.contentSize = CGSizeMake(_filterScrollView.perButtonW_H * titleArray.count + _filterScrollView.insert_space * (titleArray.count + 1), 40);
    _filterScrollView.filterDelegate = self;
    [_filterScrollView loadScrollView];
    [self.view addSubview:self.filterScrollView];
    
    
    _stickersScrollView= [[StickersScrollView alloc]initWithFrame:CGRectMake(0, FULL_SCREEN_H - 120 - bottomButtonH, FULL_SCREEN_W, 120)];
    NSArray *tArray = @[@"1",@"2",@"3",@"4",@"5"];
    _stickersScrollView.titleArray = tArray;
    _stickersScrollView.hidden = YES;
    _stickersScrollView.StickersDelegate = self;
    _stickersScrollView.contentSize = CGSizeMake(tArray.count * (100+10), 100);
    _stickersScrollView.backgroundColor = [UIColor redColor];
    [_stickersScrollView loadScrollView];
    [self.view addSubview:_stickersScrollView];


}
- (void)btnClicked:(UIButton *)button
{
    // 当前位置是贴纸
    if (button.tag == 10)
    {
        [UIView animateWithDuration:.5 animations:^{
            self.filterScrollView.alpha = 1.0;
            self.filterScrollView.hidden = NO;
            
        }];
    }else
    {
        self.filterScrollView.hidden = YES;
        self.filterScrollView.alpha = .0;
        
       
    }
    
    // 当前位置是滤镜
    if (button.tag == 11)
    {
        [UIView animateWithDuration:.5 animations:^{
            self.stickersScrollView.alpha = 1.0;
            self.stickersScrollView.hidden = NO;
        }];
    }
    else
    {
        self.stickersScrollView.hidden = YES;
        self.stickersScrollView.alpha = .0;
        
       
    }

}
-(void)btnThreeClicked
{
    NSLog(@"完成");
    UIImage *imgResult = [_stageView doneEdit] ;
    [self.delegate pasterAddFinished:imgResult] ;
    [self.navigationController popViewControllerAnimated:YES] ;
}
#pragma mark - Life cycle
- (void)setup
{
    
    
    CGFloat imageWH = self.imageWillHandle.size.width/self.imageWillHandle.size.height;
    CGFloat screenWH = SCREEN_WIDTH/(SCREEN_HEIGHT - 64 - 52);
    
    CGFloat X;
    CGFloat Y;
    CGFloat W;
    CGFloat H;
    
    if (imageWH > screenWH)
    {
        
        if (self.imageWillHandle.size.width/2 < SCREEN_WIDTH/2)
        {
            X = SCREEN_WIDTH/2-self.imageWillHandle.size.width/4;
            Y = (SCREEN_HEIGHT - 64 - 52)/2-self.imageWillHandle.size.height/4;
            W = self.imageWillHandle.size.width/2;
            H = self.imageWillHandle.size.height/2;
        }
        else
        {
            X = 0;
            W = SCREEN_WIDTH;
            H = SCREEN_HEIGHT *(self.imageWillHandle.size.height/2)/(self.imageWillHandle.size.width/2);
            Y = (SCREEN_HEIGHT - 64 - 52)/2-H/2;
        }
    }
    else
    {
        if (self.imageWillHandle.size.height/2 < (SCREEN_HEIGHT - 64 - 52)/2)
        {
            X = SCREEN_WIDTH/2-self.imageWillHandle.size.width/4;
            Y = (SCREEN_HEIGHT - 64 - 52)/2-self.imageWillHandle.size.height/4;
            W = self.imageWillHandle.size.width/2;
            H = self.imageWillHandle.size.height/2;
        }
        else
        {
            Y = 64;
            H = (SCREEN_HEIGHT - 64 - 52);
            W = (SCREEN_HEIGHT - 64 - 52)*(self.imageWillHandle.size.width/2)/(self.imageWillHandle.size.height/2);
            X = SCREEN_WIDTH/2 - W/2;
        }
    }
    
    _stageView = [[XTPasterStageView alloc] initWithFrame:CGRectMake(X, Y, W, H)] ;
    
//    _stageView = [[XTPasterStageView alloc] initWithFrame:CGRectMake(0, 64, 300, 300)] ;
    _stageView.clipsToBounds = YES;
    _stageView.originImage = self.imageWillHandle ;
    _stageView.backgroundColor = [UIColor whiteColor] ;
    [self.view addSubview:_stageView] ;
}

#pragma mark - YBFilterScrollViewDelegate
- (void)filterImage:(UIImage *)editedImage
{
    _stageView.originImage = editedImage;

}

- (void)stickersImage:(UIImage *)editedImage
{
    //在这里 添加 贴纸
    [_stageView addPasterWithImg:editedImage] ;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
