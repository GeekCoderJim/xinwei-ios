//shouye.png//
//  LoadMaskHelper.h
//  ZiPeiYi
//
//  Created by 刘成利 on 16/6/14.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    MainPage_NewUser, //主页未认证用户
    MainPage,          //  主页
    ExtendPage,        //  推广
    MorePage    //个人中心
} PageTye;

@interface LoadMaskHelper : NSObject

@property(assign,nonatomic)CGRect speciaFrame;
/*
    使用方法： [LoadMaskHelper showMaskWithType:HomePage onView:self.view delay:0.5];
*/


/**
 *  显示蒙版  （ 页面蒙版类型 要在那个view展示 延时几秒展示）
 */
+ (void)showMaskWithType:(PageTye)pageType delay:(NSTimeInterval)delay sepcialFrame:(CGRect)sepcialframe;
/**
 *  版本升级则重置蒙版，加载新蒙版
 */
+ (void)checkAPPVersion;

@end
