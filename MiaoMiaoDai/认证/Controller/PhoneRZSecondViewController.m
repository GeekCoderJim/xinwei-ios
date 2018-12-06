//
//  PhoneRZSecondViewController.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/4/10.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "PhoneRZSecondViewController.h"
#import "RZRequest.h"

@interface PhoneRZSecondViewController ()
{
    int time;
}
@property(strong,nonatomic)NSTimer *timer;
@property(strong,nonatomic)UIButton * resendBtn;

@end

@implementation PhoneRZSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"手机认证";
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    time=SecondsForMsg;

    
    UILabel *label=[UILabel new];
    label.text=@"您将收到一条验证短信";
    label.font=Font(AUTO(14));
    label.textColor=[UIColor darkGrayColor];
    [self.view addSubview:label];
    label.sd_layout
    .leftSpaceToView(self.view, AUTO(10))
    .topSpaceToView(self.view, AUTO(10))
    .autoHeightRatio(0);
    [label setSingleLineAutoResizeWithMaxWidth:300];
    
    
    UIView *view=[[UIView alloc]initWithFrame:Frame(0, AUTO(20), ScreenWidth, AUTO(49.5))];
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
    view.sd_layout
    .topSpaceToView(label, AUTO(10))
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(AUTO(49.5));
    
    UIImageView *img=[[UIImageView alloc]initWithFrame:Frame(AUTO(10), AUTO(13), AUTO(24), AUTO(24))];
    img.image=[UIImage imageNamed:@"icon_code"];
    [view addSubview:img];
    
    UITextField *text=[[UITextField alloc]init];
    text.frame=Frame(AUTO(50), 0, ScreenWidth-AUTO(205), AUTO(49.5));
    text.placeholder=@"输入验证码";
    text.tag=10001;
    text.keyboardType=UIKeyboardTypeNumberPad;
    [view addSubview:text];
    
    self.resendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_resendBtn setTitle:@"重新发送" forState:UIControlStateNormal];
    _resendBtn.titleLabel.font=Font(14);
    [_resendBtn setTitleColor:[YhbMethods colorWithHexString:COLOR_MAIN] forState:UIControlStateNormal];
    _resendBtn.frame=Frame(ScreenWidth-80, 0, 60, 49.5);
    [_resendBtn addTarget:self action:@selector(resendMsg) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_resendBtn];
    
    
    UIButton *addButton=[UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame=Frame(AUTO(20), AUTO(100), ScreenWidth-AUTO(40), AUTO(50));
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
        [AppUtils showAlertMessage:@"验证码不能为空"];
    }else{
        [RZRequest phoneRZSecondWithSmsCode:text.text lastResultString:_paramString success:^(id obj) {
            [self getStatus];
        }];
    }
  
}
-(void)getStatus{
    [RZRequest getUserVerifyStatus:^(id obj) {
        [AppUtils showSuccessMessage:@"保存成功，正在返回"];
        [YhbMethods performBlock:^{
            [AppUtils dismissHUD];
            [self.navigationController popToRootViewControllerAnimated:YES];
        } afterDelay:1.0f];
    }];
}

-(void)resendMsg{
    
    self.timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(daojishi) userInfo:nil repeats:YES];
    [RZRequest resendMessageWithLastRusult:self.paramString success:^(id obj) {
        BOOL rqs_success = [[NSString stringWithFormat:@"%@",obj[@"success"]]boolValue];
        if (rqs_success) {
            [AppUtils showTipsMessage:@"发送成功"];
        }else{
            [AppUtils showAlertMessage:obj[@"msg"]];
        }
    }];
}
-(void)daojishi{
    time--;
    
    [_resendBtn setTitle:[NSString stringWithFormat:@"%ds",time] forState:UIControlStateNormal];
    _resendBtn.enabled=NO;
    [_resendBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    if (time<=0) {
        _resendBtn.enabled=YES;
        [self.timer invalidate];
        self.timer = nil;
        [_resendBtn setTitleColor:[YhbMethods colorWithHexString:COLOR_BIG_BUTTON] forState:UIControlStateNormal];
        [_resendBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        time=SecondsForMsg;
    }
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
