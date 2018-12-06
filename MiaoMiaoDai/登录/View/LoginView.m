//
//  LoginView.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/2/28.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "LoginView.h"

@interface LoginView()

@end

@implementation LoginView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [self setupviews];
    }
    return self;
}


-(void)setupviews{
    UIImageView *logoimage=[[UIImageView alloc]initWithImage:Image(@"xinwei_logo")];
    [self addSubview:logoimage];
    logoimage.sd_layout
    .topSpaceToView(self, AUTO(20))
    .centerXEqualToView(self)
    .widthIs(AUTO(120))
    .heightEqualToWidth();
    
    
    //账号
    UIView *accountview=[UIView new];
    accountview.backgroundColor=[UIColor whiteColor];
    [self addSubview:accountview];
    accountview.sd_layout
    .topSpaceToView(logoimage, AUTO(25))
    .leftSpaceToView(self, AUTO(50))
    .rightSpaceToView(self, AUTO(50))
    .heightIs(AUTO(50));
    
    UIImageView *phone=[[UIImageView alloc]initWithImage:Image(@"icon_loginpage_content_phone")];
    [accountview addSubview:phone];
    phone.sd_layout
    .centerYEqualToView(accountview)
    .leftSpaceToView(accountview, AUTO(10))
    .heightIs(AUTO(25))
    .widthEqualToHeight();
    
    self.accountTextField=[[UITextField alloc]init];
    _accountTextField.borderStyle=UITextBorderStyleNone;
    _accountTextField.placeholder=@"请输入手机号";
    _accountTextField.keyboardType=UIKeyboardTypeDecimalPad;
    [accountview addSubview:_accountTextField];
    _accountTextField.sd_layout
    .topEqualToView(accountview)
    .bottomEqualToView(accountview)
    .leftSpaceToView(phone, AUTO(5))
    .rightSpaceToView(accountview, AUTO(10));
    
    
    //密码
    
    UIView *passwordview=[UIView new];
    passwordview.backgroundColor=[UIColor whiteColor];
    [self addSubview:passwordview];
    passwordview.sd_layout
    .topSpaceToView(accountview, AUTO(20))
    .leftSpaceToView(self, AUTO(50))
    .rightSpaceToView(self, AUTO(50))
    .heightIs(AUTO(50));
    

    UIImageView *lock=[[UIImageView alloc]initWithImage:Image(@"icon_loginpage_content_password")];
    [passwordview addSubview:lock];
    lock.sd_layout
    .centerYEqualToView(passwordview)
    .leftSpaceToView(passwordview, AUTO(10))
    .heightIs(AUTO(25))
    .widthEqualToHeight();
    
    self.passwordTextField=[[UITextField alloc]init];
    _passwordTextField.borderStyle=UITextBorderStyleNone;
    _passwordTextField.placeholder=@"请输入密码";
    _passwordTextField.secureTextEntry=YES;
    
    [passwordview addSubview:_passwordTextField];
    _passwordTextField.sd_layout
    .topEqualToView(passwordview)
    .bottomEqualToView(passwordview)
    .leftSpaceToView(lock, AUTO(5))
    .rightSpaceToView(passwordview, AUTO(10));
    
    //选择平台
    UIView *platView=[UIView new];
    platView.backgroundColor=[UIColor whiteColor];
    [self addSubview:platView];
    platView.sd_layout
    .topSpaceToView(passwordview, AUTO(20))
    .leftSpaceToView(self, AUTO(50))
    .rightSpaceToView(self, AUTO(50))
    .heightIs(AUTO(50));
    
    
    UIImageView *plat=[[UIImageView alloc]initWithImage:Image(@"icon_loginpage_content_product")];
    [platView addSubview:plat];
    plat.sd_layout
    .centerYEqualToView(platView)
    .leftSpaceToView(platView, AUTO(10))
    .heightIs(AUTO(25))
    .widthEqualToHeight();
    
   
    
    self.platTF = [[UITextField alloc]init];
    self.platTF.borderStyle=UITextBorderStyleNone;
    self.platTF.placeholder=@"请选择产品";
    self.platTF.delegate = self;

    [platView addSubview:self.platTF];
    self.platTF.sd_layout
    .topEqualToView(platView)
    .bottomEqualToView(platView)
    .leftSpaceToView(plat, AUTO(5))
    .rightSpaceToView(platView, AUTO(10));
    
    
//    self.platbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [platView addSubview:self.platbtn];
//    [self.platbtn setTitle:@"请选择产品" forState:0];
//    [self.platbtn setTitleColor:[UIColor lightGrayColor] forState:0];
//    self.platbtn.titleLabel.font = Font(16);
//    self.platbtn.sd_layout
//    .topEqualToView(platView)
//    .bottomEqualToView(platView)
//    .leftSpaceToView(plat, AUTO(5))
//    .rightSpaceToView(platView, AUTO(10));
//    [self.platbtn sizeToFit];
    
    
    
    self.loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [YhbMethods setMainButtonHighLight:_loginBtn];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    _loginBtn.titleLabel.font=Font(AUTO(16));
    [self addSubview:_loginBtn];
    _loginBtn.sd_layout
    .topSpaceToView(platView, AUTO(20))
    .leftEqualToView(platView)
    .rightEqualToView(platView)
    .heightIs(AUTO(44));
    _loginBtn.sd_cornerRadius=@(AUTO(5));
    
    self.forgotBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_forgotBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [_forgotBtn setTitleColor:[YhbMethods colorWithHexString:COLOR_BIG_BUTTON] forState:UIControlStateNormal];
    [_forgotBtn setTitleColor:[YhbMethods colorWithHexString:COLOR_MAIN] forState:UIControlStateHighlighted];
    _forgotBtn.titleLabel.font=Font(AUTO(15));
    [self addSubview:_forgotBtn];
    _forgotBtn.sd_layout
    .topSpaceToView(_loginBtn, AUTO(15))
    .rightEqualToView(_loginBtn);
    [_forgotBtn setupAutoSizeWithHorizontalPadding:AUTO(10) buttonHeight:AUTO(20)];
    
    self.registBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_registBtn setTitleColor:[YhbMethods colorWithHexString:COLOR_BIG_BUTTON] forState:UIControlStateNormal];
    [_registBtn setTitleColor:[YhbMethods colorWithHexString:COLOR_MAIN] forState:UIControlStateHighlighted];
    _registBtn.titleLabel.font=Font(AUTO(15));
    [self addSubview:_registBtn];
    _registBtn.sd_layout
    .topSpaceToView(_loginBtn, AUTO(15))
    .leftEqualToView(_loginBtn);
    [_registBtn setupAutoSizeWithHorizontalPadding:AUTO(10) buttonHeight:AUTO(20)];
    
}


@end
