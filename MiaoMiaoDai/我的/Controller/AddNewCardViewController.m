//
//  AddNewCardViewController.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/4/2.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "AddNewCardViewController.h"
#import "MOFSPickerManager.h"
#import "RZRequest.h"
#import "HomeRequest.h"
#import "LLPaySdk.h"


#define ZHONGHANG @"1040000"//中国银行
#define GUANGDA @"3030000"  //光大银行
#define ZHAOSHANG @"3080000"//招商
#define GONGSHANG @"1020000"//工商
#define NONGYE @"1030000"   //农业
#define ZHONGXIN @"3020000" //中信
#define YOUZHENG @"4030000" //邮政
#define GUANGFA @"3060000"  //广发银行
#define MINSHENG @"3050000" //民生银行
#define JIANSHE @"1050000"  //建设银行
#define XINGYE @"3090010"   //兴业银行
#define JIAOTONG @"3010000" //交通银行
#define PUFA @"3100000"     //浦发银行
#define PINGAN @"3070000"   //平安银行
#define HUAXIA @"3040000"   //华夏银行
#define DONGGUAN @"4256020"   //东莞银行
#define BEIJING @"3130011"   //北京银行
#define HENGFENG @"3114560"   //恒丰银行


@interface AddNewCardViewController ()<LLPaySdkDelegate>

{
    NSString *bankType;
}

@property(strong,nonatomic)UIPickerView *picker;
@property (nonatomic,strong) NSMutableDictionary *param;


@end

@implementation AddNewCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"添加银行卡";
    
    [LLPaySdk sharedSdk].sdkDelegate = self;

    self.view.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    [self param];
    
    [self setupviews];
    
    [self getUserInfo];
    
    
}
-(void)paymentEnd:(LLPayResult)resultCode withResultDic:(NSDictionary *)dic{
    NSLog(@"%d",resultCode);
    if (resultCode == kLLPayResultSuccess) {
        UILabel *bankLabel=[self.view viewWithTag:1100];
        UILabel *areaLabel=[self.view viewWithTag:1101];
        UITextField *phoneText=[self.view viewWithTag:1202];
        UITextField *cardNoText=[self.view viewWithTag:1203];
        NSMutableDictionary *dict=[NSMutableDictionary new];
        [dict setValue:bankLabel.text forKey:@"bankName"];
        [dict setValue:areaLabel.text forKey:@"bankArea"];
        [dict setValue:phoneText.text forKey:@"phoneNumber"];
        [dict setValue:cardNoText.text forKey:@"cardNumber"];
        [dict setValue:bankType forKey:@"bankType"];
        [dict setValue:dic[@"no_agree"] forKey:@"noAgree"];
        
        [HomeRequest bandBankCardWithData:dict success:^(id obj) {
            [AppUtils showSuccessMessage:@"绑定成功，正在返回"];
            [YhbMethods performBlock:^{
                [AppUtils dismissHUD];
                [self.navigationController popViewControllerAnimated:YES];
            } afterDelay:1.0f];
        }];
    }else{
        [AppUtils showAlertMessage:dic[@"ret_msg"]];
    }
    
    
    
}


-(void)getUserInfo{
    if ([self.userEntity.userInfoStatus boolValue]==YES) {
        [RZRequest getUserInfoSuccess:^(id obj) {
            NSDictionary *dic = [YhbMethods setDicNullClass:obj];
            [_param setValue:dic[@"idCard"] forKey:@"idCardNumber"];
            [_param setValue:dic[@"name"] forKey:@"realName"];
        }];
    }
}
-(void)next{
    UILabel *label=[self.view viewWithTag:1100];
    UILabel *label1=[self.view viewWithTag:1101];
    UITextField *text=[self.view viewWithTag:1202];
    UITextField *text1=[self.view viewWithTag:1203];
    
    if ([label.text isEqualToString:@"请选择"]||[label1.text isEqualToString:@"请选择"]||text.text.length <=0||text1.text.length<=0) {
        [AppUtils showAlertMessage:@"请完善信息后重试"];
    }else{
        [self bandBankcard];
    }
    
}
-(void)bandBankcard{
    UITextField *cardNoText=[self.view viewWithTag:1203];
    [_param setValue:cardNoText.text forKey:@"bankCardNumber"];
    
    [HomeRequest cardRZWithParam:_param success:^(id obj) {
        NSLog(@"%@",obj);
        NSDictionary *dic=obj;
        [[LLPaySdk sharedSdk]presentLLPaySignInViewController:self withPayType:LLPayTypeInstalments andTraderInfo:dic];

    }];
    
}
-(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
  
    return mutStr;
    
}

