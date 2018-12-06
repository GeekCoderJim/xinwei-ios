//
//  PublicRequest.h
//  MiaoMiaoDai
//
//  Created by Mac on 2018/5/21.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "BaseHandler.h"

@interface PublicRequest : BaseHandler
+(void)getAppUpdateInfo:(SuccessBlock)success;
+(void)getQuickPayWebHost:(SuccessBlock)success;
+(void)getShareInfo:(SuccessBlock)success;
+(void)uploadLocationInfoAndDeviceInfo:(NSDictionary *)dict;
+(void)getJTWebhOST:(successBlock)success;
+(void)getWxPayOrder:(NSString *)orderID success:(successBlock)success;;
+(void)getAliPayOrder:(NSString *)orderID success:(successBlock)success;

//阿里实人认证
+(void)getHeaderData:(NSData *)data url:(NSString *)urlStr success:(successBlock)success;
+(void)getDataWithurl:(NSString *)urlStr success:(successBlock)success;
@end
