//
//  RealPeopleCertification.m
//  MiaoMiaoDai
//
//  Created by 陈恒均 on 2018/11/30.
//  Copyright © 2018 HongBin You. All rights reserved.
//

#import "RealPeopleCertification.h"
#import "PublicRequest.h"


#import <SVProgressHUD/SVProgressHUD.h>

@implementation RealPeopleCertification

+ (RealPeopleCertification *)shareInstance {
    static RealPeopleCertification *realPeopleCertification;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        realPeopleCertification = [[RealPeopleCertification alloc]init];

    });
    return realPeopleCertification;
}

#pragma mark - 实人认证  
- (void)startRealPeopleCertificationWithVC:(UINavigationController *)navigationController result:(void (^)(BOOL isSuccess))result {
    
    [PublicRequest getHeaderData:nil url:nil success:^(NSDictionary * responseDic)  {
        if ([[responseDic allKeys] containsObject:@"token"]) {
            NSString *ticketId = responseDic[@"ticketId"];
            NSString *certToken = responseDic[@"token"];
            //开始实名认证
            
            [RPSDK start:certToken rpCompleted:^(AUDIT auditState) {
                NSLog(@"verifyResult = %ld",(unsigned long)auditState);
                BOOL auditResult = NO;
                if (auditState == AUDIT_PASS) { //认证通过
                    auditResult = YES;
                    //通知后台去获取用户认证资料
                    [self certificationSuccessWithTicketId:ticketId];
                } else if (auditState == AUDIT_FAIL) { //认证不通过
                    [SVProgressHUD showErrorWithStatus:@"认证失败"];
                } else if (auditState == AUDIT_IN_AUDIT) { //认证中，通常不会出现，只有在认证审核系统内部出现超时，未在限定时间内返回认证结果时出现。此时提示用户系统处理中，稍后查看认证结果即可。
                    [SVProgressHUD showErrorWithStatus:@"认证中"];
                } else if (auditState == AUDIT_NOT) { //未认证，用户取消
                    [SVProgressHUD showErrorWithStatus:@"取消认证"];
                } else if (auditState == AUDIT_EXCEPTION) { //系统异常
                    [SVProgressHUD showErrorWithStatus:@"系统异常"];
                }
                
                if (result) {
                    result(auditResult);
                }
            } withVC:navigationController];
        } else {
            //该用户已经认证
            if (result) {
                result(YES);
            }
        }
    } ];
}

//#pragma mark - 认证成功，通知后台查询获取认证资料
- (void)certificationSuccessWithTicketId:(NSString *)ticketId {
//    NSDictionary *dataDic = @{@"ticketId":ticketId};
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:nil];
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
//    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",SERVER_HOST,API_SaveRpResult,ticketId];

    
    [PublicRequest getDataWithurl:ticketId success:^(NSDictionary* obj) {

    }];
}


@end
