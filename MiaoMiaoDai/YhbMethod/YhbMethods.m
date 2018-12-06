//
//  YhbMethods.m
//  test
//
//  Created by Mac on 16/7/27.
//  Copyright © 2016年 yhb. All rights reserved.
//

#import "YhbMethods.h"
#import <CommonCrypto/CommonDigest.h>
#import "UIImage+Extension.h"
#import "sys/utsname.h"

@implementation YhbMethods

+(void)LoginTimeOut{
    [YhbMethods setBoolUserDefaults:NO andKey:@"isLogin"];
    [YhbMethods removeUserDefault:@"account"];
    [YhbMethods removeUserDefault:@"password"];
    [YhbMethods removeUserDefault:@"userInfo"];
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=9.0) {
        UIAlertController *alertcontrol=[UIAlertController alertControllerWithTitle:@"提示" message:@"登录超时，请重新登录" preferredStyle:1];
        UIAlertAction *aciton=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
           
        }];
        UIAlertAction *action1=[UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
            LoginViewController *vc=[LoginViewController new];
            UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
            nav.navigationBar.translucent=NO;
            nav.navigationBar.barTintColor=[YhbMethods colorWithHexString:COLOR_MAIN];
            nav.navigationBar.tintColor=[UIColor whiteColor];
            [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
            [[UIApplication sharedApplication]keyWindow].rootViewController=nav;
        }];
        [alertcontrol addAction:aciton];
        [alertcontrol addAction:action1];

       
        [[YhbMethods getCurrentVC]presentViewController:alertcontrol animated:YES completion:nil];
    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"登录超时，请重新登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去登录", nil];
        [alert show];
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
       
        LoginViewController *vc=[LoginViewController new];
        UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
        nav.navigationBar.translucent=NO;
        nav.navigationBar.barTintColor=[YhbMethods colorWithHexString:COLOR_MAIN];
        nav.navigationBar.tintColor=[UIColor whiteColor];
        [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        [[UIApplication sharedApplication]keyWindow].rootViewController=nav;
    }
}

#pragma mark ---------------------------------------------- 视图圆角
+(void)setView:(UIView *)view CornerRadius:(int)CornerRadius AndMasks:(BOOL)YesOrNo{
    view.layer.cornerRadius=CornerRadius;
    view.layer.masksToBounds=YesOrNo;
}
#pragma mark ---------------------------------------------- 视图边框
+(void)setViewBorder:(UIView *)view BorderWidth:(int)width BorderColor:(UIColor *)color{
    view.layer.borderWidth=width;
    view.layer.borderColor=color.CGColor;
}
#pragma mark ---------------------------------------------- 视图阴影
+(void)setViewShadow:(UIView *)view{
    view.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    view.layer.shadowOffset = CGSizeMake(0,1);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    view.layer.shadowOpacity = 0.3;//阴影透明度，默认0
    view.layer.shadowRadius = 1;//阴影半径，默认3
}

#pragma mark ---------------------------------------------- 延迟执行
+ (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}
#pragma mark ---------------------------------------------- 在主线程（延迟）执行
+ (void)updateOnMainThread:(void(^)())mainBlock
{
    dispatch_async(dispatch_get_main_queue(), mainBlock);
}


#pragma mark ---------------------------------------------- 放大view动画
+(void)scaleAnimationFromScale:(float)scale1
                       toScale:(float)scale2
                  autoreverses:(BOOL)autoreverses
                   repeatCount:(int)repeatCount
                      duration:(float)duration
                       forView:(UIView *)aView
                   removeDelay:(float)delay
{
    //缩放
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:scale1];
    scaleAnimation.toValue = [NSNumber numberWithFloat:scale2];
    scaleAnimation.duration = duration;
    scaleAnimation.autoreverses = autoreverses;
    scaleAnimation.repeatCount = repeatCount;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [aView.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    
//    [YhbMethods performBlock:^{
//        [aView.layer removeAllAnimations];
//    } afterDelay:delay];
}

 #pragma mark ---------------------------------------------- 判断邮箱格式
 + (BOOL)isEmail:(NSString *)email
 {
 NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
 NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
 return [emailTest evaluateWithObject:email];
 }
 #pragma mark ---------------------------------------------- 判断手机号码
 + (BOOL)isPhoneNum:(NSString *)phone
 {
 NSString *Regex = @"(13[0-9]|14[57]|15[012356789]|18[012356789])\\d{8}";
 NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
 return [mobileTest evaluateWithObject:phone];
 }

 #pragma mark ---------------------------------------------- 判断字符串是否为空格或者为空
