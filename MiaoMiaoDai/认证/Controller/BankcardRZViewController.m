//
//  BankcardRZViewController.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/6/11.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "BankcardRZViewController.h"
#import "BankcardRZView.h"
#import <objc/runtime.h>
#import "RZRequest.h"
#import "AnotherSearchViewController.h"
#import "JSMSConstant.h"
#import "JSMSSDK.h"


#define PROVINCE_COMPONENT  0
#define CITY_COMPONENT      1
#define DISTRICT_COMPONENT  2



@interface BankcardRZViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate>
{
    UIActionSheet *actionSheet;
    NSString *userName;
    NSString *idCardNum;
    NSString *cardNo;
    NSString *sex;
    NSString *unionPayCode;
    UIPickerView* bank_picker,*area_picker;
    NSMutableArray *bankList;
    
    UserEntity*userEntity;
    
    NSDictionary *areaDic;
    NSArray *province;
    NSArray *city;
    NSArray *district;
    NSMutableArray * bankBranche;
    
    NSString *selectedProvince;
    NSString *selectedcity;
    
    NSMutableArray *dataArray;
    
    BOOL isLoadingSubBranche;
    
    int time;
    
}
@property(strong,nonatomic)BankcardRZView *bankcardView;
@property(strong,nonatomic)NSString *name,*idnumber,*cardnumber,*currentOcrType;
@property(strong,nonatomic)NSTimer *timer;

@end

@implementation BankcardRZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"银行卡认证";
    
    userEntity=[UserEntity shareUserEntity];
    
    time=SecondsForMsg;
    
    self. bankcardView = [[BankcardRZView alloc]initWithFrame:self.view.bounds];
    self.view=self.bankcardView;
    
    [self getBankTypeList];
    
    _bankcardView.text_phoneNumber.text=userEntity.userAccount;
    sex = @"100340000";
    _bankcardView.text_IDNumber.delegate = self;
    _bankcardView.text_Name.delegate = self;
    [_bankcardView.btn_Next addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [_bankcardView.btn_GetVerificationButton addTarget:self action:@selector(getCode:) forControlEvents:UIControlEventTouchUpInside];
    
    
    bank_picker = [[UIPickerView alloc]init];
    bank_picker.tag=11;
    bank_picker.delegate = self;
    bank_picker.dataSource=self;
    _bankcardView.text_bankName.inputView=bank_picker;
    _bankcardView.text_bankName.delegate=self;
    _bankcardView.text_bankName.tag=10;
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"area" ofType:@"plist"];
    
    areaDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    NSArray *components = [areaDic allKeys];
    NSArray *sortedArray = [components sortedArrayUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    NSMutableArray *provinceTmp = [[NSMutableArray alloc] init];
    for (int i=0; i<[sortedArray count]; i++) {
        NSString *index = [sortedArray objectAtIndex:i];
        NSArray *tmp = [[areaDic objectForKey: index] allKeys];
        [provinceTmp addObject: [tmp objectAtIndex:0]];
    }
    
    province = [[NSArray alloc] initWithArray: provinceTmp];
    
    NSString *index = [sortedArray objectAtIndex:0];
    NSString *selected = [province objectAtIndex:0];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [[areaDic objectForKey:index]objectForKey:selected]];
    
    NSArray *cityArray = [dic allKeys];
    NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [cityArray objectAtIndex:0]]];
    city = [[NSArray alloc] initWithArray: [cityDic allKeys]];
    
    NSString *selectedCity = [city objectAtIndex: 0];
    district = [[NSArray alloc] initWithArray: [cityDic objectForKey: selectedCity]];
    
    area_picker = [[UIPickerView alloc]init];
    area_picker.delegate=self;
    area_picker.dataSource=self;
    area_picker.tag=12;
    [area_picker selectRow:0 inComponent:0 animated:YES];
    
    _bankcardView.text_city.delegate=self;
    _bankcardView.text_city.tag=11;
    _bankcardView.text_city.inputView=area_picker;
    
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choosesubbranch)];
    _bankcardView.text_subbranch.userInteractionEnabled=YES;
    [_bankcardView.text_subbranch addGestureRecognizer:tap];
    
    _bankcardView.text_CardNumber.delegate=self;
 
    
}



-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField==_bankcardView.text_CardNumber) {
        NSString *text = [textField text];
        
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        }
        
        text = [text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([text length] >= 21) {
            return NO;
        }
        
        NSString *newString = @"";
        while (text.length > 0) {
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4) {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }
        
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        
        [textField setText:newString];
        
        return NO;
    }
    return YES;
}

