//
//  BankCardModel.h
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/4/2.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "BaseModel.h"

@interface BankCardModel : BaseModel

@property(strong,nonatomic)NSString *bankArea;
@property(strong,nonatomic)NSString *bankName;
@property(strong,nonatomic)NSString *bankType;
@property(strong,nonatomic)NSString *cardNumber;
@property(strong,nonatomic)NSString *createTime;
@property(strong,nonatomic)NSString *createUser;
@property(strong,nonatomic)NSString *disable;
@property(strong,nonatomic)NSString *bankcard_id;
@property(strong,nonatomic)NSString *noAgree;
@property(strong,nonatomic)NSString *phoneNumber;
@property(strong,nonatomic)NSString *signStatus;
@property(strong,nonatomic)NSString *updateTime;
@property(strong,nonatomic)NSString *userId;

@end
