//
//  LoadMaskHelper.m
//  ZiPeiYi
//
//  Created by 刘成利 on 16/6/14.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "LoadMaskHelper.h"
#import "SingleMaskView.h"



#define MaskVersiomKey       @"MaskVersiomKey"
//#define MainPageKey_NewUser  @"MainPageKey_NewUser-2.1.1"
//#define MainPageKey          @"MainPage-2.1.1"          // 主页
//#define ExtendPageKey        @"ExtendPage-2.1.1"        // 推广
//#define MorePageKey          @"MorePage-2.1.1"
@implementation LoadMaskHelper

+ (void)showMaskWithType:(PageTye)pageType delay:(NSTimeInterval)delay sepcialFrame:(CGRect)sepcialframe{

    NSString *appVersion=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];

    
    NSString *MainPageKey_NewUser=[NSString stringWithFormat:@"MainPageKey_NewUser-%@",appVersion];
    NSString *MainPageKey=[NSString stringWithFormat:@"MainPageKey-%@",appVersion];
    NSString *ExtendPageKey=[NSString stringWithFormat:@"ExtendPageKey-%@",appVersion];
    NSString *MorePageKey=[NSString stringWithFormat:@"MorePageKey-%@",appVersion];
    // 处理是否加载蒙版
    switch (pageType) {
            // 个人主页_未绑卡
        case MainPage_NewUser:
        {
            NSString *KeyStr = [[NSUserDefaults standardUserDefaults] objectForKey:MainPageKey_NewUser];

            if(KeyStr.length <=0)
            {
                
                [[NSUserDefaults standardUserDefaults] setObject:@"haveShown" forKey:MainPageKey_NewUser];
                
            }else{
                
                // 测试用，让蒙版再次显示，开发完工后注释掉下面代码
                //                  [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:MainPageKey];
                return;
                
            }
            
        }
            
            break;
            
            // 个人主页
        case MainPage:
        {
            NSString *KeyStr = [[NSUserDefaults standardUserDefaults] objectForKey:MainPageKey];

            if(KeyStr.length <=0)
            {
            
                [[NSUserDefaults standardUserDefaults] setObject:@"haveShown" forKey:MainPageKey];
            
            }else{
                
                // 测试用，让蒙版再次显示，开发完工后注释掉下面代码
//                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:MainPageKey];
                return;
            
            }
        
        }
           
        break;
            
            
            
   
            
        case ExtendPage:
        {
            NSString *KeyStr = [[NSUserDefaults standardUserDefaults] objectForKey:ExtendPageKey];
            if(KeyStr.length <=0)
            {
                
                [[NSUserDefaults standardUserDefaults] setObject:@"haveShown" forKey:ExtendPageKey];
                
            }else{
                // 测试用，让蒙版再次显示，开发完工后注释掉下面代码
//                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:ExtendPageKey];
                return;
                
            }
            
        }

            break;
            
        case MorePage:
        {
            NSString *KeyStr = [[NSUserDefaults standardUserDefaults] objectForKey:MorePageKey];
            
            if(KeyStr.length <=0)
            {
                
                [[NSUserDefaults standardUserDefaults] setObject:@"haveShown" forKey:MorePageKey];
                
            }else{
                
                // 测试用，让蒙版再次显示，开发完工后注释掉下面代码
                //                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:MainPageKey];
                return;
                
            }
            
        }
            
            break;
     
            
        default:
          break;
    }

    
    
    
    
    
    /*
     以下 项目真实使用案例
     */
    
    
    
    SingleMaskView *maskView = [SingleMaskView new];
    maskView.maskColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    // 加载蒙版
    switch (pageType) {
            // 主页_新用户
        case MainPage_NewUser:
        {
            
//            [maskView addTransparentOvalRect:CGRectMake(0, AUTO(180), ScreenWidth/2, AUTO(80))];
            [maskView addTransparentRect:CGRectMake(AUTO(10), AUTO(172), (ScreenWidth-AUTO(20))/2-1, AUTO(80)) withRadius:AUTO(5)];
            UIImage *image=Image(@"pic_renzheng");
            
            UIImageView *imagev=[UIImageView new];
            imagev.image=image;
            [maskView addSubview:imagev];
            imagev.sd_layout
            .rightSpaceToView(maskView, AUTO(20))
            .topSpaceToView(maskView, AUTO(280))
            .heightIs(image.size.height)
            .widthIs(image.size.width);
            
            
        }
            break;
          // 主页
        case MainPage:
        {
           
           // 添加第一个蒙版透明区
            [maskView addTransparentOvalRect:CGRectMake(ScreenWidth/2+AUTO(15), ScreenHeight-AUTO(60), AUTO(60), AUTO(60))];
            UIImage *image=Image(@"pic_tuiguang");

            UIImageView *imagev=[UIImageView new];
            imagev.image=image;
            [maskView addSubview:imagev];
            imagev.sd_layout
            .centerXEqualToView(maskView)
            .bottomSpaceToView(maskView, AUTO(60))
            .heightIs(image.size.height)
            .widthIs(image.size.width);

            
        }
            break;
       
            
            
        // 推广
        case ExtendPage:
        {
//            [maskView addImage:[UIImage imageNamed:@"pic_wozhidaole"] withFrame:CGRectMake((view.width)/4, 170, 172 , 83)];
            UIImageView *imagev=[UIImageView new];
            UIImage *image=Image(@"pic_wozhidaole");
            imagev.image=image;
            [maskView addSubview:imagev];
            imagev.sd_layout
            .centerXEqualToView(maskView)
            .centerYEqualToView(maskView)
            .heightIs(image.size.height)
            .widthIs(image.size.width);
        }
            break;
          
            // 个人中心
        case MorePage:
        {
            //            [maskView addImage:[UIImage imageNamed:@"pic_wozhidaole"] withFrame:CGRectMake((view.width)/4, 170, 172 , 83)];
            
            
                [maskView addTransparentRect:sepcialframe withRadius:AUTO(5)];
                UIImageView *imagev=[UIImageView new];
                UIImage *image=Image(@"pic_bangka");
                imagev.image=image;
                [maskView addSubview:imagev];
                imagev.sd_layout
                .centerXEqualToView(maskView)
                .topSpaceToView(maskView, sepcialframe.origin.y+AUTO(70))
                .heightIs(image.size.height)
                .widthIs(image.size.width);

            }
            break;
   

            
            
        default:
            break;
    }
    
    
    // GCD 延时，非阻塞主线程 延时时间：delay
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        
//        [maskView showMaskViewInView:view];
        UIWindow *window=[[UIApplication sharedApplication]keyWindow];
        
        [window addSubview:maskView];

        
    });
        
    
   
    
   


}


// 由于每一版app蒙版不一样，新版app自己删除旧版app蒙版代码，即可不用下面的方法
+ (void)checkAPPVersion{

    
    /*
     
     
    // 启动时候检测，版本升级   (在app delegate 调用此类的方法);
     
    NSString *KeyStr = [[NSUserDefaults standardUserDefaults] objectForKey:MaskVersiomKey];
    if (KeyStr.length <=0) {
        
        // 头一次安装
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        [[NSUserDefaults standardUserDefaults] setObject:appVersion forKey:MaskVersiomKey];
        
        return;
    }else{
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        
        if ([KeyStr isEqualToString:appVersion])
        {
            return;
            
        }else{
            // 版本升级的情况
            [[NSUserDefaults standardUserDefaults] setObject:appVersion forKey:MaskVersiomKey];
            
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:HomePageKey];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:VtSIAIKey];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:VtISMKey];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:VtSIAIKeyListKey];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:VtISMKeyListKey];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:SIAIInstructionKey];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:ISMInstructionKey];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:StockCurveKey];
            
        }
        
    }
    
     
     
     */


}
@end
