//
//  BankcardRZView.h
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/6/11.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankcardRZView : UIView

@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UITextField *text_Name;
@property (strong,nonatomic) UITextField *text_IDNumber;
@property (strong,nonatomic) UITextField *text_CardNumber;
@property (strong,nonatomic) UILabel *text_phoneNumber;
@property (strong,nonatomic) UITextField *text_Verification;
@property (strong,nonatomic) UIButton *btn_GetVerificationButton;
@property (strong,nonatomic) UITextField *text_bankName;
@property (strong,nonatomic) UITextField *text_city;
@property (strong,nonatomic) UILabel *text_subbranch;
@property (strong,nonatomic) UIButton *btn_Next;

@property(nonatomic) NSUInteger selectedIndex;

@end
