//
//  RZRequest.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/4/2.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "RZRequest.h"

@implementation RZRequest

+(void)getUserVerifyStatus:(SuccessBlock)success{
    NSMutableDictionary *dic=[NSMutableDictionary new];
    UserEntity *user=[UserEntity shareUserEntity];
    [dic setValue:@"2" forKey:@"apiVersion"];
    
    NSString *url = [super requestUrlWithPath:VERIFY_STATUS];
    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@",url,user.phoneNumber];
    
    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:urlWithPhoneNumber andParameters:dic andToken:user.token andSucBlock:^(id obj) {
        NSLog(@"%@",obj);
        [SVProgressHUD dismiss];
        if ([obj[@"code"]isEqualToString:SUCCESS]) {
          UserEntity *usere=[UserEntity shareUserEntity];
          NSMutableDictionary * dict = [YhbMethods setNullClassForDic:obj[@"content"]];
          [usere setValuesForKeysWithDictionary:dict];
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationName_UserEntityReload object:nil];

            success(obj[@"content"]);
          
        }else if ([obj[@"code"]isEqualToString:TOKEN_ERROR]||[obj[@"code"]isEqualToString:NO_LOGIN]){
            [YhbMethods LoginTimeOut];
        }else{
            [AppUtils showAlertMessage:obj[@"msg"]];
        }
    } andFailedBlock:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

+(void)getUserInfoSuccess:(SuccessBlock)success{
    NSMutableDictionary *dic=[NSMutableDictionary new];
    UserEntity *user=[UserEntity shareUserEntity];
    [dic setValue:@"2" forKey:@"apiVersion"];
    NSLog(@"user ------- %@",user);
    NSString *url = [super requestUrlWithPath:GET_USER_INFO];
    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@",url,user.phoneNumber];
    
//    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:urlWithPhoneNumber andParameters:dic andToken:user.token andSucBlock:^(id obj) {
//        NSLog(@"%@",obj);
//        if ([obj[@"code"]isEqualToString:SUCCESS]) {
//            success(obj[@"content"]);
//        }else if ([obj[@"code"]isEqualToString:TOKEN_ERROR]||[obj[@"code"]isEqualToString:NO_LOGIN]){
//            [YhbMethods LoginTimeOut];
//        }else if ([obj[@"code"] isEqualToString:@"5003"]){
//
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
        }else if ([obj[@"code"] isEqualToString:@"5003"]){
            
        }else{
            [AppUtils showAlertMessage:obj[@"msg"]];
        }
    } andFailedBlock:^(NSError *error) {
        
    }];
}

