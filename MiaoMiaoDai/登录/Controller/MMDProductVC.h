//
//  MMDProductVC.h
//  MiaoMiaoDai
//
//  Created by 陈恒均 on 2018/11/24.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MMDCompanyModel;

typedef void(^MMDBlock)(MMDCompanyModel * model);

@interface MMDProductVC : BaseViewController
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) MMDBlock block;
@end
