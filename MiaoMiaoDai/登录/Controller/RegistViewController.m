//
//  RegistViewController.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/3/8.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "RegistViewController.h"
#import "JSMSConstant.h"
#import "JSMSSDK.h"
#import "LoginRequest.h"
#import "SetTradePwdViewController.h"

@interface RegistViewController ()<UITextFieldDelegate>
{
   int time;
}
@property(strong,nonatomic)UIButton *addButton;
@property(strong,nonatomic)NSTimer *timer;
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"用户注册";
    time=30;
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    NSArray *imgary=@[@"icon_phone",@"icon_password",@"icon_password",@"icon_code"];
    NSArray *placeary=@[@"请输入手机号码",@"请输入密码",@"请重复密码",@"请输入验证码"];
    for (int i = 0 ; i<4; i++) {
        UIView *view=[[UIView alloc]initWithFrame:Frame(0, i*AUTO(50), ScreenWidth, AUTO(49.5))];
        view.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:view];
        
        UIImageView *img=[[UIImageView alloc]initWithFrame:Frame(AUTO(10), AUTO(13), AUTO(24), AUTO(24))];
        img.image=[UIImage imageNamed:imgary[i]];
        [view addSubview:img];
        
        UITextField *text=[[UITextField alloc]initWithFrame:Frame(AUTO(50), 0, ScreenWidth-AUTO(55), AUTO(49.5))];
        text.placeholder=placeary[i];
        text.tag=1000+i;
        text.delegate=self;
        [view addSubview:text];
        [text addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

        
        
        if (i==3) {
            text.frame=Frame(AUTO(50), 0, ScreenWidth-AUTO(125), AUTO(49.5));
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=Frame(ScreenWidth-AUTO(90), 0, AUTO(80), AUTO(49.5));
            [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            btn.titleLabel.font=Font(AUTO(16));
            btn.tag=10000;
            btn.enabled=NO;
            [btn addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn];
            
        }
        if (i==0 || i ==3) {
            text.keyboardType=UIKeyboardTypeNumberPad;
            text.secureTextEntry=NO;
        }else{
            text.keyboardType=UIKeyboardTypeDefault;
            text.secureTextEntry=YES;
        }
    }
    UIButton *agreeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [agreeBtn setTitle:@" 我同意" forState:UIControlStateNormal];
    [agreeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [agreeBtn setImage:Image(@"icon_uncheck") forState:UIControlStateNormal];
    [agreeBtn setImage:Image(@"icon_checked") forState:UIControlStateSelected];
    agreeBtn.frame=Frame(0, AUTO(220), AUTO(180), AUTO(40));
    agreeBtn.center=CGPointMake(self.view.center.x, agreeBtn.center.y);
    [agreeBtn addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
    agreeBtn.tag=10001;
    [self.view addSubview:agreeBtn];
    agreeBtn.imageView.sd_layout
    .centerYEqualToView(agreeBtn)
    .leftSpaceToView(agreeBtn, AUTO(40))
    .heightIs(AUTO(24))
    .widthEqualToHeight();
    
    self.addButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _addButton.frame=Frame(AUTO(20), AUTO(270), ScreenWidth-AUTO(40), AUTO(50));
    [_addButton setTitle:@"提交" forState:UIControlStateNormal];
    [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _addButton.titleLabel.font=Font(AUTO(16));
    _addButton.backgroundColor=[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
    _addButton.enabled=NO;
    [YhbMethods setView:_addButton CornerRadius:AUTO(5) AndMasks:YES];
    [_addButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addButton];
    
}
int j = 0;
-(void)textFieldDidChange :(UITextField *)theTextField{
    j=0;
    UIButton *agreebtn=[self.view viewWithTag:10001];

    for (int i = 0; i<4; i++) {
        UITextField *text=[self.view viewWithTag:1000+i];
        if (text.text.length>0) {
            j++;
            if (j>=4) {
                if (agreebtn.selected==NO) {
                    _addButton.backgroundColor=[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
                    _addButton.enabled=NO;
                }else{
                    _addButton.backgroundColor=[YhbMethods colorWithHexString:COLOR_BIG_BUTTON];
                    _addButton.enabled=YES;
                }
            }
        }else{
            j--;
            if (j<4) {
                _addButton.backgroundColor=[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
                _addButton.enabled=NO;
            }
        }
    }
    UITextField *text=[self.view viewWithTag:1000];
    UIButton *btn=[self.view viewWithTag:10000];
    if (text.text.length!=11) {
        btn.enabled=NO;
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }else{
        btn.enabled=YES;
        [btn setTitleColor:[YhbMethods colorWithHexString:COLOR_BIG_BUTTON] forState:UIControlStateNormal];
    }

}

-(void)agree:(UIButton *)btn{
    btn.selected=!btn.selected;
    if (btn.selected==NO) {
        _addButton.backgroundColor=[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
        _addButton.enabled=NO;
    }else{
        if (j>=4) {
            _addButton.backgroundColor=[YhbMethods colorWithHexString:COLOR_BIG_BUTTON];
            _addButton.enabled=YES;
        }else{
            _addButton.backgroundColor=[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
            _addButton.enabled=NO;
        }
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
        time=30;
    }
}
-(void)getCode{
    self.timer=[NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(daojishi) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    UIButton *btn=[self.view viewWithTag:10000];
    [btn setTitle:@"30s" forState:UIControlStateNormal];
    btn.enabled=NO;
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    UITextField *text=[self.view viewWithTag:1000];
    [JSMSSDK getVerificationCodeWithPhoneNumber:text.text andTemplateID:@"1" completionHandler:^(id  _Nullable resultObject, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"Get verification code success!");
            [AppUtils showTipsMessage:@"发送成功"];
        }else{
            NSLog(@"Get verification code failure!");
            [AppUtils showTipsMessage:@"发送失败，请重试"];
            NSLog(@"%@",error);
        }
    }];
}
-(void)next{
    //验证验证码
    UITextField *text=[self.view viewWithTag:1000];
    UITextField *text2=[self.view viewWithTag:1001];
    UITextField *text4=[self.view viewWithTag:1003];
    [JSMSSDK commitWithPhoneNumber:text.text verificationCode:text4.text completionHandler:^(id resultObject, NSError *error) {
        if (!error) {
            NSLog(@"Commit verification vode success!");
            SetTradePwdViewController *vc=[SetTradePwdViewController new];
            vc.phone=text.text;
            vc.password=text2.text;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            NSLog(@"%@",error);
            [AppUtils showTipsMessage:@"验证码输入失败"];
            NSLog(@"Commit verification code failure!");
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
