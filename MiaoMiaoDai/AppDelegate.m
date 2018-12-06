//
//  AppDelegate.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/2/28.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "BaseTabBarController.h"
#import <AddressBook/AddressBook.h>
#import <ContactsUI/ContactsUI.h>
#import "JSMSConstant.h"
#import "JSMSSDK.h"
#import "LoginRequest.h"
#import "PublicRequest.h"
#import "WXApiManager.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
#import <RPSDK/RPSDK.h>
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"
@interface AppDelegate ()

@property(copy,nonatomic)NSString *url;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [WXApi registerApp:@"wx47d19897b35bae6f"];
    [JSMSSDK registerWithAppKey:@"92937259e7869f9efd7790b3"];
    [JSMSSDK setMinimumTimeInterval:SecondsForMsg];
    //设置SVProgressHUD
    [self svPreferrenceConf];
    //设置shareSDK
    [self setupShareSDK];
    [RPSDK initialize:RPSDKEnvOnline];
    
    if ([YhbMethods readBOOLUserDefault:@"isLogin"]==YES) {
        NSDictionary *dic=[YhbMethods readUserDefault:@"userInfo"];
        UserEntity *userEntity=[UserEntity shareUserEntity];
        userEntity = [[UserEntity alloc]initWithDic:dic];
    }
    
    

    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController=[BaseTabBarController new];
    [self.window makeKeyAndVisible];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    //IQKeyboardManager
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    
    if (!isAppStore) {
        [PublicRequest getAppUpdateInfo:^(id obj) {
            NSString *version=[NSString stringWithFormat:@"%@",obj[@"versionCode"]];
            self.url = obj[@"url"];
            NSString *updateMsg=[NSString stringWithFormat:@"%@",obj[@"description"]];
            
            NSString *appVersion=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            if (![appVersion isEqualToString:version]) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"新版本更新" message:updateMsg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
                [alert show];
            }
        }];
    }
    
    
    return YES;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.url]];
        [self exitApplication];
    }
}

//-(void)login{
//    [LoginRequest loginWithPhoneNumber:[YhbMethods readUserDefault:@"account"] password:[YhbMethods readUserDefault:@"password"] success:^(id obj) {
//        NSLog(@"%@",obj);
//        if ([obj[@"code"] isEqualToString:@"200"]) {
//            [YhbMethods setBoolUserDefaults:YES andKey:@"isLogin"];
//            [YhbMethods writeUserDefaults:[YhbMethods setDicNullClass:obj[@"content"]] andKey:@"userInfo"];
//            UserEntity *user=[UserEntity shareUserEntity];
//            user=[[UserEntity alloc]initWithDic:[YhbMethods setDicNullClass:obj[@"content"]]];
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"isLogin" object:nil];
//        }else{
//            [YhbMethods setBoolUserDefaults:NO andKey:@"isLogin"];
//            [YhbMethods removeUserDefault:@"userInfo"];
//            [YhbMethods removeUserDefault:@"account"];
//            [YhbMethods removeUserDefault:@"password"];
//            [AppUtils showAlertMessage:@"登录失败，请重新登录"];
//        }
//    }];
//}
#pragma mark --- SVProgressHUD 偏好设置
- (void)svPreferrenceConf {
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:1];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[UIColor darkGrayColor]];
    [SVProgressHUD setMinimumDismissTimeInterval:0.5];
   
}
#pragma mark --- ShareSDK 设置
-(void)setupShareSDK{
    [ShareSDK registerActivePlatforms:@[@(SSDKPlatformTypeSinaWeibo),
                                        @(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeQQ)]
                             onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo){
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                           appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx47d19897b35bae6f"
                                       appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1106934601"
                                      appKey:@"Vz2TM31SMx5ekNYG"
                                    authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
     }];
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
//        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            [[NSNotificationCenter defaultCenter]postNotificationName:@"payResult" object:resultDic];
        }];
    }else{
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    return YES;
    
}
// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            [[NSNotificationCenter defaultCenter]postNotificationName:@"payResult" object:resultDic];
        }];
    }else{
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)exitApplication {
    
    [UIView beginAnimations:@"exitApplication" context:nil];
    
    [UIView setAnimationDuration:0.5];
    
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.window cache:NO];
    
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    
    self.window.bounds = CGRectMake(0, 0, 0, 0);
    
    [UIView commitAnimations];
    
}

- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    if ([animationID compare:@"exitApplication"] == 0) {
        
        exit(0);
        
    }
    
}
@end
