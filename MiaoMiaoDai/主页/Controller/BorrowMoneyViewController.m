//
//  BorrowMoneyViewController.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/3/29.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "BorrowMoneyViewController.h"
#import "BankCardViewController.h"
#import "HomeRequest.h"
#import "BankCardModel.h"
#import "CommonUseWebViewController.h"
#import "InputTradePasswordViewController.h"

@interface BorrowMoneyViewController ()<UITextFieldDelegate>
{
    NSArray *moneyArray;
    NSInteger selectedBtnTag;
}
@property(strong,nonatomic)UILabel *serverLabel,*feeLabel,*arriveLabel,*returnMoneyLabel,*bankCardLabel;
@property(strong,nonatomic)UIButton *tmpBtn,*agreeBtn,*xieyiBtn,*nextButton;
@property (nonatomic,strong) UITextField *moneyText,*weekText;

@property (nonatomic,strong) NSMutableDictionary *param;

@end

@implementation BorrowMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"借款";
    
    [self setupviews];
    [self param];
    
}

-(void)next{
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=9.0) {
        UIAlertController *alertcontrol=[UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"您将借款%@元",self.param[@"money"]] preferredStyle:1];
        UIAlertAction *aciton=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            InputTradePasswordViewController *vc=[InputTradePasswordViewController new];
            vc.param=self.param;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        [alertcontrol addAction:aciton];
        [alertcontrol addAction:action1];
        
        
        [self presentViewController:alertcontrol animated:YES completion:nil];
    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"您将借款%@元",self.param[@"money"]] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去登录", nil];
        [alert show];
    }
   
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        InputTradePasswordViewController *vc=[InputTradePasswordViewController new];
        vc.param=self.param;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)getDataWithMoney:(NSString *)money AndWeeks:(NSString *)Weeks{
    [HomeRequest getLixiWithMoney:money days:Weeks success:^(id obj) {
        NSDictionary *dic=[YhbMethods setDicNullClass:obj];
        self.serverLabel.text=[NSString stringWithFormat:@"%.2f 元",[dic[@"serviceCharge"]doubleValue]];
        self.feeLabel.text=[NSString stringWithFormat:@"%.2f 元",[dic[@"interest"]doubleValue]];
        self.returnMoneyLabel.text=[NSString stringWithFormat:@"%.2f 元",[dic[@"totalOwe"]doubleValue]];
        double totalOwe = [dic[@"totalOwe"]doubleValue];
        double serviceCharge = [dic[@"serviceCharge"]doubleValue];
        double interest = [dic[@"interest"]doubleValue];
        double arrive=totalOwe-serviceCharge-interest;
        self.arriveLabel.text=[NSString stringWithFormat:@"%.2f 元",arrive];
        
        [_param setValue:@(totalOwe) forKey:@"money"];
        [_param setValue:@(interest) forKey:@"interest"];
        [_param setValue:@(serviceCharge) forKey:@"serviceCharge"];
        [_param setValue:Weeks forKey:@"days"];
    }];
}