+(void)getContactInfoSuccess:(SuccessBlock)success{
    NSMutableDictionary *dic=[NSMutableDictionary new];
    UserEntity *user=[UserEntity shareUserEntity];
    [dic setValue:@"2" forKey:@"apiVersion"];
    
    NSString *url = [super requestUrlWithPath:GET_CONTACT_INFO];
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
+(void)submitUserInfoWithParam:(NSDictionary *)param success:(SuccessBlock)success{
    
    NSMutableDictionary *dic=[NSMutableDictionary new];
    UserEntity *user=[UserEntity shareUserEntity];
    [dic setValue:@"2" forKey:@"apiVersion"];
    NSArray *array=[param allKeys];
    for (int i = 0; i<array.count; i++) {
        [dic setValue:param[array[i]] forKey:array[i]];
    }
    
    NSString *url = [super requestUrlWithPath:SUBMIT_USER_INFO];
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
+(void)submitContactsInfoWithParam:(NSDictionary *)param success:(SuccessBlock)success{
    
    NSMutableDictionary *dic=[NSMutableDictionary new];
    UserEntity *user=[UserEntity shareUserEntity];
    [dic setValue:@"2" forKey:@"apiVersion"];
    NSArray *array=[param allKeys];
    for (int i = 0; i<array.count; i++) {
        [dic setValue:param[array[i]] forKey:array[i]];
    }
    
    NSString *url = [super requestUrlWithPath:SUBMIT_USER_CONTACT];
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

+(void)phoneRZWithPhone:(NSString *)phone password:(NSString *)password success:(SuccessBlock)success{
    
    NSMutableDictionary *dic=[NSMutableDictionary new];
    UserEntity *user=[UserEntity shareUserEntity];
    [dic setValue:password forKey:@"serverPwd"];
    [dic setValue:@"2" forKey:@"apiVersion"];

    NSString *url = [super requestUrlWithPath:PHONE_RZ];
    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@",url,user.phoneNumber];

    [AppUtils showWithStatusMessage:@"认证中..."];
    
    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:urlWithPhoneNumber andParameters:dic andToken:user.token andSucBlock:^(id obj) {
        NSLog(@"%@",obj);
        [AppUtils dismissHUD];
        obj=[YhbMethods setDicNullClass:obj];
        BOOL rqs_success = [[NSString stringWithFormat:@"%@",obj[@"success"]]boolValue];
        if (rqs_success) {
            success(obj[@"data"]);
        }else{
            [AppUtils showAlertMessage:obj[@"msg"]];
        }
    } andFailedBlock:^(NSError *error) {
        [AppUtils dismissHUD];
    }];

}

+(void)phoneRZSecondWithSmsCode:(NSString *)smsCode lastResultString:(NSString *)lastResult success:(SuccessBlock)success{
    NSMutableDictionary *dic=[NSMutableDictionary new];
    UserEntity *user=[UserEntity shareUserEntity];
    [dic setValue:@"2" forKey:@"apiVersion"];
    [dic setValue:lastResult forKey:@"lastResult"];
    [dic setValue:smsCode forKey:@"smsCode"];

    NSString *url = [super requestUrlWithPath:PHONE_RZ_SECOND];
    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@",url,user.phoneNumber];
  
  [AppUtils showProgressMessage:@"认证中..."];
  
  
    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:urlWithPhoneNumber andParameters:dic andToken:user.token andSucBlock:^(id obj) {
        NSLog(@"%@",obj);
      [AppUtils dismissHUD];
      NSString * code = [NSString stringWithFormat:@"%@",obj[@"code"]];
      if ([code isEqualToString:@"100"]) {
        success(obj[@"data"]);
      }else{
        [AppUtils showAlertMessage:obj[@"msg"]];
      }
    } andFailedBlock:^(NSError *error) {
        [AppUtils dismissHUD];
    }];
}

+(void)ContactRZWithJson:(NSString *)Json Success:(SuccessBlock)success{
    NSMutableDictionary *dic=[NSMutableDictionary new];
    UserEntity *user=[UserEntity shareUserEntity];
    [dic setValue:@"2" forKey:@"apiVersion"];
    [dic setValue:Json forKey:@"contactJson"];
    
    NSString *url = [super requestUrlWithPath:UPLOAD_CONTACT_INFO];
    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@",url,user.phoneNumber];
    
    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:urlWithPhoneNumber andParameters:dic andToken:user.token andSucBlock:^(id obj) {
        if ([obj[@"code"]isEqualToString:SUCCESS]) {
            success(obj[@"content"]);
        }else if ([obj[@"code"]isEqualToString:TOKEN_ERROR]||[obj[@"code"]isEqualToString:NO_LOGIN]){
            [YhbMethods LoginTimeOut];
        }else{
            [AppUtils showAlertMessage:obj[@"content"]];
        }
    } andFailedBlock:^(NSError *error) {
        
    }];
}


+(void)upLoadImage:(UIImage *)upload_image Success:(SuccessBlock)success{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *dic=[NSMutableDictionary new];
    UserEntity *user=[UserEntity shareUserEntity];
    [dic setValue:@"2" forKey:@"apiVersion"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",nil];
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    manager.responseSerializer= [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:user.token forHTTPHeaderField:@"token"];

    NSString *url=[super requestUrlWithPath:API_UPLOAD_PHOTO_NEW];
    
    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@",url,user.phoneNumber];
    
    
    [manager POST:urlWithPhoneNumber parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //把image  转为data , POST上传只能传data
        NSData *data = UIImageJPEGRepresentation(upload_image, 0.1);
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:data
                                    name:@"file"
                                fileName:@"gauge.png"
                                mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%lld/%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        float progress =uploadProgress.completedUnitCount/uploadProgress.totalUnitCount;
        [SVProgressHUD showProgress:progress status:@"上传中..."];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        [SVProgressHUD dismiss];
        if ([dic[@"code"]intValue]==100) {
            success(dic);
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        NSLog(@"上传失败%@",error);
        
    }];
    
    
    
   
    
}

+(void)getSFRZImageSuccess:(SuccessBlock)success{
    NSMutableDictionary *dic=[NSMutableDictionary new];
    UserEntity *user=[UserEntity shareUserEntity];
    [dic setValue:@"2" forKey:@"apiVersion"];
    
    NSString *url = [super requestUrlWithPath:GET_SFRZ_IMAGE];
    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@",url,user.phoneNumber];
    
    [AppUtils showWithStatusMessage:@"加载中..."];
    
    
    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:urlWithPhoneNumber andParameters:dic andToken:user.token andSucBlock:^(id obj) {
        [AppUtils dismissHUD];
        NSString *code=[NSString stringWithFormat:@"%@",obj[@"code"]];
        if ([code isEqualToString:@"100"]) {
            success(obj[@"data"]);
        }else if ([code isEqualToString:TOKEN_ERROR]||[code isEqualToString:NO_LOGIN]){
            [YhbMethods LoginTimeOut];
        }else{
            [AppUtils showAlertMessage:obj[@"msg"]];
        }
    } andFailedBlock:^(NSError *error) {
        [AppUtils dismissHUD];
    }];
   
}



