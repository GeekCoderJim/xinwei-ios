//
//  UserEntity.h
//  ShangCheng
//
//  Created by 尤鸿斌 on 2017/11/16.
//  Copyright © 2017年 HongBin You. All rights reserved.
//

#import <Foundation/Foundation.h>


//用户单例 用户信息能丢的就丢这里
@interface UserEntity : NSObject


@property(strong,nonatomic)NSString *phoneNumber;//手机号
@property(strong,nonatomic)NSString *idCard;//身份证
@property(strong,nonatomic)NSString *name;//用户姓名
@property(strong,nonatomic)NSString *token;//token
@property(strong,nonatomic)NSString *applyId;//海量数据，进件ID，用于获取海量数据
@property(strong,nonatomic)NSString *bankInfoStatus;//银行卡信息认证状态：0-未认证，1-已认证
@property(strong,nonatomic)NSString *contactStatus;//联系人状态：0-未认证，1-已认证
@property(strong,nonatomic)NSString *createTime;//创建时间
@property(strong,nonatomic)NSString *createUser;//创建人账户
@property(strong,nonatomic)NSString *ddStatus;//滴滴认证
@property(strong,nonatomic)NSString *disable;//启用状态 0：启用 1：此条记录不启用，逻辑删除
@property(strong,nonatomic)NSString *gjjStatus;//公积金认证
@property(strong,nonatomic)NSString *identityInfoStatus;//身份证认证状态:0-未认证，1-已认证
@property(strong,nonatomic)NSString *jdStatus;//京东认证
@property(strong,nonatomic)NSString *leftAmount;//剩余额度
@property(strong,nonatomic)NSString *limitAmount;//总额度
@property(strong,nonatomic)NSString *lockTime;//在这个时间之前，用户不能申请订单
@property(strong,nonatomic)NSString *loginTime;//登录时间
@property(strong,nonatomic)NSString *operatorStatus;//运营商认证
@property(strong,nonatomic)NSString *phoneStatus;//手机认证状态：0-未认证，1-已认证
@property(strong,nonatomic)NSString *qqStatus;//QQ控件认证
@property(strong,nonatomic)NSString *taobaoStatus;//淘宝认证
@property(strong,nonatomic)NSString *updateTime;//更新时间
@property(strong,nonatomic)NSString *userAccount;//用户账号，默认手机号
@property(strong,nonatomic)NSString *userId;//用户ID
@property(strong,nonatomic)NSString *userInfoStatus;//个人信息认证状态：0-未认证，1-已认证
@property(strong,nonatomic)NSString *userStatus;//用户状态 0-正常 1-黑名单 2-信用待提升
@property(strong,nonatomic)NSString *userType;//角色类型：0普通用户，1风控，2放款人，100管理员
@property(strong,nonatomic)NSString *zfbStatus;//支付宝认证
@property(strong,nonatomic)NSString *zmxyAuthorizeStatus;//芝麻信用认证状态：0-未认证，1-已认证
@property(strong,nonatomic)NSString *photoStatus;//表示 照片验证状态:0-未验证 1-已验证
@property(strong,nonatomic)NSString *chsiStatus;//表示 学信网验证状态:0-未验证 1-已验证
@property(strong,nonatomic)NSString *maimaiStatus;//表示 脉脉验证状态:0-未验证 1-已验证
@property(strong,nonatomic)NSString *zmStatus;//芝麻信用
@property(strong,nonatomic)NSString *personInfoStatus;//表示 个人信息验证状态: 0-未验证 1-已验证
@property(strong,nonatomic)NSString *mnoStatus;//手机号码二次认证
@property(strong,nonatomic)NSString *alipayStatus;//支付宝
@property(strong,nonatomic)NSString *qzoneStatus;//QQ空间
@property(strong,nonatomic)NSString *linkedinStatus;//领英
@property(strong,nonatomic)NSString *weiboStatus;//微博


+ (UserEntity*)shareUserEntity;
-(instancetype)initWithDic:(NSDictionary*)dic;

@end
