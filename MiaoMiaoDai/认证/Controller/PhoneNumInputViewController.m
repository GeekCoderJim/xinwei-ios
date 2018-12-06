//
//  PhoneNumInputViewController.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/7/26.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "PhoneNumInputViewController.h"
#import "CommonUseWebViewController.h"

#define URL_BYSJ @"http://app.qzxwmy.com:8080/xinwei-server/app/v2/secondPhone/verifyUrl/"

@interface PhoneNumInputViewController ()

@property(strong,nonatomic)UITextField * inputText;

@end

@implementation PhoneNumInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"输入备用手机号";
    
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 50)];
    bgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bgView];
    
    self.inputText = [[UITextField alloc]initWithFrame:Frame(10, 0, ScreenWidth-20, 50)];
    _inputText.placeholder=@"请输入备用手机号码";
    [bgView addSubview:_inputText];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.backgroundColor = [YhbMethods colorWithHexString:COLOR_MAIN];
    nextBtn.frame=Frame(30, 90, ScreenWidth-60, 48);
    [nextBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
}

-(void)next{
    if (_inputText.text.length!=11) {
        [AppUtils showTipsMessage:@"请输入11位手机号码"];
    }else if ([_inputText.text isEqualToString:self.userEntity.phoneNumber]) {
        [AppUtils showAlertMessage:@"备用号码不能与主账号相同"];
    }else{
        CommonUseWebViewController *vc=[CommonUseWebViewController new];
        vc.urlStr=[NSString stringWithFormat:@"%@%@/%@",URL_BYSJ,self.userEntity.phoneNumber,_inputText.text];
        vc.titleStr=@"备用手机认证";
        [self.navigationController pushViewController:vc animated:YES];
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
