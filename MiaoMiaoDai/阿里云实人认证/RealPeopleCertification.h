//
//  RealPeopleCertification.h
//  MiaoMiaoDai
//
//  Created by 陈恒均 on 2018/11/30.
//  Copyright © 2018 HongBin You. All rights reserved.
//

#import <Foundation/Foundation.h>


#import <RPSDK/RPSDK.h>

@interface RealPeopleCertification : NSObject

+ (RealPeopleCertification *)shareInstance;

- (void)startRealPeopleCertificationWithVC:(UINavigationController *)navigationController result:(void (^)(BOOL isSuccess))result;

@end