+ (BOOL)isBlankString:(NSString *)string{
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }

    return NO;
}
+(NSMutableDictionary *)setNullClassForDic:(NSDictionary *)dic{
    NSMutableDictionary *dict=[NSMutableDictionary new];
    dict = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSArray *array=[dict allKeys];
    for (int i = 0; i<array.count; i++) {
        if ([dict[array[i]] isKindOfClass:[NSNull class]]) {
            [dict setValue:@"" forKey:array[i]];
        }else if ([dict[array[i]] isKindOfClass:[NSDictionary class]]){
           dict[array[i]]= [YhbMethods setNullClassForDic:dict[array[i]]];
        }
//        else if ([dict[array[i]] isKindOfClass:[NSArray class]]){
//            NSMutableArray *itemArray=[NSMutableArray arrayWithObject:dict[array[i]]];
//            for (int j = 0 ; j<itemArray.count; j++) {
//                NSDictionary *dic=itemArray[j];
//                [itemArray replaceObjectAtIndex:j withObject:[YhbMethods setNullClassForDic:dic]];
//            }
//            dict[array[i]]=itemArray;
//        }
    }
                                
    return dict;
}
+(NSMutableDictionary *)setDicNullClass:(NSDictionary *)dic{
    NSMutableDictionary *dict=[NSMutableDictionary new];
    dict = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSArray *array=[dict allKeys];
    for (int i = 0; i<array.count; i++) {
        if ([dict[array[i]] isKindOfClass:[NSNull class]]) {
            [dict setValue:@"暂无数据" forKey:array[i]];
        }
    }
    return dict;
}
+(NSDictionary *)dictRemoveNull:(NSDictionary *)dict{
    if (dict ==nil || [dict isEqual: [NSNull null]]) {
        dict=[NSDictionary new];
    }
    return dict;
}

//获取字节数
+(NSInteger)getByte:(NSString *)str
{
    NSInteger byteTotal = 0;
    if (str) {
        for (int i=0; i<str.length; i++) {
            //获取每个字符
            NSRange range = NSMakeRange(i, 1);
            NSString *subString=[str substringWithRange:range];
            //将字符转为C类型
            const char *cString=[subString UTF8String];
            if (strlen(cString)==3)//因为汉字在OC占三个字节
            {
                byteTotal += 2; //因为人们习惯性认为汉字为2字节
            }else if (strlen(cString) == 1)//这是字母
            {
                byteTotal +=1;
            }
            
        }
    }
    return byteTotal;
}

+(UIColor *)getRandomColor{
   UIColor *color = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:0.5];
    return color;
}

