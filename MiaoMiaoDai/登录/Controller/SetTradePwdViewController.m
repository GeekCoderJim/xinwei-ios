//
//  SetTradePwdViewController.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/3/29.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "SetTradePwdViewController.h"
#import "TPPasswordTextView.h"
#import "TradePwdSecondViewController.h"

@interface SetTradePwdViewController ()

@end

@implementation SetTradePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"设置交易密码";
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UILabel *label=[[UILabel alloc]initWithFrame:Frame(0, AUTO(40), ScreenWidth, AUTO(30))];
    label.text=@"请设置交易密码";
    label.font=Font(AUTO(16));
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    TPPasswordTextView *view4 = [[TPPasswordTextView alloc] initWithFrame:CGRectMake(0, AUTO(80), AUTO(288), AUTO(44))];
    view4.center=CGPointMake(self.view.center.x, view4.center.y);
    view4.elementCount = 6;
    view4.elementBorderColor = [UIColor grayColor];
    view4.elementMargin = 5;
    [self.view addSubview:view4];
    view4.passwordDidChangeBlock = ^(NSString *password) {
        NSLog(@"%@",password);
        if (password.length>=6) {
            TradePwdSecondViewController *vc=[TradePwdSecondViewController new];
            vc.isReset=self.isReset;
            vc.phone=self.phone;
            vc.password=self.password;
            vc.tradePassword=password;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    };
    
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
