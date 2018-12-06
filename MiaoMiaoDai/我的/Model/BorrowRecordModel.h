//
//  BorrowRecordModel.h
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/4/4.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "BaseModel.h"

@interface BorrowRecordModel : BaseModel
@property(strong,nonatomic)NSString *applyDate;
@property(strong,nonatomic)NSString *delayInterest;
@property(strong,nonatomic)NSString *delayServiceCharge;
@property(strong,nonatomic)NSString *borrow_id;
@property(strong,nonatomic)NSString *interest;
@property(strong,nonatomic)NSString *limitDate;
@property(strong,nonatomic)NSString *limitDays;
@property(strong,nonatomic)NSString *overdueInterest;
@property(strong,nonatomic)NSString *payDate;
@property(strong,nonatomic)NSString *repayDate;
@property(strong,nonatomic)NSString *serviceCharge;
@property(strong,nonatomic)NSString *status;
@property(strong,nonatomic)NSString *totalOwe;

@end