+(CGFloat)textHeight:(NSString *)str
            textFont:(CGFloat)font
        andTextWidth:(CGFloat)width
{
    return  [str boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size.height;
}


+(void)writeUserDefaults:(id)obj andKey:(NSString *)key{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    [userD setObject:obj forKey:key];
    [userD synchronize];
}

+(void)setBoolUserDefaults:(BOOL)YesOrNo andKey:(NSString *)key{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    [userD setBool:YesOrNo forKey:key];
    [userD synchronize];
}

+(id)readUserDefault:(NSString *)key
{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    
    return [userD objectForKey:key];
}
+(BOOL)readBOOLUserDefault:(NSString *)key
{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    
    return [userD boolForKey:key];
}
+(void)removeUserDefault:(NSString *)key{
    NSUserDefaults *userD=[NSUserDefaults standardUserDefaults];
    [userD removeObjectForKey:key];
}

+(NSString *)getDateMonth{
    NSDate *nowDate=[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月"];
    NSString *currentDateString = [dateFormatter stringFromDate:nowDate];
    return currentDateString;
}

+(NSString *)getDateDay{
    NSDate *nowDate=[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *currentDateString = [dateFormatter stringFromDate:nowDate];
    return currentDateString;
}

+(NSString *)getDateMinute{
    NSDate *nowDate=[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *currentDateString = [dateFormatter stringFromDate:nowDate];
    return currentDateString;
}
+(NSString *)getDateOnlyYear:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *currentDateString = [dateFormatter stringFromDate:date];
    return currentDateString;
}
+(NSString *)getDateOnlyMonth:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    NSString *currentDateString = [dateFormatter stringFromDate:date];
    return currentDateString;
}


//设置按钮
+(void)setButton:(UIButton *)sender
       withTitle:(NSString *)title
        withFont:(UIFont *)font
withTitleColor_n:(UIColor *)color_n
withTitleColor_s:(UIColor *)color_s
     withImage_n:(UIImage *)image_n
     withImage_s:(UIImage *)image_s
 withClickEffect:(BOOL)YesOrNO{
    [sender setTitle:title forState:UIControlStateNormal];
    sender.titleLabel.font=font;
    [sender setTitleColor:color_n forState:UIControlStateNormal];
    [sender setTitleColor:color_s forState:UIControlStateSelected];
    [sender setImage:image_n forState:UIControlStateNormal];
    [sender setImage:image_s  forState:UIControlStateSelected];
    sender.adjustsImageWhenHighlighted = YesOrNO;
}

//获取按钮标题的长度
//+(CGSize)getButtonLableWidth:(UIButton *)button withTitleLabFont:(CGFloat)font{
//    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
//    CGSize textSize = [button.titleLabel.text boundingRectWithSize:CGSizeMake(button.size.width, button.size.height) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
//    return textSize;
//}
+(CGSize)getTextWidth:(NSString *)str withTitleLabFont:(CGFloat)font{
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGSize textSize = [str boundingRectWithSize:CGSizeMake(ScreenWidth/4-10, 30) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;;
    return textSize;
}

+(void)AFNetWorkingPOSTRequstNetDataWithURL:(NSString *)url
                              andParameters:(NSDictionary *)param
                                andSucBlock:(successBlock)sucBlock
                             andFailedBlock:(failedBlock)failedblock
{
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"text/xml",nil];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"token-id"];
    

    [manager POST:url parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        sucBlock(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        failedblock(error);
    }];
}


+(void)AFNetWorkingPOSTRequstNetDataWithURL:(NSString *)url
                              andParameterStr:(NSString *)paramStr
                                andSucBlock:(successBlock)sucBlock
                             andFailedBlock:(failedBlock)failedblock
{
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"text/xml",nil];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"token-id"];
    
    
    [manager POST:url parameters:paramStr success:^(NSURLSessionDataTask *task, id responseObject) {
        sucBlock(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        failedblock(error);
    }];
}
+(void)AFNetWorkingPOSTRequstNetDataWithURL:(NSString *)url
                              andParameters:(NSDictionary *)param
                                   andToken:(NSString *)token
                                andSucBlock:(successBlock)sucBlock
                             andFailedBlock:(failedBlock)failedblock
{
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"text/xml",nil];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    
  
    [manager POST:url parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        sucBlock(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
      [AppUtils showErrorMessage:@"请求失败！"];
        failedblock(error);
    }];
}

+(void)AFNetWorkingGETRequstNetDataWithURL:(NSString *)url
                              andParameters:(NSDictionary *)param
                                andSucBlock:(successBlock)sucBlock
                             andFailedBlock:(failedBlock)failedblock
{
    
    
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"text/xml",nil];
    
    [manager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [AppUtils showErrorMessage:@"请求出错"];
    }];
}

+(void)AFNetWorkingGETRequstNetDataWithURL:(NSString *)url
                             andParameters:(NSDictionary *)param
                                  andToken:(NSString *)token
                               andSucBlock:(successBlock)sucBlock
                            andFailedBlock:(failedBlock)failedblock
{
    
    
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"text/xml",nil];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];

    [manager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [AppUtils showErrorMessage:@"请求出错"];
    }];
}
//+(void)AFNUploadImageWithUrl:(NSString *)url andParam:(NSDictionary *)param andImage:(UIImage *)image andSuccessBlock:(SuccessBlock)sucblock{
//    //创建管理者
//    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
//    //指定返回数据
//    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"image/png",nil];
//    [manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        formatter.dateFormat = @"yyyyMMddHHmmss";
//        NSString *str = [formatter stringFromDate:[NSDate date]];
//        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
//        
//        NSData *newImg=UIImageJPEGRepresentation(image, 0.5);
//        [UIImage imageWithData:newImg];
//        if (newImg !=nil) {
//            [formData appendPartWithFileData:newImg name:@"image" fileName:fileName mimeType:@"image/jpg"];
//        }
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        sucblock(responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"请求失败 === %@",error);
//    }];
//
//    
//}
//

