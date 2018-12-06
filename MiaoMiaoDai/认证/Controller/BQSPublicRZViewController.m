//
//  BQSPublicRZViewController.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/8/1.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "BQSPublicRZViewController.h"
#import "BqsCrawlerCloudSDK.h"
#import "BqsServiceId.h"
#import "RZRequest.h"


#define Color_Btn_Disable @"#bfbfbf"

@interface BQSPublicRZViewController ()<BqsCrawlerCloudSDKDelegate>

@property(strong,nonatomic)NSString * typeName;
@property(strong,nonatomic)UIButton * nextBtn,*checkbtn;
@property(strong,nonatomic)UITextField *nameText,*pwdText;


@end

@implementation BQSPublicRZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [BqsCrawlerCloudSDK shared].fromController = self;
    [BqsCrawlerCloudSDK shared].delegate = self;
    //客户参数
    [BqsCrawlerCloudSDK shared].partnerId = @"xinweimy";
    [BqsCrawlerCloudSDK shared].certNo = self.userEntity.idCard;
    [BqsCrawlerCloudSDK shared].name = self.userEntity.name;
    [BqsCrawlerCloudSDK shared].mobile = self.userEntity.phoneNumber;
    [BqsCrawlerCloudSDK shared].themeColor = [YhbMethods colorWithHexString:COLOR_MAIN];
    switch (self.rzType) {
        case alipay:{
            self.title=@"支付宝认证";
            self.typeName=@"支付宝";
            
            if ([self.userEntity.alipayStatus boolValue]==YES) {
                [self setRZedView];
            }else{
                [self setupviews];
            }
        }
            break;
        case qzone:{
            self.title=@"QQ空间认证";
            self.typeName=@"QQ";
            
            if ([self.userEntity.qzoneStatus boolValue]==YES) {
                [self setRZedView];
            }else{
                [self setupviews];
            }
        }
            break;
        case linkedin:{
            self.title=@"领英认证";
            self.typeName=@"领英";
            
            if ([self.userEntity.linkedinStatus boolValue]==YES) {
                [self setRZedView];
            }else{
                [self setupviews];
            }
        }
            break;
        case weibo:{
            self.title=@"微博认证";
            self.typeName=@"微博";
            
            if ([self.userEntity.weiboStatus boolValue]==YES) {
                [self setRZedView];
            }else{
                [self setupviews];
            }
        }
            break;
        default:
            break;
    }
    
    
}


-(void)_checkbtnClick:(UIButton *)sender{
    sender.selected=!sender.selected;
    if (sender.isSelected) {
        if (_nameText.text.length!=0 && _pwdText.text.length!=0) {
            [self nextBtnEnable];
        }else{
            [self nextBtnDisable];
        }
    }else{
        [self nextBtnDisable];
    }
}
-(void)TextFieldTextDidChanged:(UITextField*)textField{
    if (_checkbtn.isSelected) {
        if (_nameText.text.length!=0 && _pwdText.text.length!=0 ) {
            [self nextBtnEnable];
        }else{
            [self nextBtnDisable];
        }
    }else{
        [self nextBtnDisable];
    }
}

-(void)next:(UIButton *)sender{
    
    switch (self.rzType) {
        case alipay:
                [[BqsCrawlerCloudSDK shared] loginAlipay];
            break;
        case qzone:
                [[BqsCrawlerCloudSDK shared] loginQQ];
            break;
        case linkedin:
                [[BqsCrawlerCloudSDK shared] loginLinkedIn];
            break;
        case weibo:
                [[BqsCrawlerCloudSDK shared] loginWeibo];
            break;
        default:
            break;
    }
    
}

#pragma mark - BqsCrawlerCloudSDKDelegate
-(void)onBqsCrawlerCloudResult:(NSString *)resultCode withDesc:(NSString *)resultDesc withServiceId:(int)serviceId{
    [AppUtils dismissHUD];
    NSLog(@"========resultCode=%@,resultDesc=%@", resultCode, resultDesc);
    NSString *type,*typeCode;
 
    if(ALIPAY_SERVICE_ID == serviceId){//运营商授权成功
        type = @"支付宝";
        typeCode = @"alipay";
    } else if(QZONE_SERVICE_ID == serviceId){//京东授权成功
        type = @"QQ空间";
        typeCode = @"qzone";
    } else if(LINKEDIN_SERVICE_ID == serviceId){//淘宝授权成功
        type = @"领英";
        typeCode = @"linkedin";
    } else if(WEIBO_SERVICE_ID == serviceId){//支付宝授权成功
        type = @"微博";
        typeCode = @"weibo";
    } else {
        
    }
    if([@"CCOM1000" isEqualToString:resultCode]){
        [self changeStatusWithTypeCode:typeCode];
    } else {
        [AppUtils showErrorMessage:[NSString stringWithFormat:@"%@授权失败\n%@",type,resultDesc]];
    }
}
-(void)changeStatusWithTypeCode:(NSString *)typecode{
    [RZRequest changeVerifyStatusWithType:typecode success:^(id obj) {
        [self getStatus];
    }];
}

