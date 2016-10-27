```
引入三个文件
重新绘制
#import "ImageUtil.h"
滤镜色值
#import "ColorMatrix.h"
图片裁剪
#import "UIImage+AddFunction.h"

ImageUtil内存释放问题稍作修改
void * bitmap; 定义一下
free(bitmap);   之后释放
```
```
引入头文件 一个滤镜一个贴纸
#import "PPXFilterScrollView.h"
#import "PPXStickersScrollView.h"
//代理方法<PPXFilterScrollViewDelegate,PPXStickersScrollViewDelegate>
- (void)filterImage:(UIImage *)editedImage
{
    _stageView.originImage = editedImage;
}

- (void)stickersImage:(UIImage *)editedImage
{
    //在这里 添加 贴纸
    [_stageView addPasterWithImg:editedImage] ;
}
完成调用
UIImage *imgResult = [_stageView doneEdit] ;
```
```
简书地址
http://www.jianshu.com/p/13e0233e9b84
```
