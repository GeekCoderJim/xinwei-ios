//
//  MOFAddressModel.h
//  MOFSPickerManagerDemo
//
//  Created by 尤鸿斌 on 2018/3/10.
//  Copyright © 2018年 luoyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CityModel,DistrictModel,GDataXMLElement;

@interface MOFAddressModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *zipcode;
@property (nonatomic, strong) NSString *index;
@property (nonatomic, strong) NSMutableArray<CityModel *> *list;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

@interface CityModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *zipcode;
@property (nonatomic, strong) NSString *index;
@property (nonatomic, strong) NSMutableArray<DistrictModel *> *list;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

@interface DistrictModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *zipcode;
@property (nonatomic, strong) NSString *index;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
