//
//  LoginViewController.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/2/28.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "RegistViewController.h"
#import "ForgetViewController.h"
#import "LoginRequest.h"
#import "BaseTabBarController.h"
#import "MMDCompanyModel.h"
#import "MMDProductVC.h"
#define Weak(wself) __weak typeof(self)(wself) = self

@interface LoginViewController ()<UITextFieldDelegate>
@property(strong,nonatomic)LoginView *loginview;
@property (nonatomic, strong) UIPickerView *companyPickView;
@property (nonatomic, strong) MMDCompanyModel *companyModel;
@property (nonatomic, strong) NSMutableArray *companyList;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"登录";
    self.loginview=[[LoginView alloc]initWithFrame:self.view.bounds];
    self.view = self.loginview;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.loginview.platTF.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.loginview.platTF addGestureRecognizer:tap];
//    _loginview.accountTextField.text=@"13850745359";
//    _loginview.passwordTextField.text=@"h18016620060";
    
//    _loginview.accountTextField.text=@"18060087933";
//    _loginview.passwordTextField.text=@"cwq136369";
    [self.loginview.loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.loginview.registBtn addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    [self.loginview.forgotBtn addTarget:self action:@selector(forget) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"关闭" style:0 target:self action:@selector(dismissVC)];
    
}
-(void)dismissVC{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(void)login{
    [_loginview.accountTextField resignFirstResponder];
    [_loginview.passwordTextField resignFirstResponder];
    if (_loginview.accountTextField.text.length!=11) {
        [AppUtils showTipsMessage:@"请输入正确的手机号"];
    }else{
        
        if (self.companyModel == nil) {
            [AppUtils showTipsMessage:@"请选择产品"];
            return;
        }
        
        NSString *accountString = _loginview.accountTextField.text;
        accountString = [NSString stringWithFormat:@"%@%@",_loginview.accountTextField.text,self.companyModel.ID];
        
        NSLog(@"%@",accountString);
  
        
        [LoginRequest loginWithPhoneNumber:_loginview.accountTextField.text password:_loginview.passwordTextField.text andCompanyId:[self.companyModel.ID integerValue] success:^(id obj) {
            if ([obj[@"code"] integerValue] ==200) {
                [YhbMethods writeUserDefaults:_loginview.accountTextField.text andKey:@"account"];
                [YhbMethods writeUserDefaults:_loginview.passwordTextField.text andKey:@"password"];
                [YhbMethods setBoolUserDefaults:YES andKey:@"isLogin"];
                [YhbMethods writeUserDefaults:[YhbMethods setDicNullClass:obj[@"content"]] andKey:@"userInfo"];
                UserEntity *user=[UserEntity shareUserEntity];
                user=[[UserEntity alloc]initWithDic:[YhbMethods setDicNullClass:obj[@"content"]]];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"isLogin" object:nil];
                
                [[UIApplication sharedApplication]keyWindow].rootViewController=[BaseTabBarController new];
                
                
            }else{
                [AppUtils showAlertMessage:obj[@"msg"]];
            }
            
        }];
    }
    
}
-(void)regist{
    [self.navigationController pushViewController:[RegistViewController new] animated:YES];
}
-(void)forget{
    [self.navigationController pushViewController:[ForgetViewController new] animated:YES];
}


-(void)tap:(UITapGestureRecognizer *)tap{
    
    if (self.loginview.accountTextField.text.length < 11) {
        [AppUtils showTipsMessage:@"请输入正确的手机号码"];
        return;
    }
    
    
    MMDProductVC *vc = [MMDProductVC new];
    vc.phoneNumber = self.loginview.accountTextField.text;
    Weak(wkself);
    vc.block = ^(MMDCompanyModel *model) {
        wkself.companyModel = model;
        wkself.loginview.platTF.text = model.name;
    };
    [self.navigationController pushViewController:vc animated:YES];

}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return NO;
}


@end
