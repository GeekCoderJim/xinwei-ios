//
//  BqsCrawlerCloudSDK.h
//  CrawlerCloudSDK
//
//  Created by 彭建波 on 2017/7/25.
//  Copyright © 2017年 baiqishi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BqsCrawlerCloudSDKDelegate<NSObject>

@required
-(void)onBqsCrawlerCloudResult:(NSString *)resultCode withDesc:(NSString *)resultDesc withServiceId:(int) serviceId;

@end

@interface BqsCrawlerCloudSDK : NSObject

//回调实例
@property (nonatomic,weak) id <BqsCrawlerCloudSDKDelegate> delegate;

//来源controller,必填
@property (nonatomic,weak) UIViewController *fromController;

//合作方编码，必填
@property (nonatomic,copy) NSString *partnerId;

//手机号码，必填
@property (nonatomic,copy) NSString *mobile;

//身份证号码，必填
@property (nonatomic,copy) NSString *certNo;

//用户姓名，必填
@property (nonatomic,copy) NSString *name;

//主题色
@property (nonatomic,strong) UIColor *themeColor;

//字体颜色，title color/title button color/
@property (nonatomic,strong) UIColor *foreColor;

//字体演示，运营商h5表单标题字体
@property (nonatomic,strong) UIColor *fontColor;

//进度条颜色
@property (nonatomic,strong) UIColor *progressBarColor;

//返回按钮图片
@property (nonatomic,strong) UIImage *backIndicatorImage;

//页面UI配置
@property (nonatomic,strong) NSDictionary *pageConfigDict;

/**
 SDK UI方式使用实例
 */
+(BqsCrawlerCloudSDK *)shared;

/**
 运营商数据采集
 */
-(void)loginMno;

/**
 淘宝数据采集（SDK方式）
 */
-(void)loginTaobao;

/**
 京东数据采集（SDK方式）
 */
-(void)loginJD;

/**
 支付宝数据采集
 */
-(void)loginAlipay;

/**
 学信网数据采集
 */
-(void)loginChsi;

/**
 公积金数据采集
 */
-(void)loginHFund;

/**
 QQ数据采集
 */
-(void)loginQQ;

/**
 微博数据采集
 */
-(void)loginWeibo;

/**
 领英数据采集
 */
-(void)loginLinkedIn;

/**
 脉脉数据采集
 */
-(void)loginMaimai;

/**
 滴滴出行数据采集
 */
-(void)loginDidi;

/**
 芝麻信用数据采集
 */
-(void)loginZm;
@end
