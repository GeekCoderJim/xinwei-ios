//
//  AliRPVC.m
//  MiaoMiaoDai
//
//  Created by 陈恒均 on 2018/11/30.
//  Copyright © 2018 HongBin You. All rights reserved.
//

#import "AliRPVC.h"
#import "RealPeopleCertification.h"

@interface AliRPVC ()

@end

@implementation AliRPVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[RealPeopleCertification shareInstance] startRealPeopleCertificationWithVC:self.navigationController result:^(BOOL isSuccess) {
        if (isSuccess) { //认证通过
            
        } else { //认证失败
            
        }
    }];
}



@end
