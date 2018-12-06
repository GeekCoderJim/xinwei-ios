//
//  TradePwdSecondViewController.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/3/29.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "TradePwdSecondViewController.h"
#import "TPPasswordTextView.h"
#import "LoginRequest.h"
#import "MineRequest.h"


@interface TradePwdSecondViewController ()

@end

@implementation TradePwdSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"确认交易密码";
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UILabel *label=[[UILabel alloc]initWithFrame:Frame(0, AUTO(40), ScreenWidth, AUTO(30))];
    label.text=@"请再次输入交易密码";
    label.font=Font(AUTO(16));
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    TPPasswordTextView *view4 = [[TPPasswordTextView alloc] initWithFrame:CGRectMake(0, AUTO(80), AUTO(288), AUTO(44))];
    view4.center=CGPointMake(self.view.center.x, view4.center.y);
    view4.elementCount = 6;
    view4.elementBorderColor = [UIColor grayColor];
    view4.elementMargin = 5;
    [self.view addSubview:view4];
    __weak typeof(view4) weakview=view4;
    view4.passwordDidChangeBlock = ^(NSString *password) {
        NSLog(@"%@",password);
        if (password.length>=6) {
            if ([password isEqualToString:self.tradePassword]==NO) {
                [AppUtils showAlertMessage:@"两次输入不一致，请重新输入"];
                [weakview clearPassword];
            }else{
                if (_isReset==YES) {
                    [self reset];
                }else{
                    [self regist];
                }
            }
        }
    };
}

-(void)regist{
    [LoginRequest registWithPhoneNumber:_phone password:_password tradepassword:_tradePassword success:^(id obj) {
        [AppUtils showSuccessMessage:@"注册成功，正在返回登录界面"];
        [YhbMethods performBlock:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        } afterDelay:1.0];
    }];
}

-(void)reset{
    [MineRequest resetTradePasswordWithNewPassword:_tradePassword success:^(id obj) {
        [AppUtils showSuccessMessage:@"重置成功，正在返回"];
        [YhbMethods performBlock:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        } afterDelay:1.0];
    }];
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