-(void)getCode:(UIButton *)btn{
  self.timer=[NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(daojishi) userInfo:nil repeats:YES];
  [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
  
  [_bankcardView.btn_GetVerificationButton setTitle:[NSString stringWithFormat:@"%ds",SecondsForMsg] forState:UIControlStateNormal];
  _bankcardView.btn_GetVerificationButton.enabled=NO;
  [_bankcardView.btn_GetVerificationButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
  
  
  [JSMSSDK getVerificationCodeWithPhoneNumber:userEntity.phoneNumber andTemplateID:@"1" completionHandler:^(id  _Nullable resultObject, NSError * _Nullable error) {
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
-(void)daojishi{
    time--;
    
    [_bankcardView.btn_GetVerificationButton setTitle:[NSString stringWithFormat:@"%ds",time] forState:UIControlStateNormal];
    _bankcardView.btn_GetVerificationButton.enabled=NO;
    [_bankcardView.btn_GetVerificationButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    if (time<=0) {
        _bankcardView.btn_GetVerificationButton.enabled=YES;
        [self.timer invalidate];
        self.timer = nil;
        [_bankcardView.btn_GetVerificationButton setTitleColor:[YhbMethods colorWithHexString:COLOR_BIG_BUTTON] forState:UIControlStateNormal];
        [_bankcardView.btn_GetVerificationButton setTitle:@"重新获取" forState:UIControlStateNormal];
        time=SecondsForMsg;
    }
}

-(void)getBankTypeList{

    [RZRequest getBankCardTypeListSuccess:^(id obj) {
        
        NSLog(@"%@",obj);
        bankList = [obj[@"bankType"] copy];
    }];
    
}

-(void)choosesubbranch{
    if (isLoadingSubBranche) {
        [AppUtils showTipsMessage:@"数据载入中，请稍后"];
        return;
    }
    
    if ([_bankcardView.text_bankName.text isEqualToString:@"银行类型"]||
        [_bankcardView.text_city.text isEqualToString:@"点击选择开户城市"]) {
        [AppUtils showTipsMessage:@"请优先完整填写银行类型与开户城市"];
    }
//    else if (dataArray.count==0) {
//        [AppUtils showTipsMessage:@"该城市没有相关银行，请重新选择或联系客服反映"];
//    }
    else{
        bankBranche =[[NSMutableArray alloc]init];
        
        NSArray *array=[_bankcardView.text_city.text componentsSeparatedByString:@" "];
        selectedcity=array[1];
        selectedProvince=array[0];
        
        [RZRequest bankBranches:array[1] andbank_type:_bankcardView.text_bankName.text success:^(id obj) {
            NSDictionary *newList = (NSDictionary*)obj;
            bankBranche=newList[@"bankList"];
            dataArray = [NSMutableArray new];
            for (int i=0; i<bankBranche.count; i++) {
                [dataArray addObject:[bankBranche objectAtIndex:i][@"bankName"]];
            }
            if ([bankBranche count]==0) {
                if ([_bankcardView.text_city.text isEqualToString:@"点击选择开户城市"]||[_bankcardView.text_bankName.text isEqualToString:@"银行类型"]) {
                    _bankcardView.text_subbranch.text = @"点击选择开户分行";
                }else{
                    _bankcardView.text_subbranch.text = @"没有相关银行";
                }
                
                //addWithdrawalAccountSencond.btn_select2.enabled = NO;
            }else{
                _bankcardView.text_subbranch.text = @"点击选择开户分行";
                // addWithdrawalAccountSencond.text_districtStr.enabled = YES;
            }
            //[pickeView2 reloadInputViews];
            //        isLoadingSubBranche = NO;
            AnotherSearchViewController *vc=[AnotherSearchViewController new];
            [vc didSelectedItem:^(NSString *item, NSIndexPath *index) {
                [_bankcardView.text_subbranch endEditing:YES];
                _bankcardView.text_subbranch.text = item;
                NSDictionary *itemInfo=bankBranche[index.row];
                unionPayCode = itemInfo[@"bankUnionpayCode"];
            }];
            vc.dataSource = dataArray;
            vc.title = @"请选择开户支行";
            [self.navigationController pushViewController:vc animated:YES];
        } failed:^(id obj) {
            
        }];
        
        
    }
    
}
-(void)getsubBranchBank{
    
    bankBranche =[[NSMutableArray alloc]init];
    
    NSArray *array=[_bankcardView.text_city.text componentsSeparatedByString:@" "];
    selectedcity=array[1];
    selectedProvince=array[0];
    
    [RZRequest bankBranches:array[1] andbank_type:_bankcardView.text_bankName.text success:^(id obj) {
        NSDictionary *newList = (NSDictionary*)obj;
        bankBranche=newList[@"bankList"];
        dataArray = [NSMutableArray new];
        for (int i=0; i<bankBranche.count; i++) {
            [dataArray addObject:[bankBranche objectAtIndex:i][@"bankName"]];
        }
        if ([bankBranche count]==0) {
            if ([_bankcardView.text_city.text isEqualToString:@"点击选择开户城市"]||[_bankcardView.text_bankName.text isEqualToString:@"银行类型"]) {
                _bankcardView.text_subbranch.text = @"点击选择开户分行";
            }else{
                _bankcardView.text_subbranch.text = @"没有相关银行";
            }

            //addWithdrawalAccountSencond.btn_select2.enabled = NO;
        }else{
            _bankcardView.text_subbranch.text = @"点击选择开户分行";
            // addWithdrawalAccountSencond.text_districtStr.enabled = YES;
        }
        //[pickeView2 reloadInputViews];
//        isLoadingSubBranche = NO;
    } failed:^(id obj) {
        
    }];

    
}





#pragma mark -UIPickViewDataSource, UITableViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    switch (pickerView.tag) {
        case 11:
            return 1;
            break;
        case 12:
            return 2;
            break;
        default:
            return 1;
            break;
    }
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case 11:
            return bankList[row][@"bankType"];
            break;
        case 12:{
            if (component == PROVINCE_COMPONENT) {
                return [province objectAtIndex: row];
            }
            else if (component == CITY_COMPONENT) {
                return [city objectAtIndex: row];
            }
            else {
                return 0;
                return [district objectAtIndex: row];
            }
        }
            break;
        default:
            break;
    }
    return @"";
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    switch (pickerView.tag) {
        case 11:
            return [bankList count];
            break;
        case 12:{
            if (component == PROVINCE_COMPONENT) {
                return [province count];
            }
            else if (component == CITY_COMPONENT) {
                return [city count];
            }
            else {
                return 0;
                return [district count];
            }
        }
            break;
        default:
            break;
    }
    return 0;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case 11:
            _bankcardView.text_bankName.text=bankList[row][@"bankType"];
            break;
        case 12:{
            if (component == PROVINCE_COMPONENT) {
                selectedProvince = [province objectAtIndex: row];
                NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: [NSString stringWithFormat:@"%ld", (long)row]]];
                NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: selectedProvince]];
                NSArray *cityArray = [dic allKeys];
                NSArray *sortedArray = [cityArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
                    
                    if ([obj1 integerValue] > [obj2 integerValue]) {
                        return (NSComparisonResult)NSOrderedDescending;//递减
                    }
                    
                    if ([obj1 integerValue] < [obj2 integerValue]) {
                        return (NSComparisonResult)NSOrderedAscending;//上升
                    }
                    return (NSComparisonResult)NSOrderedSame;
                }];
                
                NSMutableArray *array = [[NSMutableArray alloc] init];
                for (int i=0; i<[sortedArray count]; i++) {
                    NSString *index = [sortedArray objectAtIndex:i];
                    NSArray *temp = [[dic objectForKey: index] allKeys];
                    [array addObject: [temp objectAtIndex:0]];
                }
                
                
                city = [[NSArray alloc] initWithArray: array];
                if (city.count==1) {
                    selectedcity=city[0];
                }
                
                NSDictionary *cityDic = [dic objectForKey: [sortedArray objectAtIndex: 0]];
                district = [[NSArray alloc] initWithArray: [cityDic objectForKey: [city objectAtIndex: 0]]];
                [area_picker selectRow: 0 inComponent: CITY_COMPONENT animated: YES];
                [area_picker reloadComponent: CITY_COMPONENT];
                
            }
            else if (component == CITY_COMPONENT) {
                selectedcity = [city objectAtIndex: row];
                NSString *provinceIndex = [NSString stringWithFormat: @"%ld", (unsigned long)[province indexOfObject: selectedProvince]];
                NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: provinceIndex]];
                NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: selectedProvince]];
                NSArray *dicKeyArray = [dic allKeys];
                if (dicKeyArray.count>=2 ) {
                    
                    NSArray *sortedArray = [dicKeyArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
                        
                        if ([obj1 integerValue] > [obj2 integerValue]) {
                            return (NSComparisonResult)NSOrderedDescending;
                        }
                        
                        if ([obj1 integerValue] < [obj2 integerValue]) {
                            return (NSComparisonResult)NSOrderedAscending;
                        }
                        return (NSComparisonResult)NSOrderedSame;
                    }];
                    
                    
                    NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [sortedArray objectAtIndex: row]]];
                    NSArray *cityKeyArray = [cityDic allKeys];
                    
                    
                    district = [[NSArray alloc] initWithArray: [cityDic objectForKey: [cityKeyArray objectAtIndex:0]]];
                }
            }
        }
            break;
        default:
            break;
    }
}