-(void)getStatus{
    [RZRequest getUserVerifyStatus:^(id obj) {
        [AppUtils showSuccessMessage:@"认证成功！"];
        [YhbMethods performBlock:^{
            [AppUtils dismissHUD];
            [self.navigationController popViewControllerAnimated:YES];
        } afterDelay:1.0f];
    }];
}

-(void)setupviews{
//    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
//
//    UIView *bgView=[[UIView alloc]init];
//    bgView.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:bgView];
//    bgView.sd_layout.topSpaceToView(self.view, 10).leftSpaceToView(self.view, 10).rightSpaceToView(self.view, 10);
//    bgView.sd_cornerRadius=@(10);
//
//
//    UILabel *nameLabel = [[UILabel alloc]init];
//    nameLabel.text = [NSString stringWithFormat:@"%@账号",self.typeName];
//    nameLabel.textColor=[UIColor lightGrayColor];
//    nameLabel.font=Font(14);
//    [bgView addSubview:nameLabel];
//    nameLabel.sd_layout.topSpaceToView(bgView, 20).leftSpaceToView(bgView, 15).autoHeightRatio(0);
//    [nameLabel setSingleLineAutoResizeWithMaxWidth:300];
//
//    self.nameText  = [[UITextField alloc]init];
//    _nameText.tag=1000;
//    _nameText.borderStyle=UITextBorderStyleRoundedRect;
//    [_nameText addTarget:self action:@selector(TextFieldTextDidChanged:) forControlEvents:UIControlEventValueChanged];
//    [bgView addSubview:_nameText];
//    _nameText.sd_layout.topSpaceToView(nameLabel, 5).leftEqualToView(nameLabel).rightSpaceToView(bgView, 15).heightIs(40);
//
//
//    UILabel *pwdLabel = [[UILabel alloc]init];
//    pwdLabel.text = [NSString stringWithFormat:@"%@密码",self.typeName];
//    pwdLabel.textColor=[UIColor lightGrayColor];
//    pwdLabel.font=Font(14);
//    [bgView addSubview:pwdLabel];
//    pwdLabel.sd_layout.topSpaceToView(_nameText, 20).leftEqualToView(_nameText).autoHeightRatio(0);
//    [pwdLabel setSingleLineAutoResizeWithMaxWidth:300];
//
//    self.pwdText  = [[UITextField alloc]init];
//    _pwdText.tag=1001;
//    _pwdText.borderStyle=UITextBorderStyleRoundedRect;
//    [_pwdText addTarget:self action:@selector(TextFieldTextDidChanged:) forControlEvents:UIControlEventValueChanged];
//    [bgView addSubview:_pwdText];
//    _pwdText.sd_layout.topSpaceToView(pwdLabel, 5).leftEqualToView(_nameText).rightEqualToView(_nameText).heightIs(40);
//
//    self.checkbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_checkbtn setTitle:@"同意《数据服务协议》" forState:UIControlStateNormal];
//    [_checkbtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//    [_checkbtn setImage:Image(@"未选中") forState:UIControlStateNormal];
//    [_checkbtn setImage:Image(@"选中") forState:UIControlStateSelected];
//    _checkbtn.titleLabel.font=Font(14);
//    _checkbtn.selected=YES;
//    [bgView addSubview:_checkbtn];
//    _checkbtn.sd_layout.topSpaceToView(_pwdText, 15).leftEqualToView(_pwdText);
//    [_checkbtn setupAutoSizeWithHorizontalPadding:0 buttonHeight:20];
//    [_checkbtn addTarget:self action:@selector(_checkbtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    _checkbtn.imageView.sd_layout
//    .centerYEqualToView(_checkbtn)
//    .leftSpaceToView(_checkbtn, 0)
//    .heightIs(18)
//    .widthEqualToHeight();
//
//    _checkbtn.titleLabel.sd_layout
//    .centerYEqualToView(_checkbtn)
//    .leftSpaceToView(_checkbtn.imageView, 5)
//    .autoHeightRatio(0);
//    [_checkbtn.titleLabel setSingleLineAutoResizeWithMaxWidth:300];
//
//
//    [bgView setupAutoHeightWithBottomView:_checkbtn bottomMargin:20];
//
//    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
//    _nextBtn.backgroundColor=[YhbMethods colorWithHexString:Color_Btn_Disable];
//    [_nextBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
//    [self nextBtnDisable];
//    [self.view addSubview:_nextBtn];
//    _nextBtn.sd_layout.topSpaceToView(bgView, 20).leftSpaceToView(self.view, 30).rightSpaceToView(self.view, 30).heightIs(50);
//    _nextBtn.sd_cornerRadius=@(5);
//
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"开始认证" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.frame=CGRectMake(30, 60, ScreenWidth-60, 48);
    btn.backgroundColor = [YhbMethods colorWithHexString: COLOR_MAIN];
    [btn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [YhbMethods setView:btn CornerRadius:5 AndMasks:YES];
    [self.view addSubview:btn];
    
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
    label.text=@"您已完成认证";
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


-(void)nextBtnEnable{
    _nextBtn.enabled=YES;
    _nextBtn.backgroundColor=[YhbMethods colorWithHexString:COLOR_MAIN];
}
-(void)nextBtnDisable{
    _nextBtn.enabled=NO;
    _nextBtn.backgroundColor=[YhbMethods colorWithHexString:Color_Btn_Disable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
