//
//  ContactsRZViewController.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/4/3.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "ContactsRZViewController.h"
#import "CommonUseWebViewController.h"
#import <AddressBook/AddressBook.h>
#import <ContactsUI/ContactsUI.h>
#import "RZRequest.h"

@interface ContactsRZViewController ()<CNContactPickerDelegate>
{
    CNContactPickerViewController *contactPickerViewController;

}
@property(strong,nonatomic)UIButton *agreeBtn,*xieyiBtn,*guizeBtn,*nextButton;

@end

@implementation ContactsRZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"通讯录认证";
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
//    if ([self.userEntity.contactStatus boolValue]==YES) {
//        [self setRZedView];
//    }else{
        [self setupviews];
//    }

    contactPickerViewController = [[CNContactPickerViewController alloc] init];
    contactPickerViewController.delegate = self;
    
    [self requestAuthorizationAddressBook];
}

- (void)requestAuthorizationAddressBook {
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=9.0) {
        // 判断是否授权
        CNAuthorizationStatus authorizationStatus =[CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (authorizationStatus!=CNAuthorizationStatusAuthorized) {
            // 请求授权
            CNContactStore *addressBookRef = [[CNContactStore alloc] init];
            [addressBookRef requestAccessForEntityType:0 completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {  // 授权成功
                    
                } else {        // 授权失败
                    NSLog(@"授权失败！");
                }
            }];
        }
    }else{
        // 判断是否授权
        ABAuthorizationStatus authorizationStatus = ABAddressBookGetAuthorizationStatus();
        if (authorizationStatus == kABAuthorizationStatusNotDetermined) {
            // 请求授权
            ABAddressBookRef addressBookRef =  ABAddressBookCreate();
            ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
                if (granted) {  // 授权成功
                    
                } else {        // 授权失败
                    NSLog(@"授权失败！");
                }
            });
        }
    }
    
}
-(void)next{
    
    NSMutableArray *contactsArray=[NSMutableArray new];
    // 1. 判读授权
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=9.0) {

        CNAuthorizationStatus authorizationStatus =[CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (authorizationStatus!=CNAuthorizationStatusAuthorized) {

            NSLog(@"没有授权");
            [AppUtils showAlertMessage:@"您未授权访问联系人，请前往系统设置进行设置"];
            return;
        }else{

            // 获取指定的字段,并不是要获取所有字段，需要指定具体的字段
            NSArray *keysToFetch = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
            CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
            CNContactStore *contactStore = [[CNContactStore alloc] init];

            [contactStore enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {

                NSMutableDictionary *dic=[NSMutableDictionary new];
                NSMutableArray *phoneArray=[NSMutableArray new];
                NSString *nameStr = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
                [dic setValue:nameStr forKey:@"name"];
                NSArray *phoneNumbers = contact.phoneNumbers;

                for (CNLabeledValue<CNPhoneNumber*>*phone in phoneNumbers) {
                    NSString *label = phone.label;
                    if ([label isEqualToString:@"_$!<Mobile>!$_"]) {
                        label=@"mobile";
                    }else if ([label isEqualToString:@"_$!<Home>!$_"]) {
                        label=@"home";
                    }else if ([label isEqualToString:@"移动电话"]) {
                        label=@"home";
                    }else{
                        label=@"mobile";
                    }
                    CNPhoneNumber *phonNumber = (CNPhoneNumber *)phone.value;
                    NSMutableDictionary *phoneDic = [NSMutableDictionary new];
                    [phoneDic setValue:label forKey:@"type"];
                    [phoneDic setValue:phonNumber.stringValue forKey:@"number"];
                    [phoneArray addObject:phoneDic];
                }
                [dic setObject:phoneArray forKey:@"phoneList"];
                [contactsArray addObject:dic];

            }];

        }
    }else{
        ABAuthorizationStatus authorizationStatus = ABAddressBookGetAuthorizationStatus();
        if (authorizationStatus != kABAuthorizationStatusAuthorized) {
            NSLog(@"没有授权");
            [AppUtils showAlertMessage:@"您未授权访问联系人，请前往系统设置进行设置"];
            return;
        }else{
            // 遍历所有联系人
            ABAddressBookRef bookRef = ABAddressBookCreate();

            CFArrayRef arrayRef = ABAddressBookCopyArrayOfAllPeople(bookRef);

            CFIndex count = CFArrayGetCount(arrayRef);
            for (int i = 0; i < count; i++)
            {
                ABRecordRef record = CFArrayGetValueAtIndex(arrayRef, i);
                NSMutableDictionary *dic=[NSMutableDictionary new];
                NSMutableArray *phoneArray=[NSMutableArray new];
                // 获取姓名
                NSString *firstName = (__bridge_transfer NSString *)ABRecordCopyValue(record, kABPersonFirstNameProperty);
                NSString *lastName = (__bridge_transfer NSString *)ABRecordCopyValue(record, kABPersonLastNameProperty);
                NSLog(@"firstName = %@, lastName = %@", firstName, lastName);
                NSString *nameStr = [NSString stringWithFormat:@"%@%@",firstName,lastName];

                [dic setValue:nameStr forKey:@"name"];

                // 获取电话号码
                ABMultiValueRef multiValue = ABRecordCopyValue(record, kABPersonPhoneProperty);
                CFIndex count = ABMultiValueGetCount(multiValue);
                
                for (int i = 0; i < count; i ++)
                {
                    NSString *label = (__bridge_transfer NSString *)ABMultiValueCopyLabelAtIndex(multiValue, i);
                    NSString *phone = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(multiValue, i);
                    if ([label isEqualToString:@"_$!<Mobile>!$_"]) {
                        label=@"mobile";
                    }else if ([label isEqualToString:@"_$!<Home>!$_"]) {
                        label=@"home";
                    }else if ([label isEqualToString:@"移动电话"]) {
                        label=@"home";
                    }else{
                        label=@"mobile";
                    }
                    
                    NSMutableDictionary *phoneDic = [NSMutableDictionary new];
                    [phoneDic setValue:label forKey:@"type"];
                    [phoneDic setValue:phone forKey:@"number"];
                    [phoneArray addObject:phoneDic];
                }
                [dic setObject:phoneArray forKey:@"phoneList"];
                [contactsArray addObject:dic];

                CFRelease(multiValue);
            }



        }
    }
//    NSDictionary*dic=@{@"name":@"公安局",@"phoneList":@[@{@"type":@"mobile",@"number":@"110"}]};
//    [contactsArray addObject:dic];
   
    NSLog(@"%@",[self arrayToJSONString:contactsArray]);

    [RZRequest ContactRZWithJson:[self arrayToJSONString:contactsArray] Success:^(id obj) {
        [self getStatus];
    }];
}
-(void)getStatus{
    [RZRequest getUserVerifyStatus:^(id obj) {
        NSLog(@"%@",obj);
        [AppUtils showSuccessMessage:@"保存成功，正在返回"];
        [YhbMethods performBlock:^{
            [AppUtils dismissHUD];
            [self.navigationController popViewControllerAnimated:YES];
        } afterDelay:1.0f];
    }];
}

