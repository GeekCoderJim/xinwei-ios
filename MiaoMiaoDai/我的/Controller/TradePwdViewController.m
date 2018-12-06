//
//  TradePwdViewController.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/3/3.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "TradePwdViewController.h"
#import "JSMSSDK.h"
#import "SetTradePwdViewController.h"

@interface TradePwdViewController ()
{
    int time;
}

@property(strong,nonatomic)NSTimer *timer;
@end

@implementation TradePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"修改交易密码";
    time=60;
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    UIView *view=[[UIView alloc]initWithFrame:Frame(0, AUTO(0), ScreenWidth, AUTO(49.5))];
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
    
    UIImageView *img=[[UIImageView alloc]initWithFrame:Frame(AUTO(10), AUTO(13), AUTO(24), AUTO(24))];
    img.image=[UIImage imageNamed:@"icon_code"];
    [view addSubview:img];
    
    UITextField *text=[[UITextField alloc]init];
    text.frame=Frame(AUTO(50), 0, ScreenWidth-AUTO(125), AUTO(49.5));
    text.placeholder=@"输入验证码";
    text.tag=10001;
    text.keyboardType=UIKeyboardTypeNumberPad;
    [view addSubview:text];

    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=Frame(ScreenWidth-AUTO(90), 0, AUTO(80), AUTO(49.5));
    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    btn.enabled=YES;
    [btn setTitleColor:[YhbMethods colorWithHexString:COLOR_BIG_BUTTON] forState:UIControlStateNormal];
    btn.titleLabel.font=Font(AUTO(16));
    btn.tag=10000;
    [view addSubview:btn];
    [btn addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    

    UIButton *addButton=[UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame=Frame(AUTO(20), AUTO(70), ScreenWidth-AUTO(40), AUTO(50));
    [addButton setTitle:@"提交" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addButton.titleLabel.font=Font(AUTO(16));
    addButton.backgroundColor=[YhbMethods colorWithHexString:COLOR_BIG_BUTTON];
    [YhbMethods setView:addButton CornerRadius:AUTO(5) AndMasks:YES];
    [addButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
}
-(void)next{
    UITextField *text=[self.view viewWithTag:10001];
    if (text.text.length<=0) {
        [AppUtils showAlertMessage:@"验证码输入错误"];
    }else{
        [JSMSSDK commitWithPhoneNumber:self.userEntity.phoneNumber verificationCode:text.text completionHandler:^(id resultObject, NSError *error) {
            if (!error) {
                
                [AppUtils showTipsMessage:@"验证码输入成功"];
                SetTradePwdViewController *vc=[SetTradePwdViewController new];
                vc.isReset=YES;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                NSLog(@"%@",error);
                [AppUtils showTipsMessage:@"验证码输入错误"];
            }
        }];
    }
}

-(void)daojishi{
    time--;
    UIButton *btn=[self.view viewWithTag:10000];
    [btn setTitle:[NSString stringWithFormat:@"%ds",time] forState:UIControlStateNormal];
    btn.enabled=NO;
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    if (time<=0) {
        btn.enabled=YES;
        [self.timer invalidate];
        self.timer = nil;
        [btn setTitleColor:[YhbMethods colorWithHexString:COLOR_BIG_BUTTON] forState:UIControlStateNormal];
        [btn setTitle:@"重新获取" forState:UIControlStateNormal];
        time=60;
    }
}
-(void)getCode{
    self.timer=[NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(daojishi) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    UIButton *btn=[self.view viewWithTag:10000];
    [btn setTitle:@"60s" forState:UIControlStateNormal];
    btn.enabled=NO;
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    [JSMSSDK getVerificationCodeWithPhoneNumber:self.userEntity.phoneNumber andTemplateID:@"1" completionHandler:^(id  _Nullable resultObject, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"Get verification code success!");
            [AppUtils showTipsMessage:@"发送成功"];
        }else{
            NSLog(@"Get verification code failure!");
            [AppUtils showTipsMessage:@"发送失败，请重试"];
            time=0;
            NSLog(@"%@",error);
        }
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
