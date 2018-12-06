//
//  YHBShareView.m
//  SuperMarket
//
//  Created by 尤鸿斌 on 2018/1/9.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "YHBShareView.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

#define  ScreenWidth            [[UIScreen mainScreen] bounds].size.width      //屏幕宽度width
#define  ScreenHeight           [[UIScreen mainScreen] bounds].size.height     //屏幕高度height

//屏幕自适应
#define FB_FIX_SIZE_WIDTH(w) (((w) / 375.0) * ScreenWidth)
#define SET_FIX_SIZE_WIDTH (ScreenWidth /375.0)
#define AUTO(num)  num * SET_FIX_SIZE_WIDTH

#define ShareViewHeight 240

@implementation YHBShareView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupviews];
    }
    return self;
}
+(void)showWithInfo:(NSDictionary *)showInfo{
    YHBShareView *shareview=[[YHBShareView alloc]initWithFrame:ScreenBounds];
    shareview.shareURL=showInfo[@"url"];
    shareview.shareDesc=showInfo[@"content"];
    shareview.shareTitle=showInfo[@"title"];
    shareview.shareImage=showInfo[@"image"];
    [[[UIApplication sharedApplication]keyWindow] addSubview:shareview];
    [shareview show:shareview];
}
-(void)share:(UIButton *)sender{
    SSDKPlatformType type=SSDKPlatformTypeQQ;

    switch (sender.tag) {
        case 1000:
        {
            type=SSDKPlatformSubTypeWechatSession;
        }
            break;
        case 1001:
        {
            type=SSDKPlatformSubTypeWechatTimeline;
        }
            break;
        case 1002:
        {
            type=SSDKPlatformTypeQQ;
        }
            break;
        case 1003:
        {
            type=SSDKPlatformSubTypeQZone;
        }
            break;
        case 1004:
        {
            type=SSDKPlatformTypeSinaWeibo;
        }
            break;
        default:
            break;
    }
    //创建分享参数
    NSArray* imageArray = @[self.shareImage];
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:self.shareDesc
                                     images:imageArray //传入要分享的图片
                                        url:[NSURL URLWithString:self.shareURL]
                                      title:self.shareTitle
                                       type:SSDKContentTypeAuto];
    //进行分享
    [ShareSDK share:type //传入分享的平台类型
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // 回调处理....}];
         self.hidden=YES;
     }];

}
-(void)setupviews{
    self.black_bg_view=[[UIView alloc]initWithFrame:ScreenBounds];
    _black_bg_view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideview)];
    [_black_bg_view addGestureRecognizer:tap];
    [self addSubview:_black_bg_view];
    
    self.shareView=[[UIView alloc]initWithFrame:Frame(0, ScreenHeight, ScreenWidth, AUTO(ShareViewHeight))];
    _shareView.backgroundColor=[UIColor whiteColor];
    [self addSubview:_shareView];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _cancelBtn.frame=Frame(0, AUTO(ShareViewHeight-40), ScreenWidth, AUTO(40));
    [_shareView addSubview:_cancelBtn];
    [_cancelBtn addTarget:self action:@selector(hideview) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *sepLine=[[UIView alloc]initWithFrame:Frame(0, AUTO(ShareViewHeight-40-0.5), ScreenWidth, AUTO(0.5))];
    sepLine.backgroundColor=_black_bg_view.backgroundColor;
    [_shareView addSubview:sepLine];
    
    int value=0;
    int value2=0;
    NSArray *array=@[@{@"img":@"login_wechat",@"title":@"微信"},
                     @{@"img":@"pengyouquan",@"title":@"朋友圈"},
                     @{@"img":@"login_qq",@"title":@"QQ"},
                     @{@"img":@"Qzone",@"title":@"QQ空间"},
                     @{@"img":@"login_weibo",@"title":@"微博"},];
    for (int i = 0 ; i < 5; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        if (i<3) {
            value++;
            btn.frame=Frame((i+value)*ScreenWidth/6-ScreenWidth/12, AUTO(18), AUTO(60), AUTO(80));
        }else{
            value2++;
            btn.frame=Frame((i-3+value2)*ScreenWidth/6-ScreenWidth/12, AUTO(104), AUTO(60), AUTO(80));
        }
        [self setBtn:btn ImageName:array[i][@"img"] title:array[i][@"title"]];
        btn.tag=1000+i;
        [btn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
        [_shareView addSubview:btn];
    }
}
-(void)setBtn:(UIButton *)btn ImageName:(NSString *)imageName title:(NSString *)title{
    UIImageView *imageview=[[UIImageView alloc]initWithImage:Image(imageName)];
    imageview.frame=Frame(0, 0, btn.frame.size.width*0.8, btn.frame.size.width*0.8);
    imageview.center=CGPointMake(btn.frame.size.width/2, imageview.center.y+AUTO(5));
    [btn addSubview:imageview];
    
    UILabel *label=[[UILabel alloc]initWithFrame:Frame(0, btn.frame.size.width*0.8+AUTO(15), btn.frame.size.width, AUTO(12))];
    label.text=title;
    label.textColor=[UIColor darkGrayColor];
    label.font=Font(AUTO(12));
    label.textAlignment=NSTextAlignmentCenter;
    [btn addSubview:label];
}
-(void)show:(YHBShareView *)shareview{
    [UIView animateWithDuration:0.3 animations:^{
        if (iPhoneX) {
            shareview.shareView.frame=Frame(0, ScreenHeight-AUTO(ShareViewHeight)-AUTO(20), ScreenWidth, AUTO(ShareViewHeight));
        }else{
            shareview.shareView.frame=Frame(0, ScreenHeight-AUTO(ShareViewHeight), ScreenWidth, AUTO(ShareViewHeight));
        }
        
    }];
}
-(void)hideview{
    self.hidden=YES;
}
-(void)hide:(YHBShareView *)shareview{
  
  [UIView animateWithDuration:0.3 animations:^{
    shareview.shareView.frame=Frame(0, ScreenHeight, ScreenWidth, AUTO(ShareViewHeight));
  } completion:^(BOOL finished) {
    [shareview removeFromSuperview];
  }];
}
@end