-(void)setupviews{
    NSArray *titleArray=@[@"开户行",@"开户省市",@"预留手机号",@"银行卡号"];
    NSArray *placeHolderArray=@[@"请选择",@"请选择",@"请输入预留手机号",@"请输入银行卡号(不支持信用卡)"];
    for (int i = 0 ; i<4; i++) {
        UIView *view=[[UIView alloc]initWithFrame:Frame(0, i*AUTO(50)+AUTO(10), ScreenWidth, AUTO(49.5))];
        view.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:view];
        
        UILabel *titleLabel=[[UILabel alloc]initWithFrame:Frame(AUTO(10), 0, AUTO(80), AUTO(49.5))];
        titleLabel.text=titleArray[i];
        titleLabel.textColor=[UIColor darkGrayColor];
        titleLabel.font=Font(AUTO(14));
        [view addSubview:titleLabel];
        
    
        
        if (i<2) {
            UILabel *label=[[UILabel alloc]initWithFrame:Frame(AUTO(95), 0, ScreenWidth-AUTO(105), AUTO(49.5))];
            label.text=placeHolderArray[i];
            label.font=Font(AUTO(14));
            label.tag=1100+i;
            label.textColor=[UIColor lightGrayColor];
            label.userInteractionEnabled=YES;
            [view addSubview:label];
            if (i==0) {
                UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bankpick)];
                [label addGestureRecognizer:tap];
            }else{
                UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addresspick)];
                [label addGestureRecognizer:tap];
            }
            
            
            UIImageView *arrow=[[UIImageView alloc]initWithImage:Image(@"icon_right")];
            [view addSubview:arrow];
            arrow.sd_layout
            .centerYEqualToView(view)
            .rightSpaceToView(view, AUTO(10))
            .heightIs(AUTO(18))
            .widthEqualToHeight();
            
            
        }else{
            UITextField *textField=[[UITextField alloc]initWithFrame:Frame(AUTO(95), 0, ScreenWidth-AUTO(105), AUTO(49.5))];
            textField.placeholder=placeHolderArray[i];
            textField.font=Font(AUTO(14));
            textField.tag=1200+i;
            textField.keyboardType=UIKeyboardTypeNumberPad;
            [view addSubview:textField];
        }
        
    }
    
    
    
    UIButton *nextBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setTitle:@"提交" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.backgroundColor=[YhbMethods colorWithHexString:@"#02C701"];
    nextBtn.titleLabel.font=Font(AUTO(16));
    nextBtn.frame=Frame(AUTO(20), AUTO(240), ScreenWidth-AUTO(40), AUTO(44));
    [YhbMethods setView:nextBtn CornerRadius:AUTO(4) AndMasks:YES];
    [self.view addSubview:nextBtn];
    [nextBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
}



-(void)bankpick{
    [[MOFSPickerManager shareManger] showPickerViewWithDataArray:@[@"中国银行",@"农业银行",@"工商银行",@"招商银行",@"建设银行",@"交通银行",@"光大银行",@"中信银行",@"邮政储蓄银行",@"浦发银行",@"广发银行",@"民生银行",@"兴业银行",@"平安银行",@"华夏银行",@"东莞银行",@"北京银行",@"恒丰银行"] tag:1 title:@"选择开户行" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString *string) {
        NSArray *ARR= @[@{@"name":@"中国银行",@"value":ZHONGHANG},
                      @{@"name":@"农业银行",@"value":NONGYE},
                      @{@"name":@"工商银行",@"value":GONGSHANG},
                      @{@"name":@"招商银行",@"value":ZHAOSHANG},
                      @{@"name":@"建设银行",@"value":JIANSHE},
                      @{@"name":@"交通银行",@"value":JIAOTONG},
                      @{@"name":@"光大银行",@"value":GUANGDA},
                      @{@"name":@"中信银行",@"value":ZHONGXIN},
                      @{@"name":@"邮政储蓄银行",@"value":YOUZHENG},
                      @{@"name":@"浦发银行",@"value":PUFA},
                      @{@"name":@"广发银行",@"value":GUANGFA},
                      @{@"name":@"民生银行",@"value":MINSHENG},
                      @{@"name":@"兴业银行",@"value":XINGYE},
                        @{@"name":@"平安银行",@"value":PINGAN},
                        @{@"name":@"华夏银行",@"value":HUAXIA},
                        @{@"name":@"东莞银行",@"value":DONGGUAN},
                        @{@"name":@"北京银行",@"value":BEIJING},
                        @{@"name":@"恒丰银行",@"value":HENGFENG}];
        for (NSDictionary *dic in ARR) {
            if ([dic[@"name"] isEqualToString:string]) {
                NSLog(@"%@",dic[@"value"]);
                bankType=dic[@"value"];
            }
        }
        UILabel *label=[self.view viewWithTag:1100];
        label.text=string;
    } cancelBlock:^{
        
    }];
    
}
-(void)addresspick{
    [[MOFSPickerManager shareManger] showMOFSAddressPickerWithDefaultAddress:@"暂无" title:@"选择开户省市" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString *address, NSString *zipcode) {
        NSLog(@"%@",address);
        UILabel *label=[self.view viewWithTag:1101];
        label.text=[address stringByReplacingOccurrencesOfString:@"-" withString:@""];
    } cancelBlock:^{
        
    }];
    
}

-(NSMutableDictionary *)param{
    if (!_param) {
        _param=[NSMutableDictionary new];
    }
    return _param;
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
