//
//  BQSPublicRZViewController.h
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/8/1.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "BaseViewController.h"


/*
 *白骑士认证通用
 *
 *type:  alipay-支付宝   qzone-QQ空间  linkedin-linkedin   weibo-新浪微博
 *
 */

typedef enum : NSUInteger {
    alipay = 0,
    qzone = 1,
    linkedin = 2,
    weibo = 3
} RZType;
@interface BQSPublicRZViewController : BaseViewController

@property(assign,nonatomic)RZType rzType;
@property(strong,nonatomic)NSString * titleStr;


@end
