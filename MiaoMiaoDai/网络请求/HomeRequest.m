//
//  HomeRequest.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/3/29.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "HomeRequest.h"

@implementation HomeRequest
//获取可借额度
+(void)getUserLoanLinesWithPhone:(NSString *)phone Success:(SuccessBlock)success{
    NSMutableDictionary *dic=[NSMutableDictionary new];
    UserEntity *user=[UserEntity shareUserEntity];
    [dic setValue:@"2" forKey:@"apiVersion"];
    
    NSString *url = [super requestUrlWithPath:USER_LOAN_LINES];
    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@",url,phone];

//    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:urlWithPhoneNumber andParameters:dic andToken:user.token andSucBlock:^(id obj) {
//         NSLog(@"%@",obj);
//        if ([obj[@"code"]isEqualToString:SUCCESS]) {
//            success(obj[@"content"]);
//        }else if ([obj[@"code"]isEqualToString:TOKEN_ERROR]||[obj[@"code"]isEqualToString:NO_LOGIN]){
//            [YhbMethods LoginTimeOut];
//        }else{
//            [AppUtils showAlertMessage:obj[@"msg"]];
//        }
//    } andFailedBlock:^(NSError *error) {
//
//    }];
    
    [YhbMethods AFNetWorkingGETRequstNetDataWithURL:urlWithPhoneNumber andParameters:dic andToken:user.token andSucBlock:^(id obj) {
        NSLog(@"%@",obj);
        if ([obj[@"code"]isEqualToString:SUCCESS]) {
            success(obj[@"content"]);
        }else if ([obj[@"code"]isEqualToString:TOKEN_ERROR]||[obj[@"code"]isEqualToString:NO_LOGIN]){
            [YhbMethods LoginTimeOut];
        }else{
            [AppUtils showAlertMessage:obj[@"msg"]];
        }
    } andFailedBlock:^(NSError *error) {
        
    }];
    
    
}
//获取利息数据
+(void)getLixiWithMoney:(NSString *)money days:(NSString *)days success:(SuccessBlock)success{
    NSMutableDictionary *dic=[NSMutableDictionary new];
    UserEntity *user=[UserEntity shareUserEntity];
    [dic setValue:@"2" forKey:@"apiVersion"];
    [dic setValue:money forKey:@"money"];
    [dic setValue:days forKey:@"days"];
    
    NSString *url = [super requestUrlWithPath:BORROW_OWE];
    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@",url,user.phoneNumber];
    
    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:urlWithPhoneNumber andParameters:dic andToken:user.token andSucBlock:^(id obj) {
        NSLog(@"%@",obj);
        if ([obj[@"code"]isEqualToString:SUCCESS]) {
            success(obj[@"content"]);
        
        }else if ([obj[@"code"]isEqualToString:TOKEN_ERROR]||[obj[@"code"]isEqualToString:NO_LOGIN]){
            [YhbMethods LoginTimeOut];
        }
        else{
            [AppUtils showAlertMessage:obj[@"msg"]];
        }
    } andFailedBlock:^(NSError *error) {
        
    }];
}
//获取银行卡列表
+(void)getBankCardListSuccess:(SuccessBlock)success{
    NSMutableDictionary *dic=[NSMutableDictionary new];
    [dic setValue:@"2" forKey:@"apiVersion"];
    UserEntity *user=[UserEntity shareUserEntity];
    
    NSString *url = [super requestUrlWithPath:GET_BANKCARD_LIST];
    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@",url,user.phoneNumber];
    
    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:urlWithPhoneNumber andParameters:dic andToken:user.token andSucBlock:^(id obj) {
        success(obj);
    } andFailedBlock:^(NSError *error) {
        
    }];

}
//银行卡认证
+(void)cardRZWithParam:(NSDictionary *)param success:(SuccessBlock)success{
    NSMutableDictionary *dic=[NSMutableDictionary new];
    UserEntity *user=[UserEntity shareUserEntity];
    [dic setValue:param[@"bankCardNumber"] forKey:@"bankCardNumber"];
    [dic setValue:param[@"idCardNumber"] forKey:@"idCardNumber"];
    [dic setValue:param[@"realName"] forKey:@"realName"];
    [dic setValue:@"2" forKey:@"apiVersion"];

    
    NSString *url = [super requestUrlWithPath:GET_CARD_SIGN];
    
    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@",url,user.phoneNumber];
        
    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:urlWithPhoneNumber andParameters:dic andToken:user.token andSucBlock:^(id obj) {
        NSLog(@"%@",obj);
        if ([obj[@"code"]isEqualToString:SUCCESS]) {
            success(obj[@"content"]);
        }else if ([obj[@"code"]isEqualToString:TOKEN_ERROR]||[obj[@"code"]isEqualToString:NO_LOGIN]){
            [YhbMethods LoginTimeOut];
        }else{
            [AppUtils showAlertMessage:obj[@"msg"]];
        }
    } andFailedBlock:^(NSError *error) {

    }];
}

