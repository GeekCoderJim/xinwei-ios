//
//  ListModel.h
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/4/8.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "BaseModel.h"

@interface ListModel : BaseModel

@property (nonatomic,strong) NSString *list_id;
@property (nonatomic,strong) NSString *totalOwe;
@property (nonatomic,strong) NSString *interest;
@property (nonatomic,strong) NSString *serviceCharge;
@property (nonatomic,strong) NSString *limitDays;
@property (nonatomic,strong) NSString *applyDate;
@property (nonatomic,strong) NSString *limitDate;
@property (nonatomic,strong) NSString *repayDate;
@property (nonatomic,strong) NSString *payDate;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *money;



@end
