//
//  HomeRequest.h
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/3/29.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "BaseHandler.h"

@interface HomeRequest : BaseHandler
//获取可借额度
+(void)getUserLoanLinesWithPhone:(NSString *)phone Success:(SuccessBlock)success;
//获取利息数据
+(void)getLixiWithMoney:(NSString *)money days:(NSString *)days success:(SuccessBlock)success;
//获取银行卡列表
+(void)getBankCardListSuccess:(SuccessBlock)success;
//银行卡认证
+(void)cardRZWithParam:(NSDictionary *)param success:(SuccessBlock)success;
//绑定银行卡
+(void)bandBankCardWithData:(NSDictionary *)param success:(SuccessBlock)success;
//获取消息列表
+(void)getMessageListSuccess:(SuccessBlock)success;
//借款
+(void)borrowWithParam:(NSMutableDictionary *)param Success:(SuccessBlock)success;

@end