+(UIAlertController *)alertWithTitle:(NSString *)str{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ac=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ac];
    return alert;
}

//+(void)setHUD:(MBProgressHUD *)HUD{
//    HUD.label.text = @"加载中...";
//    HUD.bezelView.color=[UIColor blackColor];
//    HUD.label.textColor=[UIColor whiteColor];
//    if (IS_BELOW_IOS9) {
//        HUD.bezelView.color=[UIColor lightGrayColor];
//        HUD.label.textColor=[UIColor darkGrayColor];
//    }
//    
//}


+ (UIViewController *)getCurrentVC{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    if ([window subviews].count>0) {
        UIView *frontView = [[window subviews] objectAtIndex:0];
        id nextResponder = [frontView nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
            result = nextResponder;
        else
            result = window.rootViewController;
    }
    
    return result;
}

////获取View所在的Viewcontroller方法
//- (UIViewController *)viewController {
//    for (UIView* next = [self superview]; next; next = next.superview) {
//        UIResponder *nextResponder = [next nextResponder];
//        if ([nextResponder isKindOfClass:[UIViewController class]]) {
//            return (UIViewController *)nextResponder;
//        }
//    }
//    return nil;
//}

//字符串改拼音 --- 搜索用
+ (NSString *)pinyin:(NSString *)chinese
{
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    return [pinyin uppercaseString] ;
}
//字符串改拼音缩写 --- 搜索用
+ (NSString *)suoxie:(NSString *)chinese
{
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    NSArray *arr=[[pinyin uppercaseString] componentsSeparatedByString:@" "];
    NSRange range={0,1};
    NSString *suoxie=[NSString new];
    for (int i=0; i<arr.count; i++) {
        NSString *str1=[arr[i] substringWithRange:range];
        suoxie=[NSString stringWithFormat:@"%@%@",suoxie,str1];
    }
    return suoxie ;
}
//字间距
+(NSMutableAttributedString *)chageSpaceWithTextString:(NSString *)textStr Space:(CGFloat)space
{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:textStr];
    long number = space;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number);
    [attributedStr addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[attributedStr length])];
    CFRelease(num);
    return attributedStr;
}
//将字符串时间转化成时间戳
+(NSString *)timeIntervalFormDataString:(NSString *)dateStr{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    NSDate* date = [formater dateFromString:dateStr];
    //时间转时间戳的方法:
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return timeSp;
}
//时间戳改为时间
+(NSString *)dataStringFormTimeInterval:(NSString *)timeIntervalStr{
    NSTimeInterval time=[timeIntervalStr doubleValue];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *timeStr= [dateFormatter stringFromDate:confromTimesp];
    return timeStr;
}

//时间转换成几小时前
+ (NSString *) compareCurrentTime:(NSString *)str
{
    
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = - timeInterval;
    //标准时间和北京时间差8个小时
    //    timeInterval = timeInterval - 8*60*60;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}

#pragma mark ---- MD5 加密方法
+ (NSString *)getMd5_32Bit_String:(NSString *)srcString{
    const char *cStr = [srcString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH *2];
    for(int i =0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return result;
}
+ (BOOL)isInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}
+(void)OpenChildQueen:(BackBlock)backblock MainQueen:(MainBlock)mainBlock{
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        backblock();

        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        //异步返回主线程，根据获取的数据，更新UI
        dispatch_async(mainQueue, ^{
            mainBlock();
        });
    });
}

+ (NSData *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
{
    newSize =  CGSizeMake(image.size.width/5, image.size.height/5);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImageJPEGRepresentation(newImage, 0.5);
}

#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+(NSString *)getRandomNum{
    NSString *str=[NSString new];
    for (int i = 0; i<4; i++) {
        int x = arc4random() % 9;
        str=[NSString stringWithFormat:@"%@%d",str,x];
    }
    return str;
}

