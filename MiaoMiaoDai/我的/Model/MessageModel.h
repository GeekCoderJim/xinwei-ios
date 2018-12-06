//
//  MessageModel.h
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/4/4.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "BaseModel.h"

@interface MessageModel : BaseModel

@property(strong,nonatomic)NSString *bid;
@property(strong,nonatomic)NSString *createTime;
@property(strong,nonatomic)NSString *bankType;
@property(strong,nonatomic)NSString *createUser;
@property(strong,nonatomic)NSString *message_id;
@property(strong,nonatomic)NSString *msg;
@property(strong,nonatomic)NSString *phoneNumber;
@property(strong,nonatomic)NSString *title;
@property(strong,nonatomic)NSString *type;
@property(strong,nonatomic)NSString *updateTime;

@end
