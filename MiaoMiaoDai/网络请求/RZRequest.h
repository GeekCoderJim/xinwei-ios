//
//  RZRequest.h
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/4/2.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "BaseHandler.h"

@interface RZRequest : BaseHandler
//获取用户认证状态
+(void)getUserVerifyStatus:(SuccessBlock)success;
//获取银行卡认证信息
+(void)getBankcardRZInfo:(SuccessBlock)success;
//用户基本信息
+(void)getUserInfoSuccess:(SuccessBlock)success;
//紧急联系人信息
+(void)getContactInfoSuccess:(SuccessBlock)success;
//上传用户基本信息
+(void)submitUserInfoWithParam:(NSDictionary *)param success:(SuccessBlock)success;
//上传紧急联系人信息
+(void)submitContactsInfoWithParam:(NSDictionary *)param success:(SuccessBlock)success;
//手机号码认证
+(void)phoneRZWithPhone:(NSString *)phone password:(NSString *)password success:(SuccessBlock)success;
//手机号码认证第二步
+(void)phoneRZSecondWithSmsCode:(NSString *)smsCode lastResultString:(NSString *)lastResult success:(SuccessBlock)success;
//通讯录认证
+(void)ContactRZWithJson:(NSString *)Json Success:(SuccessBlock)success;
//照片上传
+(void)upLoadImage:(UIImage *)upload_image Success:(SuccessBlock)success;

+(void)getSFRZImageSuccess:(SuccessBlock)success;

+(void)finishUploadImage:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
//获取银行类型
+(void)getBankCardTypeListSuccess:(SuccessBlock)success;

//获取分行
+ (void)bankBranches:(NSString*)bank_city andbank_type:(NSString *)bank_type success:(SuccessBlock)success failed:(FailedBlock)failed;

//绑定银行卡
+(void)uploadBandBankcardInfoWithParam:(NSDictionary *)param success:(SuccessBlock)success;
//手机认证重新发送验证码
+(void)resendMessageWithLastRusult:(NSString *)lastResult success:(SuccessBlock)success;
//改变认证状态
+(void)changeVerifyStatusWithType:(NSString *)type success:(SuccessBlock)success;

@end
