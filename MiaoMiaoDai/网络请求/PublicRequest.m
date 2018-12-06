//
//  PublicRequest.m
//  MiaoMiaoDai
//
//  Created by Mac on 2018/5/21.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "PublicRequest.h"


@implementation PublicRequest

+(void)getAppUpdateInfo:(SuccessBlock)success{
    
//    UserEntity *user=[UserEntity shareUserEntity];
    
    NSString *url = [super requestUrlWithPath:API_GET_UPDATE_INFO];
//    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@",url,user.phoneNumber];
    
    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:url andParameters:nil andSucBlock:^(id obj) {
        NSString * code = [NSString stringWithFormat:@"%@",obj[@"code"]];
        if ([code isEqualToString:@"100"]) {
            success(obj[@"data"]);
        }else{
            [AppUtils showAlertMessage:obj[@"msg"]];
        }
    } andFailedBlock:^(NSError *error) {
        
    }];

}

+(void)getQuickPayWebHost:(SuccessBlock)success{
    NSMutableDictionary *dic=[NSMutableDictionary new];
    UserEntity *user=[UserEntity shareUserEntity];
    [dic setValue:@"2" forKey:@"apiVersion"];
    
    NSString *url = [super requestUrlWithPath:API_GET_QUICKPAY_WEB];
    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@",url,user.phoneNumber];
    
    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:urlWithPhoneNumber andParameters:nil andToken:user.token andSucBlock:^(id obj) {
        NSString * code = [NSString stringWithFormat:@"%@",obj[@"code"]];
        if ([code isEqualToString:@"100"]) {
            success(obj[@"data"]);
        }else{
            [AppUtils showAlertMessage:obj[@"msg"]];
        }
    } andFailedBlock:^(NSError *error) {
        
    }];
}

+(void)getJTWebhOST:(successBlock)success{
    NSMutableDictionary *dic=[NSMutableDictionary new];
    UserEntity *user=[UserEntity shareUserEntity];
    [dic setValue:@"2" forKey:@"apiVersion"];
    
    NSString *url = [super requestUrlWithPath:API_GET_JT_WEB];
    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@",url,user.phoneNumber];
    
    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:urlWithPhoneNumber andParameters:nil andToken:user.token andSucBlock:^(id obj) {
        NSString * status = [NSString stringWithFormat:@"%@",obj[@"status"]];
        if ([status isEqualToString:@"IS_SUCCESS"]) {
            success(obj[@"content"][@"url"]);
        }else{
            [AppUtils showAlertMessage:obj[@"msg"]];
        }
    } andFailedBlock:^(NSError *error) {
        
    }];
}

+(void)getShareInfo:(SuccessBlock)success{
    NSMutableDictionary *dic=[NSMutableDictionary new];
    UserEntity *user=[UserEntity shareUserEntity];
    [dic setValue:@"2" forKey:@"apiVersion"];
    
    NSString *url = [super requestUrlWithPath:GET_SHARE_INFO];
    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@",url,user.phoneNumber];
    
    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:urlWithPhoneNumber andParameters:nil andToken:user.token andSucBlock:^(id obj) {
        NSString * code = [NSString stringWithFormat:@"%@",obj[@"code"]];
        if ([code isEqualToString:@"100"]) {
            success(obj);
        }else{
            [AppUtils showAlertMessage:obj[@"msg"]];
        }
    } andFailedBlock:^(NSError *error) {
        
    }];
}

+(void)uploadLocationInfoAndDeviceInfo:(NSDictionary *)dict{
    
    UserEntity *user=[UserEntity shareUserEntity];
    NSString *url = [super requestUrlWithPath:API_UPLOAD_LOCATION_DEVICE_INFO];
    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@",url,user.phoneNumber];
    
    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:urlWithPhoneNumber andParameters:dict andToken:user.token andSucBlock:^(id obj) {
        
    } andFailedBlock:^(NSError *error) {
        [AppUtils showAlertMessage:@"上传定位信息失败！"];
    }];
}
+(void)getWxPayOrder:(NSString *)orderID success:(successBlock)success{
    UserEntity *user=[UserEntity shareUserEntity];
//    NSMutableDictionary *dic=[NSMutableDictionary new];
    NSString *url = [super requestUrlWithPath:API_WXPay];
    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@/%@",url,user.phoneNumber,orderID];
    
    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:urlWithPhoneNumber andParameters:@{@"":@""} andToken:user.token andSucBlock:^(id obj) {
        success(obj);
    } andFailedBlock:^(NSError *error) {
        [AppUtils showAlertMessage:@"系统繁忙"];
    }];
}

+(void)getAliPayOrder:(NSString *)orderID success:(successBlock)success{
    UserEntity *user=[UserEntity shareUserEntity];
    //    NSMutableDictionary *dic=[NSMutableDictionary new];
    NSString *url = [super requestUrlWithPath:API_AliPay];
    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@/%@",url,user.phoneNumber,orderID];
    
    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:urlWithPhoneNumber andParameters:@{@"":@""} andToken:user.token andSucBlock:^(id obj) {
        success(obj);
    } andFailedBlock:^(NSError *error) {
        [AppUtils showAlertMessage:@"系统繁忙"];
    }];
}

+(void)getHeaderData:(NSData *)data url:(NSString *)urlStr success:(successBlock)success{
    NSString *url = [super requestUrlWithPath:API_RPGetToeken];
    
//    NSString *url = API_RPGetToeken;

    [YhbMethods AFNetWorkingGETRequstNetDataWithURL:url andParameters:nil andSucBlock:^(id obj) {
        success(obj);
    } andFailedBlock:^(NSError *error) {
        [AppUtils showAlertMessage:@"系统繁忙"];
    }];
}
+(void)getDataWithurl:(NSString *)urlStr success:(successBlock)success{
    NSString *url = [super requestUrlWithPath:API_SaveRpResult];
    url = [NSString stringWithFormat:@"%@%@",url,urlStr];
    UserEntity *user=[UserEntity shareUserEntity];
    NSLog(@"%@",user.token);
    
    [YhbMethods AFNetWorkingGETRequstNetDataWithURL:url andParameters:nil andToken:user.token andSucBlock:^(id obj) {
        NSLog(@"%@",obj);
        if ([obj[@"code"] integerValue] == 200) {
            UserEntity *userEntity =  [UserEntity shareUserEntity];
            userEntity.idCard = obj[@"content"][@"idCard"];
            userEntity.name = obj[@"content"][@"idCard"];
            userEntity.identityInfoStatus = obj[@"content"][@"identityInfoStatus"];
            NSLog(@"%@",userEntity);
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationName_UserEntityReload object:nil];
            [AppUtils showSuccessMessage:@"认证成功"];
        }
        
    } andFailedBlock:^(NSError *error) {
        [AppUtils showAlertMessage:@"系统繁忙"];
    }];
    
}
@end
