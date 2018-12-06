//
//  MineRequest.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/4/4.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "MineRequest.h"

@implementation MineRequest
//获取账单记录列表
+(void)getOrderListSuccess:(SuccessBlock)success{
    NSMutableDictionary *dic=[NSMutableDictionary new];
    [dic setValue:@"2" forKey:@"apiVersion"];
    UserEntity *user=[UserEntity shareUserEntity];
    
    NSString *url = [super requestUrlWithPath:GET_OWE_LIST];
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
//获取借款记录列表
+(void)getRecordListSuccess:(SuccessBlock)success{
    NSMutableDictionary *dic=[NSMutableDictionary new];
    [dic setValue:@"2" forKey:@"apiVersion"];
    UserEntity *user=[UserEntity shareUserEntity];
    
    NSString *url = [super requestUrlWithPath:GET_BILL_LIST];
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
+(void)resetLoginPasswordWithPhone:(NSString *)phone NewPassword:(NSString *)password success:(SuccessBlock)success{
    NSMutableDictionary *dic=[NSMutableDictionary new];
    [dic setValue:@"2" forKey:@"apiVersion"];
    [dic setValue:[YhbMethods getMd5_32Bit_String:password] forKey:@"newPassword"];

//    UserEntity *user=[UserEntity shareUserEntity];
    
    NSString *url = [super requestUrlWithPath:RESET_PWD_URL];
    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@",url,phone];
    
    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:urlWithPhoneNumber andParameters:dic andToken:nil andSucBlock:^(id obj) {
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
+(void)resetTradePasswordWithNewPassword:(NSString *)password success:(SuccessBlock)success{
    NSMutableDictionary *dic=[NSMutableDictionary new];
    [dic setValue:@"2" forKey:@"apiVersion"];
    [dic setValue:[YhbMethods getMd5_32Bit_String:password] forKey:@"tradePassword"];
    
    UserEntity *user=[UserEntity shareUserEntity];
    
    NSString *url = [super requestUrlWithPath:RESET_SPWD_URL];
    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@",url,user.phoneNumber];
    
    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:urlWithPhoneNumber andParameters:dic andToken:user.token andSucBlock:^(id obj) {
        if ([obj[@"code"]isEqualToString:SUCCESS]) {
            success(obj[@"content"]);
        }else if ([obj[@"code"]isEqualToString:TOKEN_ERROR]||[obj[@"code"]isEqualToString:NO_LOGIN]){
            [YhbMethods LoginTimeOut];
        }else if ([obj[@"code"]isEqualToString:@"5014"]){
            [AppUtils showAlertMessage:@"新密码不能与原密码一致！"];
        }else{
            [AppUtils showAlertMessage:obj[@"msg"]];
        }
    } andFailedBlock:^(NSError *error) {
        
    }];
}

@end
