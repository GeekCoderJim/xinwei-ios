//
//  AppJSObject.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/9/24.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "AppJSObject.h"

@implementation AppJSObject


-(void)invoke:(NSDictionary *)message{
    if (message) {
        [self.delegate invoke:message];
    }
    
}

@end