//两个小数点
+(void)checkMoneyInputWithTwoPoint:(NSString *)formalStr LastStr:(NSString *)laststr{
    //如果没点 且 最后一位为点
    if ([formalStr rangeOfString:@"."].location != NSNotFound && [laststr isEqualToString:@"."]) {
        
    }else if        //如果有点 且 最后一位为点
        ([laststr isEqualToString:@"."] && [formalStr rangeOfString:@"."].location == NSNotFound){
            formalStr = [formalStr stringByAppendingString:laststr];
        }else{
            NSString *priceStr1 =[formalStr stringByAppendingString:laststr];
            priceStr1 = [priceStr1 stringByReplacingOccurrencesOfString:@"￥" withString:@""];
            if ([YhbMethods validateMoney:priceStr1]) {
                formalStr = [formalStr stringByAppendingString:laststr];
            }else{
                [AppUtils showErrorMessage:@"最多精确到小数点后两位"];
            }
        }
}
//钱是否可用
+(BOOL)validateMoney:(NSString *)money
{
    NSString *phoneRegex = @"^[0-9]+(\\.[0-9]{1,2})?$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:money];
}


//画虚线
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

+(void)setNavRed:(UINavigationController *)nav{
    nav.navigationBar.barTintColor=[YhbMethods colorWithHexString:COLOR_MAIN];
    nav.navigationBar.tintColor=[UIColor whiteColor];
    [nav.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];

}
+(void)setNavWhite:(UINavigationController *)nav{
    nav.navigationBar.barTintColor=[UIColor whiteColor];
    nav.navigationBar.tintColor=[YhbMethods colorWithHexString:COLOR_MAIN];
    [nav.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[YhbMethods colorWithHexString:COLOR_MAIN],NSForegroundColorAttributeName,nil]];
}


