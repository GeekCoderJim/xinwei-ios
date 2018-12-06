//
//  YhbMethods.h
//  test
//
//  Created by Mac on 16/7/27.
//  Copyright © 2016年 yhb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
//#import "MBProgressHUD.h"
#import "MJRefresh.h"

#define  ScreenBounds           [[UIScreen mainScreen] bounds]                 //屏幕bounds
#define  SceeenSize             [[UIScreen mainScreen] bounds].size            //屏幕尺寸size
#define  ScreenWidth            [[UIScreen mainScreen] bounds].size.width      //屏幕宽度width
#define  ScreenHeight           [[UIScreen mainScreen] bounds].size.height     //屏幕高度height
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
//屏幕自适应
#define FB_FIX_SIZE_WIDTH(w) (((w) / 375.0) * ScreenWidth)
#define SET_FIX_SIZE_WIDTH (ScreenWidth /375.0)
#define AUTO(num)  num * SET_FIX_SIZE_WIDTH

#define  Frame(x,y,w,h)         CGRectMake((x), (y), (w), (h))
#define  Point(x,y)             CGPointMake((x), (y))
#define  Size(w,h)              CGSizeMake((w), (h))

#define  Font(font)             [UIFont fontWithName:@"Helvetica" size:(font)]
#define  Image(imageName)       [UIImage imageNamed:(imageName)]
#define  ImgWithColor(color)    [UIImage imageWithColor:(color)]
#define  URL(str)               [NSURL URLWithString:(str)]

//版本判断
#define     CurVersion          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define     Is_iOS_8            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define     Is_iOS_7            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define     Is_iOS_5            ([[[UIDevice currentDevice] systemVersion] floatValue] < 6)
#define     IS_BELOW_IOS9            ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0)

#define K_ALERT(_message_) UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:_message_ preferredStyle:  UIAlertControllerStyleAlert];\
[alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {\
}]];\
[self presentViewController:alert animated:true completion:nil];

#define ColorWithHex(s)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0green:(((s &0xFF00) >>8))/255.0blue:((s &0xFF))/255.0alpha:1.0]


// 判断是否是iPhone X
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone_PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

// 状态栏高度
#define STATUS_BAR_HEIGHT (iPhoneX ? 44.f : 20.f)
// 导航栏高度
#define NavHeight (iPhoneX ? 88.f : 64.f)
// tabBar高度
#define TAB_BAR_HEIGHT (iPhoneX ? (49.f+34.f) : 49.f)
// home indicator
#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)



typedef void(^successBlock)(id obj);
typedef void(^failedBlock)(NSError *error);
typedef void(^BackBlock)();
typedef void(^MainBlock)();

