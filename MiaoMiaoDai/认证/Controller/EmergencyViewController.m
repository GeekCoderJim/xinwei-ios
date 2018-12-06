//
//  EmergencyViewController.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/3/2.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "EmergencyViewController.h"
#import <AddressBook/AddressBook.h>
#import <ContactsUI/ContactsUI.h>
#import "RZRequest.h"

@interface EmergencyViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIPickerViewAccessibilityDelegate,CNContactPickerDelegate>
{
    NSInteger current_tag,current_btn_tag;
    CNContactPickerViewController *contactPickerViewController;
}
@property(strong,nonatomic)UITableView *tableview;
@property(strong,nonatomic)UIPickerView *pickerview;
@property(copy,nonatomic)NSArray *dataSource;
@property(copy,nonatomic)NSArray *pickArray;
@property(copy,nonatomic)NSArray *qinshuArray;
@property(copy,nonatomic)NSArray *shehuiArray;

@property(strong,nonatomic)NSMutableArray *contactArray;
@end

@implementation EmergencyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"紧急联系人";
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self requestAuthorizationAddressBook];
    self.dataSource=@[@[@{@"title":@"亲属关系",@"placeholder":@"请选择"},
                      @{@"title":@"姓名",@"placeholder":@"请输入真实姓名"},
                      @{@"title":@"联系方式",@"placeholder":@"请输入亲属手机号码"}],
                      @[@{@"title":@"亲属关系",@"placeholder":@"请选择"},
                        @{@"title":@"姓名",@"placeholder":@"请输入真实姓名"},
                        @{@"title":@"联系方式",@"placeholder":@"请输入亲属手机号码"}],
                      @[@{@"title":@"社会关系",@"placeholder":@"请选择"},
                        @{@"title":@"姓名",@"placeholder":@"请输入真实姓名"},
                        @{@"title":@"联系方式",@"placeholder":@"请输入联系人手机号码"}],
                     ];
    
    [self tableview];
    [self qinshuArray];
    [self shehuiArray];
    
    UIView *footer=[[UIView alloc]initWithFrame:Frame(0, 0, ScreenWidth, AUTO(70))];
    footer.backgroundColor=[UIColor groupTableViewBackgroundColor];
    UIButton *addButton=[UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame=Frame(AUTO(20), AUTO(10), ScreenWidth-AUTO(40), AUTO(50));
    [addButton setTitle:@"提交" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addButton.titleLabel.font=Font(AUTO(16));
    addButton.backgroundColor=[YhbMethods colorWithHexString:COLOR_BIG_BUTTON];
    [YhbMethods setView:addButton CornerRadius:AUTO(5) AndMasks:YES];
    [addButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:addButton];
    self.tableview.tableFooterView=footer;
    self.view=self.tableview;
    
    UserEntity *userModel =  [UserEntity shareUserEntity];
    if ([userModel.contactStatus boolValue] == YES) {
        addButton.userInteractionEnabled = NO;
        addButton.hidden = YES;
    }
    
    contactPickerViewController = [[CNContactPickerViewController alloc] init];
    contactPickerViewController.delegate = self;
    
//    if ([self.userEntity.contactStatus boolValue]==YES) {
        [RZRequest getContactInfoSuccess:^(id obj) {
           NSLog(@"%@",obj);
            if (![obj isKindOfClass:[NSNull class]]) {
                obj=[YhbMethods setDicNullClass:obj];
                self.contactArray = [NSMutableArray new];
                NSMutableDictionary *relative1=[NSMutableDictionary new];
                [relative1 setValue:obj[@"relative1"] forKey:@"relative"];
                [relative1 setValue:obj[@"relativeName1"] forKey:@"name"];
                [relative1 setValue:obj[@"relativePhone1"] forKey:@"phone"];
                
                NSMutableDictionary *relative2=[NSMutableDictionary new];
                [relative2 setValue:obj[@"relative2"] forKey:@"relative"];
                [relative2 setValue:obj[@"relativeName2"] forKey:@"name"];
                [relative2 setValue:obj[@"relativePhone2"] forKey:@"phone"];
                
                NSMutableDictionary *relative3=[NSMutableDictionary new];
                [relative3 setValue:obj[@"social"] forKey:@"relative"];
                [relative3 setValue:obj[@"relativeName3"] forKey:@"name"];
                [relative3 setValue:obj[@"socialPhone"] forKey:@"phone"];
                
                [self.contactArray addObject:relative1];
                [self.contactArray addObject:relative2];
                [self.contactArray addObject:relative3];
                
                [self.tableview reloadData];
            }
            
        }];
//    }
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
    UITextField *textfield;
    NSMutableDictionary *dic=[NSMutableDictionary new];
    for (int i = 1; i<4; i++) {
        for (int j = 0 ; j<3; j++) {
            textfield=[self.view viewWithTag:i*100+j];
            NSLog(@"tag==%ld text==%@",textfield.tag,textfield.text);
            switch (i) {
                case 1:
                {
                    if (j==0) {
                        [dic setValue:textfield.text forKey:@"relative1"];
                    }else if (j==1){
                        [dic setValue:textfield.text forKey:@"relativeName1"];
                    }else{
                        [dic setValue:textfield.text forKey:@"relativePhone1"];
                    }
                    
                }
                    break;
                case 2:
                {
                    if (j==0) {
                        [dic setValue:textfield.text forKey:@"relative2"];
                    }else if (j==1){
                        [dic setValue:textfield.text forKey:@"relativeName2"];
                    }else{
                        [dic setValue:textfield.text forKey:@"relativePhone2"];
                    }
                    
                }
                    break;
                case 3:
                {
                    if (j==0) {
                        [dic setValue:textfield.text forKey:@"social"];
                    }else if (j==1){
                        [dic setValue:textfield.text forKey:@"relativeName3"];
                    }else{
                        [dic setValue:textfield.text forKey:@"socialPhone"];
                    }
                    
                }
                    break;
                default:
                    break;
            }
        }
    }
    NSLog(@"%@",dic);
    NSArray *array=[dic allKeys];
    int count = 0;
    for (int i = 0; i<array.count; i++) {
        NSString *string=dic[array[i]];
        if ([string isKindOfClass:[NSNull class]]||string.length<=0) {
            [AppUtils showAlertMessage:@"请填写完整"];
            break;
        }else{
            count++;
            if (count>=array.count) {
                [RZRequest submitContactsInfoWithParam:dic success:^(id obj) {
                    
                    [self getStatus];
                }];
            }
        }
    }

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
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.pickArray=[NSArray new];
    current_tag=textField.tag;
    switch (textField.tag) {
        case 100:
            _pickArray=_qinshuArray;
            textField.text=_pickArray[0];
            break;
        case 200:
            _pickArray=_qinshuArray;
            textField.text=_pickArray[0];

            break;
        case 300:
            _pickArray=_shehuiArray;
            textField.text=_pickArray[0];

            break;
        default:
            break;
    }

    [_pickerview reloadAllComponents];
    
}

-(void)getContactList:(UIButton *)btn{
    current_btn_tag=btn.tag;
    // 1. 判读授权
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=9.0) {
        
        CNAuthorizationStatus authorizationStatus =[CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (authorizationStatus!=CNAuthorizationStatusAuthorized) {
            
            NSLog(@"没有授权");
            [AppUtils showAlertMessage:@"您未授权访问联系人，请前往系统设置进行设置"];
            return;
        }
    }else{
        ABAuthorizationStatus authorizationStatus = ABAddressBookGetAuthorizationStatus();
        if (authorizationStatus != kABAuthorizationStatusAuthorized) {
            
            NSLog(@"没有授权");
            [AppUtils showAlertMessage:@"您未授权访问联系人，请前往系统设置进行设置"];
            return;
        }
    }
    
    
    [self presentViewController:contactPickerViewController animated:YES completion:nil];


}

// 如果实现该方法当选中联系人时就不会再出现联系人详情界面， 如果需要看到联系人详情界面只能不实现这个方法，
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    NSLog(@"选中某一个联系人时调用---------------------------------");
    
    [self printContactInfo:contact];
}


