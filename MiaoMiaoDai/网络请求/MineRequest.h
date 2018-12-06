//
//  MineRequest.h
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/4/4.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "BaseHandler.h"

@interface MineRequest : BaseHandler
//获取账单记录列表
+(void)getOrderListSuccess:(SuccessBlock)success;
//获取借款记录列表
+(void)getRecordListSuccess:(SuccessBlock)success;
//重置登录密码
+(void)resetLoginPasswordWithPhone:(NSString *)phone NewPassword:(NSString *)password success:(SuccessBlock)success;//重置交易密码
+(void)resetTradePasswordWithNewPassword:(NSString *)password success:(SuccessBlock)success;
@end
