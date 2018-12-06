//
//  RZViewController.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/2/28.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "RZViewController.h"
#import "RZTableViewCell.h"
#import "PersonInfoViewController.h"
#import "PhoneRZViewController.h"
#import "SFRZViewController.h"
#import "LoginViewController.h"
#import "ContactsRZViewController.h"
#import "CommonUseWebViewController.h"
#import "AddPhotoViewController.h"
#import "BankcardRZViewController.h"
#import "RZRequest.h"
#import "PhoneNumInputViewController.h"
#import "BQSPublicRZViewController.h"
#import "AliRPVC.h"



#import "RealPeopleCertification.h"


#define URL_TAOBAO @"http://app.qzxwmy.com:8080/xinwei-server/app/bqs/get_verify_url/tb/" //后面拼接手机号
#define URL_JINGDONG @"http://app.qzxwmy.com:8080/xinwei-server/app/bqs/get_verify_url/jd/" //后面拼接手机号
#define URL_DIDI @"http://app.qzxwmy.com:8080/xinwei-server/app/bqs/get_verify_url/didi/" //后面拼接手机号
#define URL_GONGJIJIN @"http://app.qzxwmy.com:8080/xinwei-server/app/bqs/get_verify_url/hfund/" //后面拼接手机号
#define URL_XUEXINWANG @"http://app.qzxwmy.com:8080/xinwei-server/app/bqs/get_verify_url/chsi/" //后面拼接手机号
#define URL_MAIMAI @"http://app.qzxwmy.com:8080/xinwei-server/app/bqs/get_verify_url/maimai/" //后面拼接手机号
#define URL_ZMXY @"/app/bqs/get_verify_url/zm/" //后面拼接手机号
#define URL_SJRZ @"/app/bqs/get_verify_url/mno/"
@interface RZViewController ()<UIAlertViewDelegate>

@property(copy,nonatomic)NSArray *dataSource,*enterpriseArray;
@end

@implementation RZViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    
    if ([YhbMethods readBOOLUserDefault:@"isLogin"]==YES) {
      [self getgetUserVerifyStatus];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadImages) name:NotificationName_UserEntityReload object:nil];
    
}
-(void)getgetUserVerifyStatus{
    [SVProgressHUD showWithStatus:@"载入中..."];
    
    [RZRequest getUserVerifyStatus:^(id obj) {
        [self reloadImages];
    }];
}