-(void)setupviews{
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIScrollView *scroll=[[UIScrollView alloc]initWithFrame:Frame(0, 0, ScreenWidth, ScreenHeight-NavHeight-TAB_BAR_HEIGHT)];
    scroll.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    [self.view addSubview: scroll];
    
    UIView *topview=[[UIView alloc]init];
    topview.backgroundColor=[UIColor whiteColor];
    [scroll addSubview:topview];
    topview.sd_layout
    .topSpaceToView(scroll, AUTO(10))
    .leftEqualToView(scroll)
    .rightEqualToView(scroll);
    
    UILabel *jkje=[[UILabel alloc]init];
    jkje.text=@"借多少";
    jkje.textColor=[UIColor darkGrayColor];
    jkje.font=Font(AUTO(20));
    [topview addSubview:jkje];
    jkje.sd_layout
    .topSpaceToView(topview, AUTO(20))
    .leftSpaceToView(topview, AUTO(10))
    .autoHeightRatio(0);
    [jkje setSingleLineAutoResizeWithMaxWidth:300];
    
    UIView *line1=[[UIView alloc]init];
    line1.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [topview addSubview:line1];
    line1.sd_layout
    .topSpaceToView(jkje, AUTO(20))
    .leftSpaceToView(topview, AUTO(10))
    .rightEqualToView(topview)
    .heightIs(AUTO(0.5));
    
    
    
    UILabel *yuan=[UILabel new];
    yuan.text=@"元";
    yuan.font=Font(AUTO(16));
    yuan.textColor=_moneyText.textColor;
    [topview addSubview:yuan];
    yuan.sd_layout
    .centerYEqualToView(jkje)
    .rightSpaceToView(topview, AUTO(10))
    .autoHeightRatio(0);
    [yuan setSingleLineAutoResizeWithMaxWidth:300];
    
    
    self.moneyText=[UITextField new];
    _moneyText.placeholder=[NSString stringWithFormat:@"最多借50000"];
    _moneyText.font=[UIFont systemFontOfSize:AUTO(20) weight:UIFontWeightThin];
    _moneyText.textColor=[UIColor darkGrayColor];
    _moneyText.textAlignment=NSTextAlignmentRight;
    _moneyText.keyboardType=UIKeyboardTypeNumberPad;
    _moneyText.delegate=self;
    [topview addSubview:_moneyText];
    _moneyText.sd_layout
    .topEqualToView(topview)
    .bottomEqualToView(line1)
    .leftSpaceToView(jkje, AUTO(10))
    .rightSpaceToView(yuan, AUTO(5));
    
    
    UILabel *jkzq=[[UILabel alloc]init];
    jkzq.text=@"借多久";
    jkzq.textColor=[UIColor darkGrayColor];
    jkzq.font=Font(AUTO(20));
    [topview addSubview:jkzq];
    jkzq.sd_layout
    .topSpaceToView(line1, AUTO(20))
    .leftSpaceToView(topview, AUTO(10))
    .autoHeightRatio(0);
    [jkzq setSingleLineAutoResizeWithMaxWidth:300];
    
    UIView *sep=[[UIView alloc]init];
    sep.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    [topview addSubview:sep];
    sep.sd_layout
    .topSpaceToView(jkzq, AUTO(20))
    .leftEqualToView(topview)
    .rightEqualToView(topview)
    .heightIs(AUTO(10));
    
    UILabel *zhou=[UILabel new];
    zhou.text=@"周";
    zhou.font=Font(AUTO(16));
    zhou.textColor=_moneyText.textColor;
    [topview addSubview:zhou];
    zhou.sd_layout
    .centerYEqualToView(jkzq)
    .rightSpaceToView(topview, AUTO(10))
    .autoHeightRatio(0);
    [zhou setSingleLineAutoResizeWithMaxWidth:300];
    
    self.weekText=[UITextField new];
    _weekText.placeholder=[NSString stringWithFormat:@"最长借50"];
    _weekText.font=[UIFont systemFontOfSize:AUTO(20) weight:UIFontWeightThin];
    _weekText.textColor=[UIColor darkGrayColor];
    _weekText.textAlignment=NSTextAlignmentRight;
    _weekText.delegate=self;
    _weekText.keyboardType=UIKeyboardTypeNumberPad;
    [topview addSubview:_weekText];
    _weekText.sd_layout
    .topEqualToView(line1)
    .bottomSpaceToView(sep, 0)
    .leftSpaceToView(jkzq, AUTO(10))
    .rightSpaceToView(zhou, AUTO(5));

    UILabel *serverFeeLabel=[UILabel new];
    serverFeeLabel.text=@"服务费:";
    serverFeeLabel.font=Font(AUTO(16));
    serverFeeLabel.textColor=[UIColor darkGrayColor];
    [topview addSubview:serverFeeLabel];
    serverFeeLabel.sd_layout
    .topSpaceToView(sep, AUTO(10))
    .leftEqualToView(jkje)
    .autoHeightRatio(0);
    [serverFeeLabel setSingleLineAutoResizeWithMaxWidth:300];

    UIImageView *line=[[UIImageView alloc]initWithImage:Image(@"line")];
    [topview addSubview:line];
    line.sd_layout
    .topSpaceToView(serverFeeLabel, AUTO(10))
    .leftEqualToView(topview)
    .rightEqualToView(topview)
    .heightIs(AUTO(1));

    UILabel *lixiLabel=[UILabel new];
    lixiLabel.text=@"利息:";
    lixiLabel.font=Font(AUTO(16));
    lixiLabel.textColor=[UIColor darkGrayColor];
    [topview addSubview:lixiLabel];
    lixiLabel.sd_layout
    .topSpaceToView(line, AUTO(10))
    .leftEqualToView(jkje)
    .autoHeightRatio(0);
    [lixiLabel setSingleLineAutoResizeWithMaxWidth:300];


    UIImageView *line3=[[UIImageView alloc]initWithImage:Image(@"line")];
    [topview addSubview:line3];
    line3.sd_layout
    .topSpaceToView(lixiLabel, AUTO(10))
    .leftEqualToView(topview)
    .rightEqualToView(topview)
    .heightIs(AUTO(1));

    UILabel *daozhangLabel=[UILabel new];
    daozhangLabel.text=@"实际到账:";
    daozhangLabel.font=Font(AUTO(16));
    daozhangLabel.textColor=[UIColor darkGrayColor];
    [topview addSubview:daozhangLabel];
    daozhangLabel.sd_layout
    .topSpaceToView(line3, AUTO(10))
    .leftEqualToView(jkje)
    .autoHeightRatio(0);
    [daozhangLabel setSingleLineAutoResizeWithMaxWidth:300];

    UIButton *noticeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [noticeBtn setImage:Image(@"icon_question") forState:UIControlStateNormal];
    [noticeBtn addTarget:self action:@selector(alertMsg) forControlEvents:UIControlEventTouchUpInside];
    [topview addSubview:noticeBtn];

    noticeBtn.sd_layout
    .centerYEqualToView(daozhangLabel)
    .leftSpaceToView(daozhangLabel, AUTO(10))
    .heightIs(AUTO(20))
    .widthEqualToHeight();

    
    self.serverLabel=[UILabel new];
    _serverLabel.text=@" 元";
    _serverLabel.font=serverFeeLabel.font;
    _serverLabel.textColor=[UIColor darkGrayColor];
    [topview addSubview:_serverLabel];
    _serverLabel.sd_layout
    .centerYEqualToView(serverFeeLabel)
    .rightSpaceToView(topview, AUTO(10))
    .autoHeightRatio(0);
    [_serverLabel setSingleLineAutoResizeWithMaxWidth:300];

    self.feeLabel=[UILabel new];
    _feeLabel.text=@" 元";
    _feeLabel.font=serverFeeLabel.font;
    _feeLabel.textColor=[UIColor darkGrayColor];
    [topview addSubview:_feeLabel];
    _feeLabel.sd_layout
    .centerYEqualToView(lixiLabel)
    .rightSpaceToView(topview, AUTO(10))
    .autoHeightRatio(0);
    [_feeLabel setSingleLineAutoResizeWithMaxWidth:300];

    self.arriveLabel=[UILabel new];
    _arriveLabel.text=@" 元";
    _arriveLabel.font=serverFeeLabel.font;
    _arriveLabel.textColor=[UIColor darkGrayColor];
    [topview addSubview:_arriveLabel];
    _arriveLabel.sd_layout
    .centerYEqualToView(daozhangLabel)
    .rightSpaceToView(topview, AUTO(10))
    .autoHeightRatio(0);
    [_arriveLabel setSingleLineAutoResizeWithMaxWidth:300];


    [topview setupAutoHeightWithBottomView:_arriveLabel bottomMargin:AUTO(15)];


    UIButton *bankcardBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    bankcardBtn.backgroundColor=[UIColor whiteColor];
    [bankcardBtn addTarget:self action:@selector(toBankCardListVC) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:bankcardBtn];
    bankcardBtn.sd_layout
    .topSpaceToView(topview, AUTO(10))
    .leftEqualToView(scroll)
    .rightEqualToView(scroll)
    .heightIs(AUTO(44));

    UILabel *cardLabel=[[UILabel alloc]initWithFrame:Frame(AUTO(10), 0, ScreenWidth/2, AUTO(44))];
    cardLabel.textColor=[UIColor darkGrayColor];
    cardLabel.text=@"收款银行卡";
    cardLabel.font=Font(AUTO(16));
    [bankcardBtn addSubview:cardLabel];

    UIImageView *arrow=[[UIImageView alloc]initWithImage:Image(@"icon_right")];
    [bankcardBtn addSubview:arrow];
    arrow.sd_layout
    .centerYEqualToView(bankcardBtn)
    .rightSpaceToView(bankcardBtn, AUTO(10))
    .heightIs(AUTO(18))
    .widthEqualToHeight();

    self.bankCardLabel=[UILabel new];
    _bankCardLabel.textColor=[UIColor lightGrayColor];
    _bankCardLabel.text=@"请选择";
    _bankCardLabel.font=Font(AUTO(15));
    [bankcardBtn addSubview:_bankCardLabel];
    _bankCardLabel.sd_layout
    .centerYEqualToView(arrow)
    .rightSpaceToView(arrow, AUTO(5))
    .autoHeightRatio(0);
    [_bankCardLabel setSingleLineAutoResizeWithMaxWidth:300];

    self.agreeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_agreeBtn setImage:Image(@"未选中") forState:UIControlStateNormal];
    [_agreeBtn setImage:Image(@"选中") forState:UIControlStateSelected];
    [_agreeBtn setTitle:@"我同意" forState:UIControlStateNormal];
    [_agreeBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _agreeBtn.titleLabel.font=Font(AUTO(16));
    [_agreeBtn addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:_agreeBtn];
    _agreeBtn.sd_layout
    .topSpaceToView(bankcardBtn, AUTO(15))
    .leftSpaceToView(scroll, AUTO(10))
    .widthIs(AUTO(80))
    .heightIs(AUTO(30));

    _agreeBtn.imageView.sd_layout
    .centerYEqualToView(_agreeBtn)
    .leftSpaceToView(_agreeBtn, 0)
    .widthIs(AUTO(25))
    .heightEqualToWidth();


    self.xieyiBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [_xieyiBtn setTitle:@"《征信查询授权书》" forState:UIControlStateNormal];
    _xieyiBtn.titleLabel.font=_agreeBtn.titleLabel.font;
    [scroll addSubview:_xieyiBtn];
    _xieyiBtn.sd_layout
    .centerYEqualToView(_agreeBtn)
    .leftSpaceToView(_agreeBtn, 0);
    [_xieyiBtn setupAutoSizeWithHorizontalPadding:0 buttonHeight:AUTO(30)];
    [_xieyiBtn addTarget:self action:@selector(ZXCX) forControlEvents:UIControlEventTouchUpInside];

    [scroll setupAutoContentSizeWithBottomView:_xieyiBtn bottomMargin:AUTO(30)];
    
    UIView *bottomview=[[UIView alloc]init];
    bottomview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bottomview];
    bottomview.sd_layout
    .topSpaceToView(scroll, 0)
    .bottomSpaceToView(self.view, 0)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view);
    
    self.nextButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_nextButton setTitle:@"确认" forState:UIControlStateNormal];
    _nextButton.titleLabel.font=Font(AUTO(15));
    _nextButton.backgroundColor=[UIColor lightGrayColor];
    [_nextButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [bottomview addSubview:_nextButton];
    _nextButton.sd_layout
    .topEqualToView(bottomview)
    .bottomEqualToView(bottomview)
    .rightEqualToView(bottomview)
    .widthIs(AUTO(100));
    if (iPhoneX) {
        _nextButton.sd_resetLayout
        .topSpaceToView(bottomview, AUTO(5))
        .bottomSpaceToView(bottomview, AUTO(5)+34)
        .rightSpaceToView(bottomview, AUTO(5))
        .widthIs(AUTO(100));
        _nextButton.sd_cornerRadius=@(AUTO(3));
        
    }
    
    UILabel *yinghuan=[[UILabel alloc]initWithFrame:Frame(AUTO(10), 0, AUTO(80), 49)];
    yinghuan.text=@"到期应还:";
    yinghuan.textColor=[UIColor darkGrayColor];
    yinghuan.font=Font(AUTO(16));
    [bottomview addSubview:yinghuan];
    [yinghuan setSingleLineAutoResizeWithMaxWidth:300];
    
    self.returnMoneyLabel=[UILabel new];
    _returnMoneyLabel.textColor=[UIColor orangeColor];
    _returnMoneyLabel.text=@"10000.0元";
    _returnMoneyLabel.font=Font(AUTO(16));
    [bottomview addSubview:_returnMoneyLabel];
    _returnMoneyLabel.sd_layout
    .centerYEqualToView(yinghuan)
    .leftSpaceToView(yinghuan, 0)
    .autoHeightRatio(0);
    [_returnMoneyLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    
    [_weekText addTarget:self action:@selector(textFieldTextDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [_moneyText addTarget:self action:@selector(textFieldTextDidChanged:) forControlEvents:UIControlEventEditingChanged];
}
-(void)textFieldTextDidChanged:(UITextField *)text{
    NSLog(@"%@",text.text);
    if (text==_moneyText) {
        if ([text.text intValue]>50000) {
            [AppUtils showTipsMessage:@"金额不能超过50000元"];
            text.text=@"50000";
        }
    }else{
        if ([text.text intValue]>50) {
            [AppUtils showTipsMessage:@"最长时间不能超过50周"];
            text.text=@"50";
        }
    }
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (_weekText.text.length!=0 && _moneyText.text.length!=0 &&[_moneyText.text intValue]>=500) {
        [self getDataWithMoney:_moneyText.text AndWeeks:_weekText.text];
    }
}


-(void)agree:(UIButton *)sender{
    sender.selected=!sender.selected;
    if (sender.selected) {
        if (![_bankCardLabel.text isEqualToString:@"请选择"]) {
            _nextButton.backgroundColor=[YhbMethods colorWithHexString:COLOR_MAIN];
            _nextButton.enabled=YES;
        }else{
            _nextButton.backgroundColor=[UIColor lightGrayColor];
            _nextButton.enabled=NO;
        }
    }else{
        _nextButton.backgroundColor=[UIColor lightGrayColor];
        _nextButton.enabled=NO;
    }
    
}
-(void)alertMsg{
    [AppUtils showAlertMessage:@"为了提高风险控制能力，实际到账金额会先减掉服务费和利息，即：\n 实际到账金额=申请借款金额-服务费-利息"];
}
-(void)ZXCX{
    CommonUseWebViewController *vc=[CommonUseWebViewController new];
    vc.urlStr=@"http://app.qzxwmy.com:8080/xinwei-server/app/contract/ContactContract";
    vc.titleStr=@"征信查询授权书";
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)toBankCardListVC{
    BankCardViewController *vc=[BankCardViewController new];
    
    vc.returnCard = ^(BankCardModel *model) {
        [_param setValue:model.cardNumber forKey:@"cardNo"];
        _bankCardLabel.text=[NSString stringWithFormat:@"尾号 %@",[model.cardNumber substringFromIndex:model.cardNumber.length-4]];
        if (_agreeBtn.selected==YES) {
            
            _nextButton.backgroundColor=[YhbMethods colorWithHexString:COLOR_MAIN];
            _nextButton.enabled=YES;
        }else{
            
            _nextButton.backgroundColor=[UIColor lightGrayColor];
            _nextButton.enabled=NO;
        }
    };
    [self.navigationController pushViewController:vc animated:YES];
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
