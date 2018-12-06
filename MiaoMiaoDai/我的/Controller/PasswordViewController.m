//
//  PasswordViewController.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/3/3.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "PasswordViewController.h"
#import "LoginPwdViewController.h"
#import "TradePwdViewController.h"

@interface PasswordViewController ()

@end

@implementation PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"账号安全";

    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor=[UIColor whiteColor];
    [btn setTitle:@"修改登录密码" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font=Font(AUTO(16));
    btn.frame=Frame(0, 0, ScreenWidth, AUTO(50));
    [btn addTarget:self action:@selector(loginpassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.backgroundColor=[UIColor whiteColor];
    [btn2 setTitle:@"修改交易密码" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn2.titleLabel.font=Font(AUTO(16));
    btn2.frame=Frame(0, AUTO(51), ScreenWidth, AUTO(50));
    [btn2 addTarget:self action:@selector(tradpass) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:btn2];
    
}
-(void)loginpassword{
    [self.navigationController pushViewController:[LoginPwdViewController new] animated:YES];
}
-(void)tradpass{
    [self.navigationController pushViewController:[TradePwdViewController new] animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
