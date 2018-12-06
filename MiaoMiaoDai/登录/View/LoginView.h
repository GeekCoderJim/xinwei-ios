//
//  LoginView.h
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/2/28.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView

@property(strong,nonatomic)UITextField *accountTextField;
@property(strong,nonatomic)UITextField *passwordTextField;
@property(strong,nonatomic)UIButton *loginBtn;
@property(strong,nonatomic)UIButton *forgotBtn;
@property(strong,nonatomic)UIButton *registBtn;
@property (nonatomic, strong) UITextField *platTF;
@property (nonatomic, strong) UIButton *platbtn;

@end
