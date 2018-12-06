//
//  PhoneRZViewController.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/3/2.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "PhoneRZViewController.h"
#import "CommonUseWebViewController.h"
#import "RZRequest.h"
#import "PhoneRZSecondViewController.h"

@interface PhoneRZViewController ()
{
    UITextField *phoneText,*passText;
}
@end

@implementation PhoneRZViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title=@"手机认证";
    
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
//    if ([self.userEntity.phoneStatus boolValue]==YES) {
//        [self setRZedView];
//    }else{
        [self setupviews];
//    }
  
}
-(void)setupviews{
    UIView *view=[[UIView alloc]initWithFrame:Frame(0, AUTO(10), ScreenWidth, AUTO(100))];
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
    
    UIView *sep=[[UIView alloc]initWithFrame:Frame(0, AUTO(50), ScreenWidth, AUTO(0.5))];
    sep.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [view addSubview:sep];
    
    UILabel *phone=[[UILabel alloc]initWithFrame:Frame(AUTO(10), 0, AUTO(60), AUTO(50))];
    phone.text=@"手机号";
    phone.font=Font(AUTO(13));
    [view addSubview:phone];
    
    UILabel *pass=[[UILabel alloc]initWithFrame:Frame(AUTO(10), AUTO(50), AUTO(60), AUTO(50))];
    pass.text=@"服务密码";
    pass.font=Font(AUTO(13));
    [view addSubview:pass];
    
    phoneText=[[UITextField alloc]initWithFrame:Frame(AUTO(70), 0, ScreenWidth-AUTO(80), AUTO(50))];
    phoneText.font=Font(AUTO(13));
    phoneText.text=self.userEntity.phoneNumber;
    phoneText.keyboardType=UIKeyboardTypeNumberPad;
    phoneText.placeholder=@"输入手机号码";
    [view addSubview:phoneText];
    
    passText=[[UITextField alloc]initWithFrame:Frame(AUTO(70), AUTO(50), ScreenWidth-AUTO(180), AUTO(50))];
    passText.font=Font(AUTO(13));
    passText.placeholder=@"输入服务密码";
    passText.secureTextEntry=YES;
    [view addSubview:passText];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame=Frame(ScreenWidth-AUTO(110), AUTO(50), AUTO(100), AUTO(50));
    [btn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    btn.titleLabel.font=Font(AUTO(15));
    [view addSubview:btn];
    [btn addTarget:self action:@selector(forget) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *addButton=[UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame=Frame(AUTO(20), AUTO(130), ScreenWidth-AUTO(40), AUTO(50));
    [addButton setTitle:@"认证" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addButton.titleLabel.font=Font(AUTO(16));
    addButton.backgroundColor=[YhbMethods colorWithHexString:COLOR_BIG_BUTTON];
    [YhbMethods setView:addButton CornerRadius:AUTO(5) AndMasks:YES];
    [addButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    
    UILabel *tips=[UILabel new];
    tips.textColor=[UIColor lightGrayColor];
    tips.font=Font(AUTO(13));
    tips.text=@"温馨提示：\n1.运营商信息用于我们对您的信用进行综合评定\n2.提供运营商信息，有助于您通过审核\n3.秒秒贷将严格保护用户隐私\n4.认证时间可能比较长，请耐心等待";
    [self.view addSubview:tips];
    tips.sd_layout
    .topSpaceToView(addButton, AUTO(20))
    .leftSpaceToView(self.view, AUTO(10))
    .rightSpaceToView(self.view, AUTO(10))
    .autoHeightRatio(0);
    
}

-(void)setRZedView{
    UIView *topview=[[UIView alloc]init];
    topview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:topview];
    topview.sd_layout
    .topSpaceToView(self.view, AUTO(10))
    .leftEqualToView(self.view)
    .rightEqualToView(self.view);
    
    UIImageView *img=[[UIImageView alloc]initWithImage:Image(@"icon_checked")];
    [topview addSubview:img];
    img.sd_layout
    .topSpaceToView(topview, AUTO(20))
    .centerXEqualToView(topview)
    .heightIs(AUTO(80))
    .widthEqualToHeight();
    
    UILabel *label=[UILabel new];
    label.text=@"您已完成手机认证";
    label.font=Font(AUTO(18));
    label.textColor=[YhbMethods colorWithHexString:@"#02C701"];
    [topview addSubview:label];
    label.sd_layout
    .topSpaceToView(img, AUTO(15))
    .centerXEqualToView(img)
    .autoHeightRatio(0);
    [label setSingleLineAutoResizeWithMaxWidth:300];
    [topview setupAutoHeightWithBottomView:label bottomMargin:AUTO(20)];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点击返回" forState:UIControlStateNormal];
    btn.titleLabel.font=Font(AUTO(16));
    btn.backgroundColor=label.textColor;
    [self.view addSubview:btn];
    
    btn.sd_layout
    .topSpaceToView(topview, AUTO(20))
    .leftSpaceToView(self.view, AUTO(20))
    .rightSpaceToView(self.view, AUTO(20))
    .heightIs(AUTO(44));
    btn.sd_cornerRadius=@(AUTO(5));
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)forget{
    CommonUseWebViewController *vc=[CommonUseWebViewController new];
    vc.type=@"local";
    vc.LocalFileName=@"FindPassword";
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)next{
    [RZRequest phoneRZWithPhone:phoneText.text password:passText.text success:^(id obj) {
        PhoneRZSecondViewController *vc = [PhoneRZSecondViewController new];
        vc.paramString=obj;
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