-(void)reloadImages{
    for (int i = 0; i < self.dataSource.count; i++) {
        UIButton *btn  = [self.view viewWithTag:1000+i];
        switch (i) {
            case 0:
            {
                if ([self.userEntity.identityInfoStatus boolValue]) {
                    [btn setImage:Image(@"icon_photo_1") forState:UIControlStateNormal];
                }
            }
                break;
            case 1:
            {
                if ([self.userEntity.userInfoStatus boolValue]) {
                    [btn setImage:Image(@"icon_personInfo_1") forState:UIControlStateNormal];
                }
            }
                break;
            case 2:
            {
                if ([self.userEntity.bankInfoStatus boolValue]) {
                    [btn setImage:Image(@"icon_bank_1") forState:UIControlStateNormal];
                }
            }
                break;
            
//            case 3:
//            {
//                if ([self.userEntity.alipayStatus boolValue]) {
//                    [btn setImage:Image(@"icon_zfb_1") forState:UIControlStateNormal];
//                }
//            }
//                break;
            case 3:
            {
                if ([self.userEntity.zmStatus boolValue]) {
                    [btn setImage:Image(@"icon_zm_1") forState:UIControlStateNormal];
                }
            }
                break;
//            case 5:
//            {
//                if ([self.userEntity.taobaoStatus boolValue]) {
//                    [btn setImage:Image(@"icon_taobao_1") forState:UIControlStateNormal];
//                }
//            }
//                break;
            case 4:
            {
                if ([self.userEntity.operatorStatus boolValue]) {
                    [btn setImage:Image(@"icon_phone_1") forState:UIControlStateNormal];
                }
            }
                break;
            case 5:
            {
                if ([self.userEntity.contactStatus boolValue]) {
                    [btn setImage:Image(@"icon_contact_1") forState:UIControlStateNormal];
                }
            }
                break;
            default:
                break;
        }
    }
    
    for (int i = 0; i<self.enterpriseArray.count; i++) {
        UIButton *btn  = [self.view viewWithTag:1100+i];
        switch (i) {
            
            case 0:
            {
                if ([self.userEntity.jdStatus boolValue]) {
                    [btn setImage:Image(@"icon_jd_1") forState:UIControlStateNormal];
                }
            }
                break;
            case 1:
            {
                if ([self.userEntity.ddStatus boolValue]) {
                    [btn setImage:Image(@"icon_didi_1") forState:UIControlStateNormal];
                }
            }
                break;
            case 2:
            {
                if ([self.userEntity.gjjStatus boolValue]) {
                    [btn setImage:Image(@"icon_gjj_1") forState:UIControlStateNormal];
                }
            }
                break;
            case 3:
            {
              if ([self.userEntity.chsiStatus boolValue]) {
                [btn setImage:Image(@"icon_xxw_1") forState:UIControlStateNormal];
              }
            }
              break;
            case 4:
            {
                if ([self.userEntity.maimaiStatus boolValue]) {
                    [btn setImage:Image(@"icon_maimai_1") forState:UIControlStateNormal];
                }
            }
                break;
            case 5:
            {
                if ([self.userEntity.mnoStatus boolValue]) {
                    [btn setImage:Image(@"icon_bysj_1") forState:UIControlStateNormal];
                }
            }
                break;
            case 6:
            {
                if ([self.userEntity.qzoneStatus boolValue]) {
                    [btn setImage:Image(@"icon_qzone_1") forState:UIControlStateNormal];
                }
            }
                break;
            case 7:
            {
                if ([self.userEntity.linkedinStatus boolValue]) {
                    [btn setImage:Image(@"icon_linkin_1") forState:UIControlStateNormal];
                }
            }
                break;
            case 8:
            {
                if ([self.userEntity.weiboStatus boolValue]) {
                    [btn setImage:Image(@"icon_weibo_1") forState:UIControlStateNormal];
                }
            }
                break;
            case 9:
            {
                if ([self.userEntity.phoneStatus boolValue]) {
                    [btn setImage:Image(@"icon_phone_1") forState:UIControlStateNormal];
                }
            }
                break;
            default:
                break;
        }
    }
    
    
}