- (void)printContactInfo:(CNContact *)contact {
    NSString *givenName = contact.givenName;
    NSString *familyName = contact.familyName;
    NSLog(@"givenName=%@, familyName=%@", givenName, familyName);
    NSArray * phoneNumbers = contact.phoneNumbers;
    for (CNLabeledValue<CNPhoneNumber*>*phone in phoneNumbers) {
        NSString *label = phone.label;
        CNPhoneNumber *phonNumber = (CNPhoneNumber *)phone.value;
        NSLog(@"label=%@, value=%@", label, phonNumber.stringValue);
        UITextField *textField=[self.view viewWithTag:current_btn_tag-1000];
        textField.text=phonNumber.stringValue;
        
        UITextField *textField1=[self.view viewWithTag:current_btn_tag-1001];
        textField1.text=[NSString stringWithFormat:@"%@%@",givenName,familyName];
        break;
        
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array=self.dataSource[section];
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSArray *array=self.dataSource[indexPath.section];
    NSDictionary *dic=array[indexPath.row];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        UITextField *textField=[[UITextField alloc]initWithFrame:Frame(AUTO(120), 0, ScreenWidth-AUTO(130), AUTO(50))];
        textField.tag=100*(indexPath.section+1)+indexPath.row;
        textField.font=Font(AUTO(14));
        NSString *holderText3 =dic[@"placeholder"];
        NSMutableAttributedString *placeholder3 = [[NSMutableAttributedString alloc] initWithString:holderText3];
        [placeholder3 addAttribute:NSFontAttributeName
                             value:[UIFont systemFontOfSize:AUTO(14)]
                             range:NSMakeRange(0, holderText3.length)];
        textField.attributedPlaceholder=placeholder3;
        textField.delegate=self;
        if (indexPath.row==0) {
            textField.inputView=self.pickerview;
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }else{
            textField.inputView=nil;
            cell.accessoryType=UITableViewCellAccessoryNone;
        }
        if (indexPath.row==2) {
            textField.keyboardType=UIKeyboardTypePhonePad;
            textField.frame=Frame(AUTO(120), 0, ScreenWidth-AUTO(170), AUTO(50));
            UIButton *addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            addBtn.frame=Frame(ScreenWidth-AUTO(40), AUTO(13), AUTO(24), AUTO(24));
            [addBtn setBackgroundImage:Image(@"icon_add_c") forState:UIControlStateNormal];
            addBtn.tag=100*(indexPath.section+1)+indexPath.row+1000;
            [addBtn addTarget:self action:@selector(getContactList:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:addBtn];
        }else{
            textField.frame=Frame(AUTO(120), 0, ScreenWidth-AUTO(130), AUTO(50));
            textField.keyboardType=UIKeyboardTypeDefault;
        }
       
        [cell.contentView addSubview:textField];
        
    }
    cell.textLabel.text=dic[@"title"];
    cell.selectionStyle=UITableViewCellSeparatorStyleNone;
//    if ([self.userEntity.contactStatus boolValue]==YES) {

    NSDictionary *dict=self.contactArray[indexPath.section];
    switch (indexPath.row) {
        case 0:
        {
            UITextField* textField = [self.view viewWithTag: 100*(indexPath.section+1)+indexPath.row];
            textField.text=dict[@"relative"];
        }
            break;
        case 1:
        {
            UITextField* textField = [self.view viewWithTag: 100*(indexPath.section+1)+indexPath.row];
            textField.text=dict[@"name"];
        }
            break;
        case 2:
        {
            UITextField* textField = [self.view viewWithTag: 100*(indexPath.section+1)+indexPath.row];
            textField.text=dict[@"phone"];
        }
            break;
        default:
            break;
        }
//    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AUTO(50);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AUTO(15);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:Frame(0, 0, ScreenWidth, AUTO(15))];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:Frame(0, 0, ScreenWidth, AUTO(0.01))];
    return view;
}
#pragma mark----UIPickerView
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _pickArray.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _pickArray[row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    UITextField *textField;
    textField=[self.view viewWithTag:current_tag];
    textField.text=_pickArray[row];
    
}

#pragma mark----lazy
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.backgroundColor=[UIColor groupTableViewBackgroundColor];
    }
    return _tableview;
}
-(UIPickerView *)pickerview{
    if (!_pickerview) {
        _pickerview=[[UIPickerView alloc]initWithFrame:Frame(0, 0, ScreenWidth, AUTO(220))];
        _pickerview.delegate=self;
        _pickerview.dataSource=self;
        _pickerview.showsSelectionIndicator=YES;
    }
    return _pickerview;
}
-(NSArray *)qinshuArray{
    if (!_qinshuArray) {
        _qinshuArray=@[@"父母",@"配偶",@"子女",@"兄弟姐妹",@"其他亲属"];
    }
    return _qinshuArray;
}
-(NSArray *)shehuiArray{
    if (!_shehuiArray) {
        _shehuiArray=@[@"同学",@"同事",@"朋友"];
    }
    return _shehuiArray;
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
