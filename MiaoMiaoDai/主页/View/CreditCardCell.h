//
//  CreditCardCell.h
//  SuXunTong
//
//  Created by 尤鸿斌 on 2017/6/30.
//  Copyright © 2017年 scan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankCardModel.h"

@interface CreditCardCell : UITableViewCell
@property (strong,nonatomic) UILabel *lab_CardNum;
@property (strong,nonatomic) UILabel *lab_Name;
@property (strong,nonatomic) UILabel *lab_IDNO;
@property (strong,nonatomic) UILabel *lab_State;
@property (strong,nonatomic) UILabel *lab_Level;
@property (strong,nonatomic) UILabel *lab_smrz;
@property (strong,nonatomic) UIButton *btn_keep;

@property(strong,nonatomic)BankCardModel *model;
@property(strong,nonatomic) UIImageView *bankLogoImage;
@property(strong,nonatomic) UIImageView *bankLogoImage_scale;
@property(strong,nonatomic) UIView *backgroundview;
@property(strong,nonatomic) UILabel *userNameLabel;
@property(strong,nonatomic) UILabel *IDNumberLabel;
@property(strong,nonatomic) UILabel *bankNameLabel;
@property(strong,nonatomic) UILabel *bankCardTypeLabel;
@property(strong,nonatomic) UILabel *bankNumberLabel;
@end
