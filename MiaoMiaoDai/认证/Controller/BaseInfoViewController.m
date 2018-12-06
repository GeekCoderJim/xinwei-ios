//
//  BaseInfoViewController.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/3/1.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "BaseInfoViewController.h"
#import "RZRequest.h"
#import "MOFSPickerManager.h"

@interface BaseInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIPickerViewAccessibilityDelegate>
{
    NSString *xm,*sfzh,*xl,*zy,*ysr,*dw,*dwcs,*dwdz,*dwdh,*hyqk,*zns,*jzcs,*jzdz;
    NSInteger current_tag;
}
@property(strong,nonatomic)UITableView *tableview;
@property(strong,nonatomic)UIPickerView *pickerview;
@property(copy,nonatomic)NSArray *dataSource;
@property(copy,nonatomic)NSArray *pickArray;
@property(copy,nonatomic)NSArray *xueliArray;
@property(copy,nonatomic)NSArray *zhiyeArray;
@property(copy,nonatomic)NSArray *ysrArray;
@property(copy,nonatomic)NSArray *hykqArray;
@property(copy,nonatomic)NSArray *znsArray;
@property(copy,nonatomic)NSArray *inputedArray;

@end

@implementation BaseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"基本信息";
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    [self dataSource];
    [self xueliArray];
    [self zhiyeArray];
    [self znsArray];
    [self ysrArray];
    [self hykqArray];
    [self tableview];
    

    
    
    UIView *footer=[[UIView alloc]initWithFrame:Frame(0, 0, ScreenWidth, AUTO(70))];
    footer.backgroundColor=[UIColor groupTableViewBackgroundColor];
    UIButton *addButton=[UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame=Frame(AUTO(20), AUTO(10), ScreenWidth-AUTO(40), AUTO(50));
    [addButton setTitle:@"完成" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addButton.titleLabel.font=Font(AUTO(16));
    addButton.backgroundColor=[YhbMethods colorWithHexString:COLOR_BIG_BUTTON];
    [YhbMethods setView:addButton CornerRadius:AUTO(5) AndMasks:YES];
    [addButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:addButton];
    self.tableview.tableFooterView=footer;
    self.view=self.tableview;
    
    
    //已经认证，不能修改
    
    UserEntity *userModel =  [UserEntity shareUserEntity];
    if ([userModel.userInfoStatus boolValue] == YES) {
        addButton.userInteractionEnabled = NO;
        addButton.hidden = YES;
    }
    
    [RZRequest getUserInfoSuccess:^(id obj) {
        NSDictionary *dic = [YhbMethods setDicNullClass:obj];
        NSString *name=dic[@"name"];
        if ([name isKindOfClass:[NSString class]]&&name.length>1) {
            xm=dic[@"name"];
            sfzh=dic[@"idCard"];
            xl=dic[@"education"];
            zy=dic[@"job"];
            ysr=dic[@"income"];
            dw=dic[@"company"];
            dwcs=dic[@"companyCity"];
            dwdz=dic[@"companyAddress"];
            dwdh=dic[@"companyPhone"];
            hyqk=dic[@"marriage"];
            zns=dic[@"children"];
            jzcs=dic[@"addressCity"];
            jzdz=dic[@"address"];
            self.inputedArray=[NSArray new];
            self.inputedArray=@[xm,sfzh,xl,zy,ysr,dw,dwcs,dwdz,dwdh,hyqk,zns,jzcs,jzdz];
            [self.tableview reloadData];
        }
        
        
    }];
    

}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.pickArray=[NSArray new];
    current_tag=textField.tag;
    switch (textField.tag) {
        case 1002:
            _pickArray=_xueliArray;
            break;
        case 1003:
            _pickArray=_zhiyeArray;
            break;
        case 1004:
            _pickArray=_ysrArray;
            break;
        case 1009:
            _pickArray=_hykqArray;
            break;
        case 1010:
            _pickArray=_znsArray;
            break;
        default:
            break;
    }
    if (_pickArray.count>0) {
        textField.text=_pickArray[0];
        [_pickerview reloadAllComponents];
    }
}