+ (NSString *)getNetStatus{
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *application = [UIApplication sharedApplication];
    
    NSArray *children;
    // 不能用 [[self deviceVersion] isEqualToString:@"iPhone X"] 来判断，因为模拟器不会返回 iPhone X
    if ([[application valueForKeyPath:@"_statusBar"] isKindOfClass:NSClassFromString(@"UIStatusBar_Modern")]) {
        children = [[[[application valueForKeyPath:@"_statusBar"] valueForKeyPath:@"_statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    } else {
        children = [[[application valueForKeyPath:@"_statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    }
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    
    NSString *stateString = @"wifi";
    switch (type) {
        case 0:
            stateString = @"notReachable";
            break;
        case 1:
            stateString = @"2G";
            break;
        case 2:
            stateString = @"3G";
            break;
        case 3:
            stateString = @"4G";
            break;
        case 4:
            stateString = @"LTE";
            break;
        case 5:
            stateString = @"wifi";
            break;
        default:
            break;
    }
    
    return stateString;
}
+(CGFloat)getImageFillHeight:(UIImage *)image withImageViewWidth:(CGFloat)width{
    CGFloat height;
    if (image.size.width > width) {
        height =image.size.height/(image.size.width/width);
    }else if (image.size.width < width){
        height =image.size.height/(image.size.width/width);

    }else{
        height = image.size.height;
    }
    return height;
}
+(void)setMJHeader:(MJRefreshGifHeader *)header{
    NSMutableArray *ImageArr=[NSMutableArray new];
    for (int i = 0 ; i<10; i++) {
        NSString *str=[NSString stringWithFormat:@"刷新%d",i];
        UIImage *image=[UIImage imageNamed:str];
        [ImageArr addObject:image];
    }
    [header setImages:ImageArr forState:MJRefreshStateRefreshing];
    [header setImages:ImageArr forState:MJRefreshStateIdle];
    [header setImages:ImageArr forState:MJRefreshStatePulling];
    header.lastUpdatedTimeLabel.hidden= YES;//如果不隐藏这个会默认 图片在最左边不是在中间 header.stateLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    header.backgroundColor=[UIColor groupTableViewBackgroundColor];
}
+(void)setMJFooter:(MJRefreshAutoGifFooter *)footer{
    NSMutableArray *ImageArr=[NSMutableArray new];
    for (int i = 0 ; i<10; i++) {
        NSString *str=[NSString stringWithFormat:@"刷新%d",i];
        UIImage *image=[UIImage imageNamed:str];
        [ImageArr addObject:image];
    }
    [footer setImages:ImageArr forState:MJRefreshStateRefreshing];
    [footer setImages:ImageArr forState:MJRefreshStateIdle];
    [footer setImages:ImageArr forState:MJRefreshStatePulling];
    footer.contentMode=UIViewContentModeCenter;
    
//    footer.lastUpdatedTimeLabel.hidden= YES;//如果不隐藏这个会默认 图片在最左边不是在中间 header.stateLabel.hidden = YES;
//    footer.stateLabel.hidden = YES;
}
+(void)setMJBackFooter:(MJRefreshBackGifFooter *)footer{
    NSMutableArray *ImageArr=[NSMutableArray new];
    for (int i = 0 ; i<10; i++) {
        NSString *str=[NSString stringWithFormat:@"刷新%d",i];
        UIImage *image=[UIImage imageNamed:str];
        [ImageArr addObject:image];
    }
    [footer setImages:ImageArr forState:MJRefreshStateRefreshing];
    [footer setImages:ImageArr forState:MJRefreshStateIdle];
    [footer setImages:ImageArr forState:MJRefreshStatePulling];
    footer.contentMode=UIViewContentModeCenter;
    
    //    footer.lastUpdatedTimeLabel.hidden= YES;//如果不隐藏这个会默认 图片在最左边不是在中间 header.stateLabel.hidden = YES;
    //    footer.stateLabel.hidden = YES;
}


+(void)setMainButtonHighLight:(UIButton *)btn{
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[UIImage imageWithColor:[YhbMethods colorWithHexString:COLOR_BIG_BUTTON] size:CGSizeMake(ScreenWidth-AUTO(120), AUTO(44))] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:[YhbMethods colorWithHexString:COLOR_MAIN] size:CGSizeMake(ScreenWidth-AUTO(120), AUTO(44))] forState:UIControlStateHighlighted];
}

+(NSMutableAttributedString *)createStrAddImgAttributedStringWithText:(NSString *)textStr andTextColor:(UIColor *)strColor andStrFont:(CGFloat)strFont andImg:(UIImage *)iconImg andImgSize:(CGRect)imgCGRect atIndex:(NSUInteger)loc{
    NSString *str=[NSString stringWithFormat:@"%@",textStr];
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:str];
    //富文本设置---设置字体大小
    [attriStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:strFont]} range:NSMakeRange(0, str.length)];
    [attriStr addAttribute:NSForegroundColorAttributeName value:strColor range:NSMakeRange(0, str.length)];
    NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
    // 表情图片
    attchImage.image = iconImg;
    // 设置图片大小
    attchImage.bounds = imgCGRect;
    NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
    [attriStr insertAttributedString:stringImage atIndex:loc];
    
    return attriStr;
}
+ (NSString *)getDeviceName
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"])   return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,4"])   return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([deviceString isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,11"])    return @"iPad 5 (WiFi)";
    if ([deviceString isEqualToString:@"iPad6,12"])    return @"iPad 5 (Cellular)";
    if ([deviceString isEqualToString:@"iPad7,1"])     return @"iPad Pro 12.9 inch 2nd gen (WiFi)";
    if ([deviceString isEqualToString:@"iPad7,2"])     return @"iPad Pro 12.9 inch 2nd gen (Cellular)";
    if ([deviceString isEqualToString:@"iPad7,3"])     return @"iPad Pro 10.5 inch (WiFi)";
    if ([deviceString isEqualToString:@"iPad7,4"])     return @"iPad Pro 10.5 inch (Cellular)";
    
    if ([deviceString isEqualToString:@"AppleTV2,1"])    return @"Apple TV 2";
    if ([deviceString isEqualToString:@"AppleTV3,1"])    return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV3,2"])    return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV5,3"])    return @"Apple TV 4";
    
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceString;
}

+ (NSString *)getSystemVersion {
    
    return [UIDevice currentDevice].systemVersion;
    
}
@end
