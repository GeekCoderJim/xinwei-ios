//
//  CLAmplifyView.m
//  CLAmplifyView
//
//  Created by darren on 17/1/5.
//  Copyright © 2017年 darren. All rights reserved.
//

#import "CLAmplifyView.h"
//#import "YHBAlertView.h"
//#import "WXApi.h"

@interface CLAmplifyView()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    BOOL isAlert;
}
@property (nonatomic,strong) UIImageView *lastImageView;
@property (nonatomic,assign) CGRect originalFrame;
@property (nonatomic,strong) UIScrollView *scrollView;
//@property (nonatomic,strong) YHBAlertView *alertSheet;

@end

@implementation CLAmplifyView

- (instancetype)initWithFrame:(CGRect)frame andGesture:(UITapGestureRecognizer *)tap andSuperView:(UIView *)superView
{
    if (self=[super initWithFrame:frame]) {
        //scrollView作为背景
        UIScrollView *bgView = [[UIScrollView alloc] init];
        bgView.frame = [UIScreen mainScreen].bounds;
        bgView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *tapBg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBgView:)];
        [bgView addGestureRecognizer:tapBg];
        
        UIImageView *picView = (UIImageView *)tap.view;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = picView.image;
        imageView.frame = [bgView convertRect:picView.frame fromView:self];
        [bgView addSubview:imageView];
        [self addSubview:bgView];
        
        self.lastImageView = imageView;
        self.originalFrame = imageView.frame;
        self.scrollView = bgView;
        
        //最大放大比例
        self.scrollView.maximumZoomScale = 1.5;
        self.scrollView.delegate = self;
        
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = imageView.frame;
            frame.size.width = bgView.frame.size.width;
            frame.size.height = frame.size.width * (imageView.image.size.height / imageView.image.size.width);
            frame.origin.x = 0;
            frame.origin.y = (bgView.frame.size.height - frame.size.height) * 0.5;
            imageView.frame = frame;
        }];
        
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame andImageRect:(CGRect)imageRect andImage:(UIImage *)image{
    if (self = [super initWithFrame:frame]) {
        //scrollView作为背景
        UIScrollView *bgView = [[UIScrollView alloc] init];
        bgView.frame = [UIScreen mainScreen].bounds;
        bgView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *tapBg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBgView:)];
        tapBg.delegate=self;
        [bgView addGestureRecognizer:tapBg];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = image;
        
        imageView.frame = [bgView convertRect:CGRectMake(imageRect.origin.x, imageRect.origin.y, imageRect.size.width, imageRect.size.height) fromView:self];
        [bgView addSubview:imageView];
        [self addSubview:bgView];
        
//        self.alertSheet = [[YHBAlertView alloc]initWithFrame:ScreenBounds Data:@[@"保存图片",@"分享到微信好友",@"分享到朋友圈"]];
//        isAlert = NO;
//        [bgView addSubview:_alertSheet];
//        __weak typeof(self) weakself=self;
//        _alertSheet.click = ^(NSIndexPath *indexPath) {
//            [weakself.alertSheet hide];
//            switch (indexPath.row) {
//                case 0:
//                    {
//                        [weakself saveImageToAlbum];
//                    }
//                    break;
//                case 1:
//                    {
//                        [weakself shareToWechatFriend:10001];
//                    }
//                    break;
//                case 2:
//                    {
//                        [weakself shareToWechatFriend:10002];
//                    }
//                    break;
//                default:
//                    break;
//            }
//        };
        
        self.lastImageView = imageView;
        self.originalFrame = imageView.frame;
        self.scrollView = bgView;
        
//        UILongPressGestureRecognizer *longprese=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(show)];
//        self.lastImageView.userInteractionEnabled=YES;
//        [self.lastImageView addGestureRecognizer:longprese];
        
        //最大放大比例
        self.scrollView.maximumZoomScale = 1.5;
        self.scrollView.delegate = self;
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = imageView.frame;
            frame.size.width = bgView.frame.size.width;
            frame.size.height = frame.size.width * (imageView.image.size.height / imageView.image.size.width);
            frame.origin.x = 0;
            frame.origin.y = (bgView.frame.size.height - frame.size.height) * 0.5;
            imageView.frame = frame;
        }];
        
    }
    return self;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 输出点击的view的类名
    NSLog(@"%@", NSStringFromClass([touch.view class]));
    
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}
-(void)tapBgView:(UITapGestureRecognizer *)tapBgRecognizer
{
    self.scrollView.contentOffset = CGPointZero;
    [UIView animateWithDuration:0.3 animations:^{
        self.lastImageView.alpha=0;
        self.lastImageView.frame = self.originalFrame;
        tapBgRecognizer.view.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [tapBgRecognizer.view removeFromSuperview];
        [self removeFromSuperview];
        self.scrollView = nil;
        self.lastImageView = nil;
    }];
    
}
-(void)saveImageToAlbum{
    
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.lastImageView.width, self.lastImageView.height),YES,0);
    [self.lastImageView drawViewHierarchyInRect:Frame(0, 0, self.lastImageView.width, self.lastImageView.height) afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //以下是保存文件到沙盒路径下
    //把图片转成NSData类型的数据来保存文件
    NSData *data;
    //判断图片是不是png格式的文件
    NSString *imageType = nil;
    if (UIImagePNGRepresentation(image)) {
        //返回为png图像。
        data = UIImagePNGRepresentation(image);
        imageType = @"png";
    }else {
        //返回为JPEG图像。
        data = UIImageJPEGRepresentation(image, 1.0);
        imageType = @"jpeg";
    }
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    [AppUtils showSuccessMessage:@"图片保存成功"];
}
//-(void)shareToWechatFriend:(int)tag{
//    NSLog(@"分享");
//    //创建发送对象实例
//    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
//    sendReq.bText = NO;//不使用文本信息
//
//
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.lastImageView.width, self.lastImageView.height),YES,0);
//    [self.lastImageView drawViewHierarchyInRect:Frame(0, 0, self.lastImageView.width, self.lastImageView.height) afterScreenUpdates:YES];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//
//    UIImage *img = [UIImage imageWithData:[YhbMethods imageWithImage:image scaledToSize:CGSizeMake(self.lastImageView.width, self.lastImageView.height)]];
//
//    WXMediaMessage *message = [WXMediaMessage message];
//
//    WXImageObject *ext = [WXImageObject object];
//
//    NSData *dataimg =UIImageJPEGRepresentation(img,0.3);
//
//    NSData *detailImageData =UIImageJPEGRepresentation(image,1);
//
//    ext.imageData=detailImageData;
//
//    message.mediaObject = ext;
//
//    [message setThumbData:dataimg];
//
//    SendMessageToWXReq* req1 = [[SendMessageToWXReq alloc] init];
//
//    req1.bText = NO;
//
//    req1.message = message;
//
//
//
//    if (tag==10001) {
//        req1.scene = WXSceneSession; //微信好友
//    }else if (tag==10002){
//        req1.scene = WXSceneTimeline;//朋友圈
//    }
//    [WXApi sendReq:req1];
//
//}
//
//-(void)show{
//    isAlert=YES;
//    [_alertSheet show];
//
//}


//返回可缩放的视图

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView

{
    
    return self.lastImageView;
    
}



@end
