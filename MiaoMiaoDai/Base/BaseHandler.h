//
//  BaseHandler.h
//  zlydoc-iphone
//  BaseHandler : Every subclass handler should extends
//  Created by Ryan on 14-6-25.
//  Copyright (c) 2014年 zlycare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIConfig.h"
/**
 *  Handler处理完成后调用的Block
 */
//typedef void (^CompleteBlock)();

/**
 *  Handler处理异常时调用的Block
 */
//typedef void (^ExceptionBlock)();

/**
 *  Handler处理成功时调用的Block
 */
typedef void (^SuccessBlock)(id obj);

/**
 *  Handler处理失败时调用的Block
 */
typedef void (^FailedBlock)(id obj);

@interface BaseHandler : NSObject


+ (NSString *)requestUrlWithPath:(NSString *)path;

@end
