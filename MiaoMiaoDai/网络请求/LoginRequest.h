//
//  LoginRequest.h
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/3/28.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "BaseHandler.h"

@interface LoginRequest : BaseHandler
+(void)loginWithPhoneNumber:(NSString *)phone password:(NSString *)password andCompanyId :(NSInteger) CompanyId success:(SuccessBlock)success;

+(void)registWithPhoneNumber:(NSString *)phone password:(NSString *)password tradepassword:(NSString *)tradepassword success:(SuccessBlock)success;

+(void)getResUserListWithPhoneNum:(NSString *)phone Success:(SuccessBlock)success;
@end
