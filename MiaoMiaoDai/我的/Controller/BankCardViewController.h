//
//  BankCardViewController.h
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/3/3.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankCardModel.h"

typedef void(^returnBankCard)(BankCardModel *model);
@interface BankCardViewController : BaseViewController
@property(strong,nonatomic)returnBankCard returnCard;
@end