- (NSString *)arrayToJSONString:(NSArray *)array{
    NSData *data = [NSJSONSerialization dataWithJSONObject:array
                                                   options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments
                                                     error:nil];
    
    if (data == nil) {
        return nil;
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    
//    NSError *error = nil;
//
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
  
    return jsonString;
}
-(void)setupviews{
    UIImageView *image=[[UIImageView alloc]initWithImage:Image(@"icon_notebook")];
    [self.view addSubview:image];
    image.sd_layout
    .topSpaceToView(self.view, AUTO(20))
    .centerXEqualToView(self.view)
    .widthIs(AUTO(80))
    .heightEqualToWidth();
    
    self.agreeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_agreeBtn setImage:Image(@"未选中") forState:UIControlStateNormal];
    [_agreeBtn setImage:Image(@"选中") forState:UIControlStateSelected];
    [_agreeBtn setTitle:@"我同意" forState:UIControlStateNormal];
    [_agreeBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _agreeBtn.titleLabel.font=Font(AUTO(14));
    [_agreeBtn addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_agreeBtn];
    _agreeBtn.sd_layout
    .topSpaceToView(image, AUTO(30))
    .leftSpaceToView(self.view, AUTO(10))
    .widthIs(AUTO(80))
    .heightIs(AUTO(30));
    
    _agreeBtn.imageView.sd_layout
    .centerYEqualToView(_agreeBtn)
    .leftSpaceToView(_agreeBtn, AUTO(5))
    .widthIs(AUTO(20))
    .heightEqualToWidth();
    
    
    self.xieyiBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [_xieyiBtn setTitle:@"《征信查询授权书》" forState:UIControlStateNormal];
    _xieyiBtn.titleLabel.font=_agreeBtn.titleLabel.font;
    [self.view addSubview:_xieyiBtn];
    _xieyiBtn.sd_layout
    .centerYEqualToView(_agreeBtn)
    .leftSpaceToView(_agreeBtn, 0);
    [_xieyiBtn setupAutoSizeWithHorizontalPadding:0 buttonHeight:AUTO(30)];
    [_xieyiBtn addTarget:self action:@selector(ZXCX) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.guizeBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [_guizeBtn setTitle:@"《信息收集及使用规则》" forState:UIControlStateNormal];
    _guizeBtn.titleLabel.font=_agreeBtn.titleLabel.font;
    [self.view addSubview:_guizeBtn];
    _guizeBtn.sd_layout
    .centerYEqualToView(_agreeBtn)
    .leftSpaceToView(_xieyiBtn, 0);
    [_guizeBtn setupAutoSizeWithHorizontalPadding:0 buttonHeight:AUTO(30)];
    [_guizeBtn addTarget:self action:@selector(XXSJ) forControlEvents:UIControlEventTouchUpInside];
    
    self.nextButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_nextButton setTitle:@"马上授权" forState:UIControlStateNormal];
    _nextButton.titleLabel.font=Font(AUTO(15));
    _nextButton.backgroundColor=[UIColor lightGrayColor];
    _nextButton.enabled=NO;
    [_nextButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextButton];
    _nextButton.sd_layout
    .topSpaceToView(_agreeBtn, AUTO(20))
    .leftSpaceToView(self.view, AUTO(20))
    .rightSpaceToView(self.view, AUTO(20))
    .heightIs(AUTO(44));
    _nextButton.sd_cornerRadius=@(AUTO(5));
    
    UILabel *tips=[UILabel new];
    tips.textColor=[UIColor lightGrayColor];
    tips.font=Font(AUTO(13));
    tips.text=@"温馨提示：\n1.请确保手机是您本人使用的\n2.提供通讯录信息，有助于您通过审核\n3.秒秒贷将严格保护用户隐私";
    [self.view addSubview:tips];
    tips.sd_layout
    .topSpaceToView(_nextButton, AUTO(20))
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
    label.text=@"您已完成通讯录认证";
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
-(void)agree:(UIButton *)sender{
    sender.selected=!sender.selected;
    if (sender.selected) {
      
        _nextButton.backgroundColor=[YhbMethods colorWithHexString:@"#02C701"];;
        _nextButton.enabled=YES;
        
    }else{
        _nextButton.backgroundColor=[UIColor lightGrayColor];
        _nextButton.enabled=NO;
    }
    
}

-(void)ZXCX{
    CommonUseWebViewController *vc=[CommonUseWebViewController new];
    vc.urlStr=@"http://app.qzxwmy.com:8080/xinwei-server/app/contract/ContactContract";
    vc.titleStr=@"征信查询授权书";
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)XXSJ{
    CommonUseWebViewController *vc=[CommonUseWebViewController new];
    vc.urlStr=@"http://app.qzxwmy.com:8080/xinwei-server/app/contract/ContactCollect";
    vc.titleStr=@"信息收集及使用规则";
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
