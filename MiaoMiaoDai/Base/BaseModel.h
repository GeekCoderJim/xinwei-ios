//
//  BaseModel.h
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/4/2.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
-(instancetype)initWithDic:(NSDictionary*)dic;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