-(void)next:(UIButton *)btn{
    /*
     
     name 姓名
     idCard 身份证号码
     bankCard 银行卡号
     bankArea 开户省份
     bankCity 开户城市
     bankType 银行卡类型
     bankName 银行名称
     unionPayCode
     phoneNumber 手机号
     
     */
    
    userName = _bankcardView.text_Name.text;
    idCardNum = _bankcardView.text_IDNumber.text;
    idCardNum=[idCardNum stringByReplacingOccurrencesOfString:@"#"withString:@"X"];
    cardNo=[_bankcardView.text_CardNumber.text stringByReplacingOccurrencesOfString:@" " withString:@""];//过滤空格
    NSArray *array=[_bankcardView.text_city.text componentsSeparatedByString:@" "];
    NSString *bankArea = array[0]?array[0]:[NSNull null];
    NSString *bankCity = array[1]?array[1]:[NSNull null];
    NSString *bankName = _bankcardView.text_bankName.text;

    if ([userName isEqualToString:@""]) {
        [AppUtils showErrorMessage:@"请输入您的真实姓名"];
    }else if(![AppUtils checkIdentityCard:idCardNum])
    {
        [AppUtils showErrorMessage:@"您输入的身份证格式不正确"];
    }
    else if ([_bankcardView.text_CardNumber.text isEqualToString:@""])
    {
        [AppUtils showErrorMessage:@"请输入银行卡"];
    }
    else if ([_bankcardView.text_Verification.text isEqualToString:@""])
    {
        [AppUtils showErrorMessage:@"请输入验证码"];
    }else if ([bankName isEqualToString:@""])
    {
        [AppUtils showErrorMessage:@"请选择银行"];
    }else if (unionPayCode == nil)
    {
        [AppUtils showErrorMessage:@"请选择支行"];
    }else if (bankArea.length<1 || bankCity.length<1)
    {
        [AppUtils showErrorMessage:@"请选择开户城市"];
    }
    else {
        [JSMSSDK commitWithPhoneNumber:userEntity.phoneNumber verificationCode:_bankcardView.text_Verification.text completionHandler:^(id resultObject, NSError *error) {
            if (!error) {
                [self bandCard];
            }else{
                NSLog(@"%@",error);
                [AppUtils showTipsMessage:@"验证码输入失败"];
            }
        }];
        
    }
}
-(void)bandCard{
    NSArray *array=[_bankcardView.text_city.text componentsSeparatedByString:@" "];
    NSString *bankArea = array[0]?array[0]:[NSNull null];
    NSString *bankCity = array[1]?array[1]:[NSNull null];
    NSString *bankName = _bankcardView.text_bankName.text;

    NSDictionary *dict=@{@"name":userName,
                         @"idCard":idCardNum,
                         @"bankCard":cardNo,
                         @"bankArea":bankArea,
                         @"bankCity":bankCity,
                         @"bankName":bankName,
                         @"bankType":@"0",
                         @"phoneNumber":userEntity.phoneNumber,
                         @"unionPayCode":unionPayCode
                         };
    [SVProgressHUD showWithStatus:@"信息提交中..."];
    [RZRequest uploadBandBankcardInfoWithParam:dict success:^(id obj) {
        NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
        if ([code intValue]==100) {
            [self getStatus];
        }
    }];
}


-(void)getStatus{
    [RZRequest getUserVerifyStatus:^(id obj) {
        [AppUtils showSuccessMessage:@"信息提交成功，正在返回"];
        [YhbMethods performBlock:^{
            [AppUtils dismissHUD];
            [self.navigationController popViewControllerAnimated:YES];
        } afterDelay:1.0f];
    }];
}

#pragma UITextFieldDelegate

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField.tag==10) {
        _bankcardView.text_bankName.text=[bankList objectAtIndex:[bank_picker selectedRowInComponent:0]][@"bankType"];
        if ([_bankcardView.text_city.text isEqualToString:@"点击选择开户城市"]) {
        }else{
//            [self getsubBranchBank];
        }
    }else if (textField.tag==11){
        _bankcardView.text_city.text=[NSString stringWithFormat:@"%@ %@",[province objectAtIndex:[area_picker selectedRowInComponent:0]],[city objectAtIndex:[area_picker selectedRowInComponent:1]]];
//        [self getsubBranchBank];
    }else if (textField.tag==12){
        
    }
    return YES;
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    
    return YES;
    
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
