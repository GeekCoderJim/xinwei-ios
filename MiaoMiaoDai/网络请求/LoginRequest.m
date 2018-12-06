//
//  LoginRequest.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/3/28.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "LoginRequest.h"


@implementation LoginRequest

+(void)loginWithPhoneNumber:(NSString *)phone password:(NSString *)password andCompanyId :(NSInteger) CompanyId success:(SuccessBlock)success{
    

    
    
    NSMutableDictionary *dic =[NSMutableDictionary new];
    if (CompanyId == 0) {
        dic[@"phoneNumber"] = phone;
        dic[@"password"] = password;
    }else{
        dic[@"phoneNumber"] = phone;
        dic[@"password"] = password;
        dic[@"companyId"] = @(CompanyId);
    }
    [dic setValue:[YhbMethods getMd5_32Bit_String:password] forKey:@"password"];
    
    NSString *url = [[@"http://" stringByAppendingString:[SERVER_HOST stringByAppendingString:@""]] stringByAppendingString:API_LOGIN];
    
    NSLog(@"%@",url);
//    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@/%@",url,phone];
    
    [AppUtils showWithStatusMessage:@"登录中..."];
    
    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:url andParameters:dic andSucBlock:^(id obj) {
        [AppUtils dismissHUD];
        NSDictionary *dic=obj;
        UserEntity *user = [UserEntity shareUserEntity];
        user.token = dic[@"token"];
        success([YhbMethods setDicNullClass:dic]);
        
    } andFailedBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络繁忙"];
        [YhbMethods performBlock:^{
            [SVProgressHUD dismiss];
        } afterDelay:1.0];
    }];
    
}

+(void)registWithPhoneNumber:(NSString *)phone password:(NSString *)password tradepassword:(NSString *)tradepassword success:(SuccessBlock)success{
    NSMutableDictionary *dic =[NSMutableDictionary new];
    [dic setValue:[YhbMethods getMd5_32Bit_String:password] forKey:@"password"];
    [dic setValue:[YhbMethods getMd5_32Bit_String:tradepassword] forKey:@"tradePassword"];
    NSString *url = [super requestUrlWithPath:API_REGIST];
    
    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@",url,phone];
    
    [AppUtils showWithStatusMessage:@"登录中..."];
    
    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:urlWithPhoneNumber andParameters:dic andSucBlock:^(id obj) {
        [AppUtils dismissHUD];
        NSLog(@"%@",obj);
        if ([obj[@"code"] isEqualToString:SUCCESS]) {
            NSDictionary *dic=obj[@"content"];
            success([YhbMethods setDicNullClass:dic]);
        }else{
            [AppUtils showAlertMessage:obj[@"msg"]];
        }
        
    } andFailedBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络繁忙"];
        [YhbMethods performBlock:^{
            [SVProgressHUD dismiss];
        } afterDelay:1.0];
    }];
}

+(void)getResUserListWithPhoneNum:(NSString *)phone Success:(SuccessBlock)success{
    NSString *url = [super requestUrlWithPath:API_GetCompany];
    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:url andParameters:@{@"phoneNumber":phone} andSucBlock:^(id obj) {
        [AppUtils dismissHUD];
        NSLog(@"%@",obj);
        if ([obj[@"code"] integerValue] == 100) {
            NSMutableDictionary *dic=[obj mutableCopy];
            success(dic);
        }else{
            [AppUtils showAlertMessage:obj[@"msg"]];
        }
        
    } andFailedBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络繁忙"];
        [YhbMethods performBlock:^{
            [SVProgressHUD dismiss];
        } afterDelay:1.0];
    }];
}

@end
