//
//  BaseModel.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/4/2.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:[YhbMethods setDicNullClass:dic]];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