+(void)bandBankCardWithData:(NSDictionary *)param success:(SuccessBlock)success{
    NSMutableDictionary *dic=[NSMutableDictionary new];
    UserEntity *user=[UserEntity shareUserEntity];
    [dic setValue:@"2" forKey:@"apiVersion"];
    [dic setValue:param[@"bankName"] forKey:@"bankName"];
    [dic setValue:param[@"bankArea"] forKey:@"bankArea"];
    [dic setValue:param[@"cardNumber"] forKey:@"cardNumber"];
    [dic setValue:param[@"phoneNumber"] forKey:@"phoneNumber"];
    [dic setValue:param[@"bankType"] forKey:@"bankType"];
    [dic setValue:param[@"noAgree"] forKey:@"noAgree"];

    NSString *url = [super requestUrlWithPath:SUBMIT_BANK_INFO];
    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@",url,user.phoneNumber];
    
    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:urlWithPhoneNumber andParameters:dic andToken:user.token andSucBlock:^(id obj) {
        NSLog(@"%@",obj);
        if ([obj[@"code"]isEqualToString:SUCCESS]) {
            success(obj[@"content"]);
        }else if ([obj[@"code"]isEqualToString:TOKEN_ERROR]||[obj[@"code"]isEqualToString:NO_LOGIN]){
            [YhbMethods LoginTimeOut];
        }else{
            [AppUtils showAlertMessage:obj[@"msg"]];
        }
    } andFailedBlock:^(NSError *error) {
        
    }];
}

//获取消息列表
+(void)getMessageListSuccess:(SuccessBlock)success{
    NSMutableDictionary *dic=[NSMutableDictionary new];
    [dic setValue:@"2" forKey:@"apiVersion"];
    UserEntity *user=[UserEntity shareUserEntity];
    
    NSString *url = [super requestUrlWithPath:MESSAGE_LIST];
    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@",url,user.phoneNumber];
    
    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:urlWithPhoneNumber andParameters:dic andToken:user.token andSucBlock:^(id obj) {
        if ([obj[@"code"]isEqualToString:SUCCESS]) {
            success(obj[@"content"]);
        }else if ([obj[@"code"]isEqualToString:TOKEN_ERROR]||[obj[@"code"]isEqualToString:NO_LOGIN]){
            [YhbMethods LoginTimeOut];
        }else{
            [AppUtils showAlertMessage:obj[@"msg"]];
        }
    } andFailedBlock:^(NSError *error) {
        
    }];
}

//借款
+(void)borrowWithParam:(NSMutableDictionary *)param Success:(SuccessBlock)success{
    
    [param setValue:@"2" forKey:@"apiVersion"];
    
    UserEntity *user=[UserEntity shareUserEntity];
    
    NSString *url = [super requestUrlWithPath:SUBMIT_LOAN_INFO];
    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@",url,user.phoneNumber];
    
    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:urlWithPhoneNumber andParameters:param andToken:user.token andSucBlock:^(id obj) {
        if ([obj[@"code"]isEqualToString:SUCCESS]) {
            success(obj[@"content"]);
        }else if ([obj[@"code"]isEqualToString:TOKEN_ERROR]||[obj[@"code"]isEqualToString:NO_LOGIN]){
            [YhbMethods LoginTimeOut];
        }else{
            [AppUtils showAlertMessage:obj[@"msg"]];
        }
    } andFailedBlock:^(NSError *error) {
        
    }];
}
@end
