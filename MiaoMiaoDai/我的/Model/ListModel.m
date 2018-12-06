//
//  ListModel.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/4/8.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super initWithDic:dic];
    if (self) {
        self.list_id=dic[@"id"];
    }
    return self;
}

@end
