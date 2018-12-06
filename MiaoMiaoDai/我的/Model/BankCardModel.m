//
//  BankCardModel.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/4/2.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "BankCardModel.h"

@implementation BankCardModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    if(self =[super initWithDic:dic]){
        self.bankcard_id=dic[@"id"];
    }
    return self;
}

@end
