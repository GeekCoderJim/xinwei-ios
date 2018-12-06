//
//  Conf.m
//  YoutuYunDemo
//
//  Created by Patrick Yang on 15/9/15.
//  Copyright (c) 2015年 Tencent. All rights reserved.
//

#import "Conf.h"

#define API_END_POINT @"http://api.youtu.qq.com/youtu"
#define API_VIP_END_POINT @"https://vip-api.youtu.qq.com/youtu"

@implementation Conf

+ (Conf *)instance
{
    static Conf *singleton = nil;
    if (singleton) {
        return singleton;
    }
    singleton = [[Conf alloc] init];
    return singleton;
}

-(instancetype)init{
    self = [super init];
//    _appId = @"10111807";      // 替换APP_ID
//    _secretId = @"AKIDkNo5AeSLxPgpmYPXaihXGogOuHnMe9KL";    // 替换SECRET_ID
//    _secretKey = @"CGcu2yoT0QfiZWO5b7XmoeJn5B9yfBWg";   // 替换SECRET_KEY
    _appId = @"10146600";      // 替换APP_ID
    _secretId = @"AKIDeFi5HJx1xjLnHoSsw04hQBpJafamtfKn";    // 替换SECRET_ID
    _secretKey = @"TpLySsDON9xdLsHUWM0d4TwSmtw30kIe";   // 替换SECRET_KEY
    _API_END_POINT = API_END_POINT;
    _API_VIP_END_POINT = API_VIP_END_POINT;
    return self;
}

@end
