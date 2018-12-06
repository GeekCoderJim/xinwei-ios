//
//  AppUtils.h
//  zlydoc+iphone
//
//  Created by Ryan on 14+5+23.
//  Copyright (c) 2014年 zlycare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUtils : NSObject

/********************** System Utils ***********************/
//弹出UIAlertView
+ (void)showAlertMessage:(NSString *)msg;
//关闭键盘
+ (void)closeKeyboard;
//获取MD5加密后字符串
+ (NSString *)md5FromString:(NSString *)string;
////SHA-1加密
+ (NSString *)sha1FromString:(NSString*)string;
//获取随机生成的字符串
+ (NSString*)getRandomString:(int)count;
//UTF8转码
+ (NSString *)encodeToPercentEscapeString:(NSString*)string;
//判断字符串是否为空
+ (NSString*) isBlankString:(NSString*)string;
//去除字符串中的空格
+ (NSString*)stringRemovalSpaceWith:(NSString*)string;
//NSDate转NSString
+ (NSString *)stringFromDates:(NSDate *)date;
//NSDate转NSString
+ (NSString *)stringFromDates2:(NSDate *)date;
/******* UITableView & UINavigationController Utils *******/


/********************* SVProgressHUD **********************/
//弹出提示框
+ (void)showTipsMessage:(NSString *)message;
//弹出操作错误信息提示框
+ (void)showErrorMessage:(NSString *)message;
//弹出操作成功信息提示框
+ (void)showSuccessMessage:(NSString *)message;
//弹出加载提示框
+ (void)showProgressMessage:(NSString *) message;
+ (void)showWithStatusMessage:(NSString *) message;
//取消弹出框
+ (void)dismissHUD;

/********************** NSDate Utils ***********************/
//根据指定格式将NSDate转换为NSString
+ (NSString *)stringFromDate:(NSDate *)date formatter:(NSString *)formatter;
//根据指定格式将NSString转换为NSDate
+ (NSDate *)dateFromString:(NSString *)dateString formatter:(NSString *)formatter;



/********************* Verification Utils **********************/
//验证手机号码合法性（正则）
+ (BOOL)checkPhoneNumber:(NSString *)phoneNumber;
//是否为浮点数（正则）
+ (BOOL) checkDouble:(NSString *)string;
//验证身份证号合法性（正则）
+ (BOOL) checkIdentityCard:(NSString*)string;
//验证邮箱合法性（正则）
+ (BOOL)checkEmail:(NSString *)email;

//条件
+ (float) judgePasswordStrength:(NSString*) _password;
//银行卡
+(BOOL) checkCardNo:(NSString*) cardNo;


@end