-(void)next{
    UITextField *textField;
    UILabel *label;
    for (int i = 0 ; i<13; i++) {
        textField=[self.view viewWithTag:1000+i];
        label = [self.view viewWithTag:1100+i];
//        if ([YhbMethods isBlankString:textField.text]==YES&&i!=8) {
//            [AppUtils showAlertMessage:@"请填写完整"];
//            break;
//        }
        switch (i) {
            case 0:
                xm=textField.text;
                break;
            case 1:
                sfzh=textField.text;
                break;
            case 2:
                xl=textField.text;
                break;
            case 3:
                zy=textField.text;
                break;
            case 4:
                ysr=textField.text;
                break;
            case 5:
                dw=textField.text;
                break;
            case 6:
                dwcs=label.text;
                break;
            case 7:
                dwdz=textField.text;
                break;
            case 8:
                dwdh=textField.text;
                break;
            case 9:
                hyqk=textField.text;
                break;
            case 10:
                zns=textField.text;
                break;
            case 11:
                jzcs=label.text;
                break;
            case 12:
                jzdz=textField.text;
                break;
            default:
                break;
        }
   
    }
    
    NSMutableDictionary *dic=[NSMutableDictionary new];
    [dic setValue:xm?xm:[NSNull null] forKey:@"name"];
    [dic setValue:sfzh?sfzh:[NSNull null] forKey:@"idCard"];
    [dic setValue:xl?xl:[NSNull null] forKey:@"education"];
    [dic setValue:zy?zy:[NSNull null] forKey:@"job"];
    [dic setValue:ysr?ysr:[NSNull null] forKey:@"income"];
    [dic setValue:dw?dw:[NSNull null] forKey:@"company"];
    [dic setValue:dwcs?dwcs:[NSNull null] forKey:@"companyCity"];
    [dic setValue:dwdz?dwdz:[NSNull null] forKey:@"companyAddress"];
    [dic setValue:dwdh?dwdh:[NSNull null] forKey:@"companyPhone"];
    [dic setValue:hyqk?hyqk:[NSNull null] forKey:@"marriage"];
    [dic setValue:zns?zns:[NSNull null] forKey:@"children"];
    [dic setValue:jzcs?jzcs:[NSNull null] forKey:@"addressCity"];
    [dic setValue:jzdz?jzdz:[NSNull null] forKey:@"address"];
    
    [RZRequest submitUserInfoWithParam:dic success:^(id obj) {
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary *dic=self.dataSource[indexPath.row];

    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        UITextField *textField=[[UITextField alloc]initWithFrame:Frame(AUTO(120), 0, ScreenWidth-AUTO(130), AUTO(50))];
        textField.adjustsFontSizeToFitWidth=YES;
        textField.tag=1000+indexPath.row;
        textField.font=Font(AUTO(14));
        NSString *holderText3 =dic[@"placeholder"];
        NSMutableAttributedString *placeholder3 = [[NSMutableAttributedString alloc] initWithString:holderText3];
        [placeholder3 addAttribute:NSFontAttributeName
                             value:[UIFont systemFontOfSize:AUTO(14)]
                             range:NSMakeRange(0, holderText3.length)];
        textField.attributedPlaceholder=placeholder3;
        textField.delegate=self;
        if (indexPath.row==8) {
            textField.keyboardType=UIKeyboardTypePhonePad;
        }else{
            textField.keyboardType=UIKeyboardTypeDefault;
        }
        if (indexPath.row>=2 && indexPath.row<=4) {
            textField.inputView=self.pickerview;
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row>=9 && indexPath.row<=10){
            textField.inputView=self.pickerview;
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }else{
            textField.inputView=nil;
            cell.accessoryType=UITableViewCellAccessoryNone;
        }
        if (indexPath.row==6||indexPath.row==11) {
            UILabel *label = [[UILabel alloc]initWithFrame:Frame(AUTO(120), 0, ScreenWidth-AUTO(130), AUTO(50))];
            label.tag=1100+indexPath.row;
            label.text=@"请选择地址";
            label.font=Font(AUTO(14));
            label.textColor =[UIColor lightGrayColor];
            label.userInteractionEnabled=YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPikcer:)];
            [label addGestureRecognizer:tap];
            [cell.contentView addSubview:label];
        }else{
            [cell.contentView addSubview:textField];
        }
        
        
    }
    cell.textLabel.text=dic[@"title"];
    cell.textLabel.font=Font(AUTO(15));
    cell.selectionStyle=UITableViewCellSeparatorStyleNone;
    
    NSString *name = _inputedArray[0];
    if ([name isKindOfClass:[NSString class]]&&name.length>1) {
        UITextField *text=[self.view viewWithTag:1000+indexPath.row];
        UILabel *label = [self.view viewWithTag:1100+indexPath.row];
        text.text=_inputedArray[indexPath.row];
        label.text = _inputedArray [indexPath.row];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AUTO(50);
}
-(void)showPikcer:(UITapGestureRecognizer *)tap{
    NSLog(@"%ld",tap.view.tag);
    UILabel *label = [self.view viewWithTag:tap.view.tag];
    [[MOFSPickerManager shareManger]showMOFSAddressPickerWithTitle:@"选择地址" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString * _Nullable address, NSString * _Nullable zipcode) {
        NSLog(@"%@",address);
        label.text=address;
    } cancelBlock:^{

    }];
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
        _tableview=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
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
-(NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource=@[@{@"title":@"姓名",@"placeholder":@"请输入真实姓名"},
                          @{@"title":@"身份证号",@"placeholder":@"请输入身份证号"},
                          @{@"title":@"学历",@"placeholder":@"请选择"},
                          @{@"title":@"职业",@"placeholder":@"请选择"},
                          @{@"title":@"月收入",@"placeholder":@"请选择"},
                          @{@"title":@"单位",@"placeholder":@"请输入单位名称"},
                          @{@"title":@"单位所在城市",@"placeholder":@"请输入单位所在城市"},
                          @{@"title":@"单位详细地址",@"placeholder":@"请输入单位详细地址"},
                          @{@"title":@"单位电话",@"placeholder":@"请输入单位电话(选填)"},
                          @{@"title":@"婚姻情况",@"placeholder":@"请选择"},
                          @{@"title":@"子女数",@"placeholder":@"请选择"},
                          @{@"title":@"居住城市",@"placeholder":@"请填写居住城市"},
                          @{@"title":@"居住详细地址",@"placeholder":@"请填写详细地址(精确到门牌号)"}];
    }
    return _dataSource;
}
-(NSArray *)xueliArray{
    if (!_xueliArray) {
        _xueliArray=@[@"小学",@"初中",@"高中/中专/高职",@"大专",@"本科",@"研究生",@"博士以上"];
    }
    return _xueliArray;
}
-(NSArray *)zhiyeArray{
    if (!_zhiyeArray) {
        _zhiyeArray=@[@"教师",@"服务员",@"厨师",@"司机",@"理发师",@"教练",@"文员",@"私营业主",@"销售",@"客服",@"营业员",@"律师",@"医生",@"会计",@"文案",@"工程师",@"程序员",@"设计师",@"其他"];
    }
    return _zhiyeArray;
}
-(NSArray *)ysrArray{
    if (!_ysrArray) {
        _ysrArray=@[@"1000以下",@"1000-3000",@"3000-6000",@"6000-10000",@"10000以上"];
    }
    return _ysrArray;
}
-(NSArray *)hykqArray{
    if (!_hykqArray) {
        _hykqArray=@[@"未婚",@"已婚"];
    }
    return _hykqArray;
}
-(NSArray *)znsArray{
    if (!_znsArray) {
        _znsArray=@[@"0个",@"1个",@"2个",@"3个及以上"];
    }
    return _znsArray;
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
