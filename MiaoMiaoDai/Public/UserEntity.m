//
//  UserEntity.m
//  ShangCheng
//
//  Created by 尤鸿斌 on 2017/11/16.
//  Copyright © 2017年 HongBin You. All rights reserved.
//

#import "UserEntity.h"
static UserEntity *userEntity = nil;
@implementation UserEntity

+ (UserEntity*)shareUserEntity
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        userEntity = [[UserEntity alloc]init];
    });
    return userEntity;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        userEntity = [super allocWithZone:zone];
    });
    return userEntity;
}
-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        NSMutableDictionary * dict = [YhbMethods setNullClassForDic:dic];
        [self setValuesForKeysWithDictionary:dict];
        
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