@interface YhbMethods : NSObject<UIAlertViewDelegate>
+(void)LoginTimeOut;
// ---------------------------------------------- 设置圆角
+(void)setView:(UIView *)view CornerRadius:(int)CornerRadius AndMasks:(BOOL)YesOrNo;
// ---------------------------------------------- 设置边框
+(void)setViewBorder:(UIView *)view BorderWidth:(int)width BorderColor:(UIColor *)color;
// ---------------------------------------------- 设置阴影
+(void)setViewShadow:(UIView *)view;
// ---------------------------------------------- 延迟执行
+ (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay;
// ---------------------------------------------- 回到主线程更新
+ (void)updateOnMainThread:(void(^)())mainBlock;
// ---------------------------------------------- 判断邮箱
+ (BOOL)isEmail:(NSString *)email;
// ---------------------------------------------- 判断号码
+ (BOOL)isPhoneNum:(NSString *)phone;
// ---------------------------------------------- 判断是否为空
+ (BOOL)isBlankString:(NSString *)string;
// ---------------------------------------------- 获取字符数
+(NSInteger)getByte:(NSString *)str;
// ---------------------------------------------- 写缓存
+(void)writeUserDefaults:(id)obj andKey:(NSString *)key;
// ---------------------------------------------- 写BOOL缓存
+(void)setBoolUserDefaults:(BOOL)YesOrNo andKey:(NSString *)key;
// ---------------------------------------------- 读缓存
+(id)readUserDefault:(NSString *)key;
// ---------------------------------------------- 读BOOL缓存
+(BOOL)readBOOLUserDefault:(NSString *)key;
// ---------------------------------------------- 移除缓存
+(void)removeUserDefault:(NSString *)key;
// ---------------------------------------------- 获取文本高度
+(CGFloat)textHeight:(NSString *)str
             textFont:(CGFloat)font
        andTextWidth:(CGFloat)width;
// ---------------------------------------------- 获取日期：到月
+(NSString *)getDateMonth;
// ---------------------------------------------- 获取日期：到天
+(NSString *)getDateDay;
// ---------------------------------------------- 获取日期：到分钟
+(NSString *)getDateMinute;
// ---------------------------------------------- 获取日期：只要年份
+(NSString *)getDateOnlyYear:(NSDate*)date;
// ---------------------------------------------- 获取日期：只要月份
+(NSString *)getDateOnlyMonth:(NSDate *)date;
// ---------------------------------------------- 随即颜色
+(UIColor *)getRandomColor;
//----------------------------------------------- AFN POST 异步请求（需导入AFNetworking）
+(void)AFNetWorkingPOSTRequstNetDataWithURL:(NSString *)url
                              andParameters:(NSDictionary *)param
                                andSucBlock:(successBlock)sucBlock
                             andFailedBlock:(failedBlock)failedblock;
+(void)AFNetWorkingPOSTRequstNetDataWithURL:(NSString *)url
                            andParameterStr:(NSString *)paramStr
                                andSucBlock:(successBlock)sucBlock
                             andFailedBlock:(failedBlock)failedblock;
+(void)AFNetWorkingPOSTRequstNetDataWithURL:(NSString *)url
                              andParameters:(NSDictionary *)param
                                   andToken:(NSString *)token
                                andSucBlock:(successBlock)sucBlock
                             andFailedBlock:(failedBlock)failedblock;
+(void)AFNetWorkingGETRequstNetDataWithURL:(NSString *)url
                             andParameters:(NSDictionary *)param
                               andSucBlock:(successBlock)sucBlock
                            andFailedBlock:(failedBlock)failedblock;

+(void)AFNetWorkingGETRequstNetDataWithURL:(NSString *)url
                             andParameters:(NSDictionary *)param
                                  andToken:(NSString *)token
                               andSucBlock:(successBlock)sucBlock
                            andFailedBlock:(failedBlock)failedbloc;
//----------------------------------------------- AFN 上传图片 异步请求（需导入AFNetworking）
//+(void)AFNUploadImageWithUrl:(NSString *)url
//                    andParam:(NSDictionary *)param
//                    andImage:(UIImage *)image
//                    andSuccessBlock:(SuccessBlock)sucblock;
//---------------------------------------------- 放大view动画
+(void)scaleAnimationFromScale:(float)scale1
                       toScale:(float)scale2
                  autoreverses:(BOOL)autoreverses
                   repeatCount:(int)repeatCount
                      duration:(float)duration
                       forView:(UIView *)aView
                   removeDelay:(float)delay;

//设置按钮
+(void)setButton:(UIButton *)sender
       withTitle:(NSString *)title
        withFont:(UIFont *)font
withTitleColor_n:(UIColor *)color_n
withTitleColor_s:(UIColor *)color_s
     withImage_n:(UIImage *)image_n
     withImage_s:(UIImage *)image_s
 withClickEffect:(BOOL)YesOrNO;

//获取字符串的长度
//+(CGSize)getButtonLableWidth:(UIButton *)button withTitleLabFont:(CGFloat)font;
+(CGSize)getTextWidth:(NSString *)str withTitleLabFont:(CGFloat)font;
+(NSMutableAttributedString *)chageSpaceWithTextString:(NSString *)textStr Space:(CGFloat)space;
//+(void)setHUD:(MBProgressHUD *)HUD;
//+(NSString *)getDay:(NSDate *)date;
//+(NSString *)getMMDDEEEWithNum:(NSInteger)n andDate:(NSDate *)date;
//+(NSString *)getMonthWithDate:(NSDate *)date AndNum:(NSInteger)n;
//+(NSString *)getQuarterWithDate:(NSDate *)date AndNum:(NSInteger)n;
//+(NSString *)getLeftQuarterWithDate:(NSDate *)date AndNum:(NSInteger)n;
//+(NSDate *)changeDateWithNum:(NSInteger)n;
//+(NSDate *)changeMonthWithDate:(NSDate *)date AndNum:(NSInteger)n;
//+ (NSString *)getWeekTime:(NSDate *)date;
//+ (NSString *)getLeftWeekTime:(NSDate *)date;
+(UIAlertController *)alertWithTitle:(NSString *)str;
+ (UIViewController *)getCurrentVC;
+ (NSString *)suoxie:(NSString *)chinese;
+ (NSString *)pinyin:(NSString *)chinese;
+ (BOOL)isInt:(NSString*)string;
+(NSMutableDictionary *)setNullClassForDic:(NSDictionary *)dic;
+(void)OpenChildQueen:(BackBlock)backblock MainQueen:(MainBlock)mainBlock;
+ (NSData *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
+ (UIColor *) colorWithHexString: (NSString *)color;
+(NSString *)getRandomNum;
//+(void)checkMoneyInput:(NSString *)formalStr LastStr:(NSString *)laststr;
+(void)checkMoneyInputWithTwoPoint:(NSString *)formalStr LastStr:(NSString *)laststr;
+(BOOL)validateMoney:(NSString *)money;

#pragma mark ---- MD5 加密方法
+ (NSString *)getMd5_32Bit_String:(NSString *)srcString;
//画虚线
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;
//导航栏变红
+(void)setNavRed:(UINavigationController *)nav;
//导航栏变白
+(void)setNavWhite:(UINavigationController *)nav;
+ (NSString *)getNetStatus;
+(CGFloat)getImageFillHeight:(UIImage *)image withImageViewWidth:(CGFloat)width;
+(void)setMJHeader:(MJRefreshGifHeader *)header;
+(void)setMJFooter:(MJRefreshAutoGifFooter *)footer;
+(NSMutableDictionary *)setDicNullClass:(NSDictionary *)dic;
+(NSDictionary *)dictRemoveNull:(NSDictionary *)dict;
+(void)setMJBackFooter:(MJRefreshBackGifFooter *)footer;
+(void)setMainButtonHighLight:(UIButton *)btn;
+(NSMutableAttributedString *)createStrAddImgAttributedStringWithText:(NSString *)textStr andTextColor:(UIColor *)strColor andStrFont:(CGFloat)strFont andImg:(UIImage *)iconImg andImgSize:(CGRect)imgCGRect atIndex:(NSUInteger)loc;
+ (NSString *)getDeviceName;
+ (NSString *)getSystemVersion;
@end