+ (void)bankBranches:(NSString*)bank_city andbank_type:(NSString *)bank_type success:(SuccessBlock)success failed:(FailedBlock)failed{
    UserEntity *user = [UserEntity shareUserEntity];
    NSMutableDictionary *parametersDic = [[NSMutableDictionary alloc]init];
    [parametersDic setValue:bank_city forKey:@"bankCity"];
//    [parametersDic setValue:bank_province forKey:@"bank_province"];
    [parametersDic setValue:bank_type forKey:@"bankType"];
    
    NSString *url=[super requestUrlWithPath:API_getBankListByCity];

    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:url andParameters:parametersDic andToken:user.token andSucBlock:^(id obj) {
        success(obj);
    } andFailedBlock:^(NSError *error) {
        
    }];
    
    
}

+(void)uploadBandBankcardInfoWithParam:(NSDictionary *)param success:(SuccessBlock)success{
    
    UserEntity *userEntity = [[UserEntity alloc]init];
    
    
    NSMutableDictionary *parameter=[NSMutableDictionary dictionaryWithDictionary:param];
    
    
    NSString *url=[super requestUrlWithPath:API_uploadPersonInfo];
    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@",url,userEntity.phoneNumber];
    
    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:urlWithPhoneNumber andParameters:parameter andToken:userEntity.token andSucBlock:^(id obj) {
        success(obj);
    } andFailedBlock:^(NSError *error) {
        
    }];
}

+(void)finishUploadImage:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    UserEntity *userEntity = [[UserEntity alloc]init];

    
    NSMutableDictionary *param=[NSMutableDictionary dictionaryWithDictionary:dic];

    
    NSString *url=[super requestUrlWithPath:API_uploadPhotoInfo];
    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@",url,userEntity.phoneNumber];

    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:urlWithPhoneNumber andParameters:param andToken:userEntity.token andSucBlock:^(id obj) {
        success(obj);
        
    } andFailedBlock:^(NSError *error) {
        failed(error);
        
    }];
    
}

+(void)getBankCardTypeListSuccess:(SuccessBlock)success{
    UserEntity *user = [[UserEntity alloc]init];
    NSString *url=[super requestUrlWithPath:API_getAreaAndCityAndBankType];
//    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@",url,user.phoneNumber];
    
    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:url andParameters:nil andToken:user.token andSucBlock:^(id obj) {
        success(obj);
    } andFailedBlock:^(NSError *error) {
        
    }];
}

+(void)getBankcardRZInfo:(SuccessBlock)success{
    UserEntity *user = [[UserEntity alloc]init];
    NSString *url=[super requestUrlWithPath:API_personInfo];
        NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@",url,user.phoneNumber];
    
    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:urlWithPhoneNumber andParameters:nil andToken:user.token andSucBlock:^(id obj) {
        success(obj);
    } andFailedBlock:^(NSError *error) {
        
    }];

}


+(void)resendMessageWithLastRusult:(NSString *)lastResult success:(SuccessBlock)success{
    UserEntity *user = [[UserEntity alloc]init];
    NSString *url=[super requestUrlWithPath:API_personInfo];
    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@",url,user.phoneNumber];
    NSDictionary *param = @{@"lastResult":lastResult};
    
    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:urlWithPhoneNumber andParameters:param andToken:user.token andSucBlock:^(id obj) {
        success(obj);
    } andFailedBlock:^(NSError *error) {
        
    }];
}
+(void)changeVerifyStatusWithType:(NSString *)type success:(SuccessBlock)success{
    UserEntity *user = [[UserEntity alloc]init];
    NSString *url=[super requestUrlWithPath:API_ChangeVerifyStatus];
    NSString *urlWithPhoneNumber=[NSString stringWithFormat:@"%@%@",url,user.phoneNumber];
    NSDictionary *param = @{@"type":type};
    
    
    [YhbMethods AFNetWorkingPOSTRequstNetDataWithURL:urlWithPhoneNumber andParameters:param andToken:user.token andSucBlock:^(id obj) {
        BOOL isSuccess = [obj[@"success"]boolValue];
        if (isSuccess) {
            success(obj);
        }else{
            [AppUtils showTipsMessage:obj[@"msg"]];
        }
        
    } andFailedBlock:^(NSError *error) {
        [AppUtils showTipsMessage:@"请求失败！"];
    }];
}

@end