-(void)setupUI{
    
    self.dataSource=@[
                      @{@"title":@"身份认证",@"icon":@"icon_photo_0"},
                      @{@"title":@"个人信息",@"icon":@"icon_personInfo_0"},
                      @{@"title":@"银行卡认证",@"icon":@"icon_bank_0"},
//                      @{@"title":@"支付宝认证",@"icon":@"icon_zfb_0"},
                      @{@"title":@"芝麻信用认证",@"icon":@"icon_zm_0"},
//                      @{@"title":@"淘宝认证",@"icon":@"icon_taobao_0"},
                      @{@"title":@"运营商认证",@"icon":@"icon_phone_0"},
                      @{@"title":@"通讯录认证",@"icon":@"icon_contact_0"},
                      ];
//    self.enterpriseArray=@[@{@"title":@"京东认证",@"icon":@"icon_jd_0"},
//                           @{@"title":@"滴滴认证",@"icon":@"icon_didi_0"},
//                           @{@"title":@"公积金认证",@"icon":@"icon_gjj_0"},
//                           @{@"title":@"学信网认证",@"icon":@"icon_xxw_0"},
//                           @{@"title":@"脉脉认证",@"icon":@"icon_maimai_0"},
//                           @{@"title":@"备用手机认证",@"icon":@"icon_bysj_0"},
//                           @{@"title":@"QQ空间认证",@"icon":@"icon_qzone_0"},
//                           @{@"title":@"领英认证",@"icon":@"icon_linkin_0"},
//                           @{@"title":@"微博认证",@"icon":@"icon_weibo_0"},
//                           @{@"title":@"手机认证",@"icon":@"icon_phone_0"},
//                           ];
    
    UIScrollView *scroll=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.view=scroll;
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    UILabel *basicRZ=[UILabel new];
    
    basicRZ.text=@"基础认证（请按顺序填写）";
    if (isAppStore) {
        basicRZ.text=@"";
    }
    basicRZ.textColor=[UIColor darkGrayColor];
    basicRZ.font=Font(AUTO(15));
    [self.view addSubview:basicRZ];
    basicRZ.sd_layout
    .topSpaceToView(self.view, AUTO(10))
    .leftSpaceToView(self.view, AUTO(10))
    .autoHeightRatio(0);
    [basicRZ setSingleLineAutoResizeWithMaxWidth:300];

    UIView * _autoWidthViewsContainer = [UIView new];
    [self.view addSubview:_autoWidthViewsContainer];
    
    if (isAppStore) {
        _autoWidthViewsContainer.sd_layout.heightIs(0);
    }else{
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < self.dataSource.count; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            [_autoWidthViewsContainer addSubview:btn];
            btn.sd_layout.heightIs(AUTO(90));
            [btn setTitleColor:[YhbMethods colorWithHexString:@"#666666"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:self.dataSource[i][@"icon"]] forState:UIControlStateNormal];
            [btn setTitle:[NSString stringWithFormat:@"%@",self.dataSource[i][@"title"]] forState:UIControlStateNormal];
            btn.titleLabel.font=Font(AUTO(13));
            btn.titleLabel.adjustsFontSizeToFitWidth=YES;
            btn.tag=1000+i;
            [btn addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.backgroundColor=[UIColor whiteColor];
            [temp addObject:btn];
            
            btn.imageView.sd_layout
            .topSpaceToView(btn, AUTO(10))
            .centerXEqualToView(btn)
            .widthIs(AUTO(50))
            .heightEqualToWidth();
            
            btn.titleLabel.sd_layout
            .topSpaceToView(btn.imageView, AUTO(7))
            .centerXEqualToView(btn)
            .autoHeightRatio(0);
            [btn.titleLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth/3];
        }
        
        _autoWidthViewsContainer.sd_layout
        .leftSpaceToView(self.view, AUTO(0))
        .rightSpaceToView(self.view, AUTO(0))
        .topSpaceToView(basicRZ, AUTO(10));
        // 此步设置之后_autoWidthViewsContainer的高度可以根据子view自适应
        [_autoWidthViewsContainer setupAutoWidthFlowItems:[temp copy] withPerRowItemsCount:4 verticalMargin:AUTO(1) horizontalMargin:AUTO(1) verticalEdgeInset:0 horizontalEdgeInset:AUTO(0)];
    }
    
    UILabel *gaojiRZ=[UILabel new];
//    gaojiRZ.text=@"高级认证（有助于提额和加快审核）";
    gaojiRZ.textColor=[UIColor darkGrayColor];
    gaojiRZ.font=Font(AUTO(15));
    [self.view addSubview:gaojiRZ];
    gaojiRZ.sd_layout
    .topSpaceToView(_autoWidthViewsContainer, AUTO(20))
    .leftSpaceToView(self.view, AUTO(10))
    .autoHeightRatio(0);
    [gaojiRZ setSingleLineAutoResizeWithMaxWidth:300];
    
    UIView * _autoWidthViewsContainer2 = [UIView new];
    [self.view addSubview:_autoWidthViewsContainer2];
    
    
    NSMutableArray *temp2 = [NSMutableArray new];
    for (int i = 0; i < self.enterpriseArray.count; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_autoWidthViewsContainer2 addSubview:btn];
        btn.sd_layout.heightIs(AUTO(90));
        [btn setTitleColor:[YhbMethods colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:self.enterpriseArray[i][@"icon"]] forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"%@",self.enterpriseArray[i][@"title"]] forState:UIControlStateNormal];
        btn.titleLabel.font=Font(AUTO(13));
        btn.titleLabel.adjustsFontSizeToFitWidth=YES;
        btn.tag=1100+i;
        [btn addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor=[UIColor whiteColor];
        [temp2 addObject:btn];
        
        btn.imageView.sd_layout
        .topSpaceToView(btn, AUTO(10))
        .centerXEqualToView(btn)
        .widthIs(AUTO(50))
        .heightEqualToWidth();
        
        btn.titleLabel.sd_layout
        .topSpaceToView(btn.imageView, AUTO(7))
        .centerXEqualToView(btn)
        .autoHeightRatio(0);
        [btn.titleLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth/3];
    }
    
    _autoWidthViewsContainer2.sd_layout
    .leftSpaceToView(self.view, AUTO(0))
    .rightSpaceToView(self.view, AUTO(0))
    .topSpaceToView(gaojiRZ, AUTO(10));
    
    // 此步设置之后_autoWidthViewsContainer的高度可以根据子view自适应
    [_autoWidthViewsContainer2 setupAutoWidthFlowItems:[temp2 copy] withPerRowItemsCount:4 verticalMargin:AUTO(1) horizontalMargin:AUTO(1) verticalEdgeInset:0 horizontalEdgeInset:AUTO(0)];
    
    
    [scroll setupAutoContentSizeWithBottomView:_autoWidthViewsContainer2 bottomMargin:AUTO(10)];
}
-(void)toLogin{
    LoginViewController *vc=[LoginViewController new];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
    nav.navigationBar.translucent=NO;
    nav.navigationBar.barTintColor=[YhbMethods colorWithHexString:COLOR_MAIN];
    nav.navigationBar.tintColor=[UIColor whiteColor];
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)ButtonClick:(UIButton *)btn{
    if ([YhbMethods readBOOLUserDefault:@"isLogin"]==YES) {
        if (btn.tag-1000==0)
        {//身份认证
             if ([self.userEntity.identityInfoStatus boolValue]) {
                 [AppUtils showTipsMessage:@"您已经通过实人认证"];
             }else{
                 [self aliRPVertify];
             }
            


        }else if (btn.tag-1000==1)
        {//个人认证

            if ([self.userEntity.identityInfoStatus boolValue]) {
                PersonInfoViewController *vc=[PersonInfoViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                [self aliRPVertify];
            }
        
        }
        else if (btn.tag-1000==2){//银行卡认证
            if ([self.userEntity.bankInfoStatus boolValue]){
                [AppUtils showSuccessMessage:@"您已经通过银行卡认证"];
            }else
            {
                if ([self.userEntity.identityInfoStatus boolValue]==YES) {
                    BankcardRZViewController *vc=[BankcardRZViewController new];
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    [self aliRPVertify];
                }
            }
            
        }
//        else if (btn.tag-1000==4){
//            if ([self.userEntity.userInfoStatus boolValue]==YES) {
//                BQSPublicRZViewController *vc = [BQSPublicRZViewController new];
//                vc.rzType = alipay;
//                [self.navigationController pushViewController:vc animated:YES];
//            }else{
//                PersonInfoViewController *vc=[PersonInfoViewController new];
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//        }
        else if (btn.tag-1000==3){
            if ([self.userEntity.identityInfoStatus boolValue]==YES) {
                CommonUseWebViewController *vc=[CommonUseWebViewController new];
                NSString * hostStr = [self requestUrlWithPath:URL_ZMXY];
                vc.urlStr=[NSString stringWithFormat:@"%@%@",hostStr,self.userEntity.token];
                vc.titleStr=@"芝麻信用认证";
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [self aliRPVertify];
            }
        }
//        else if (btn.tag-1000==5){
//            if ([self.userEntity.userInfoStatus boolValue]==YES) {
//                CommonUseWebViewController *vc=[CommonUseWebViewController new];
//                vc.urlStr=[NSString stringWithFormat:@"%@%@",URL_TAOBAO,self.userEntity.phoneNumber];
//                vc.titleStr=@"淘宝认证";
//                [self.navigationController pushViewController:vc animated:YES];
//            }else{
//                PersonInfoViewController *vc=[PersonInfoViewController new];
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//        }
        else if (btn.tag-1000==4){//手机认证
            if ([self.userEntity.identityInfoStatus boolValue]==YES) {
                CommonUseWebViewController *vc=[CommonUseWebViewController new];
                NSString * hostStr = [self requestUrlWithPath:URL_SJRZ];
                vc.urlStr=[NSString stringWithFormat:@"%@%@",hostStr,self.userEntity.token];
                vc.titleStr=@"手机认证";
                [self.navigationController pushViewController:vc animated:YES];
            }else{
//                PersonInfoViewController *vc=[PersonInfoViewController new];
//                [self.navigationController pushViewController:vc animated:YES];
                [self aliRPVertify];
            }
            
        }else if (btn.tag-1000==5){//通讯录认证
            if ([self.userEntity.userInfoStatus boolValue]==YES) {
                ContactsRZViewController *vc=[ContactsRZViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
//                PersonInfoViewController *vc=[PersonInfoViewController new];
//                [self.navigationController pushViewController:vc animated:YES];
                [self aliRPVertify];
            }
        }
        else if (btn.tag-1100==0){
            if ([self.userEntity.userInfoStatus boolValue]==YES) {
                CommonUseWebViewController *vc=[CommonUseWebViewController new];
                vc.urlStr=[NSString stringWithFormat:@"%@%@",URL_JINGDONG,self.userEntity.token];
                vc.titleStr=@"京东认证";
                [self.navigationController pushViewController:vc animated:YES];
            }else{
//                PersonInfoViewController *vc=[PersonInfoViewController new];
//                [self.navigationController pushViewController:vc animated:YES];
                [self aliRPVertify];
            }
        }else if (btn.tag-1100==1){
            if ([self.userEntity.userInfoStatus boolValue]==YES) {
                CommonUseWebViewController *vc=[CommonUseWebViewController new];
                vc.urlStr=[NSString stringWithFormat:@"%@%@",URL_DIDI,self.userEntity.token];
                vc.titleStr=@"滴滴认证";
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                PersonInfoViewController *vc=[PersonInfoViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else if (btn.tag-1100==2){
            if ([self.userEntity.userInfoStatus boolValue]==YES) {
                CommonUseWebViewController *vc=[CommonUseWebViewController new];
                vc.urlStr=[NSString stringWithFormat:@"%@%@",URL_GONGJIJIN,self.userEntity.token];
                vc.titleStr=@"公积金认证";
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                PersonInfoViewController *vc=[PersonInfoViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else if (btn.tag-1100==3){
            if ([self.userEntity.userInfoStatus boolValue]==YES) {
                CommonUseWebViewController *vc=[CommonUseWebViewController new];
                vc.urlStr=[NSString stringWithFormat:@"%@%@",URL_XUEXINWANG,self.userEntity.token];
                vc.titleStr=@"学信网认证";
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                PersonInfoViewController *vc=[PersonInfoViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else if (btn.tag-1100==4){
            if ([self.userEntity.userInfoStatus boolValue]==YES) {
                CommonUseWebViewController *vc=[CommonUseWebViewController new];
                vc.urlStr=[NSString stringWithFormat:@"%@%@",URL_MAIMAI,self.userEntity.token];
                vc.titleStr=@"脉脉认证";
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                PersonInfoViewController *vc=[PersonInfoViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        else if (btn.tag-1100==5){//备用手机
            if ([self.userEntity.userInfoStatus boolValue]==YES) {
                PhoneNumInputViewController *vc=[PhoneNumInputViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                PersonInfoViewController *vc=[PersonInfoViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else if (btn.tag-1100==6){//QQ空间
            if ([self.userEntity.userInfoStatus boolValue]==YES) {
                BQSPublicRZViewController *vc = [BQSPublicRZViewController new];
                vc.rzType = qzone;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                PersonInfoViewController *vc=[PersonInfoViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else if (btn.tag-1100==7){//领英
            if ([self.userEntity.userInfoStatus boolValue]==YES) {
                BQSPublicRZViewController *vc = [BQSPublicRZViewController new];
                vc.rzType = linkedin;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                PersonInfoViewController *vc=[PersonInfoViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else if (btn.tag-1100==8){//微博
            if ([self.userEntity.userInfoStatus boolValue]==YES) {
                BQSPublicRZViewController *vc = [BQSPublicRZViewController new];
                vc.rzType = weibo;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                PersonInfoViewController *vc=[PersonInfoViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else if (btn.tag-1100==9){//手机认证
            if ([self.userEntity.userInfoStatus boolValue]==YES) {
                
                PhoneRZViewController *vc= [PhoneRZViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                PersonInfoViewController *vc=[PersonInfoViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }


    }else{
        [self toLogin];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1100) {
        if (buttonIndex==1) {
            BankcardRZViewController *vc=[BankcardRZViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (alertView.tag==1101){
        if (buttonIndex==1) {
            AddPhotoViewController *vc=[AddPhotoViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)aliRPVertify{
    [[RealPeopleCertification shareInstance] startRealPeopleCertificationWithVC:self.navigationController result:^(BOOL isSuccess) {
        if (isSuccess) { //认证通过
            //真正的认证成功在发请求去服务端验证资料
        } else { //认证失败
            [AppUtils showErrorMessage:@"认证失败"];
        }
    }];
}
- (NSString *)requestUrlWithPath:(NSString *)path
{
    return [[@"http://" stringByAppendingString:[SERVER_HOST stringByAppendingString:@""]] stringByAppendingString:path];
}
@end
