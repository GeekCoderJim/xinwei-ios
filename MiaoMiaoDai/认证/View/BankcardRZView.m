//
//  BankcardRZView.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/6/11.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "BankcardRZView.h"

#define COLOR_BG [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1]

#define FONT_SIZE 15.0f

@implementation BankcardRZView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    [self setupView];
      [self getData];
  }
  return self;
}

- (void)getData{
    UserEntity *user = [UserEntity shareUserEntity];
    _text_Name.text = user.name;
    _text_IDNumber.text = user.idCard;
}

- (void)setupView
{
  self.scrollView = [[UIScrollView alloc]initWithFrame:ScreenBounds];
  _scrollView.showsVerticalScrollIndicator = NO;
  _scrollView.alwaysBounceVertical = NO;
  _scrollView.contentSize=CGSizeMake(ScreenWidth, ScreenHeight);
  _scrollView.backgroundColor = COLOR_BG;
  [self addSubview:_scrollView];
  
  UIView *view = [[UIView alloc]init];
  view.backgroundColor = [UIColor whiteColor];
  [_scrollView addSubview:view];
  view.sd_layout
  .topSpaceToView(_scrollView, AUTO(AUTO(10)))
  .leftEqualToView(_scrollView)
  .rightEqualToView(_scrollView)
  .heightIs(404.5);
  
  
  UIView *line = [[UIView alloc]initWithFrame:Frame(0, 0, ScreenWidth, 0.5)];
  line.backgroundColor = [UIColor lightGrayColor];
  [view addSubview:line];
  
  UIView *line2 = [[UIView alloc]initWithFrame:Frame(10, 50, ScreenWidth-10, 0.5)];
  line2.backgroundColor = [UIColor lightGrayColor];
  [view addSubview:line2];
  
  UIView *line3 = [[UIView alloc]initWithFrame:Frame(10, 100, ScreenWidth-10, 0.5)];
  line3.backgroundColor = [UIColor lightGrayColor];
  [view addSubview:line3];

  UIView *line4 = [[UIView alloc]initWithFrame:Frame(10, 150, ScreenWidth-10, 0.5)];
  line4.backgroundColor = [UIColor lightGrayColor];
  [view addSubview:line4];

  
  UIView *line5 = [[UIView alloc]initWithFrame:Frame(10, 200, ScreenWidth-10, 0.5)];
  line5.backgroundColor = [UIColor lightGrayColor];
  [view addSubview:line5];

  
  UIView *line6 = [[UIView alloc]initWithFrame:Frame(10, 250, ScreenWidth-10, 0.5)];
  line6.backgroundColor = [UIColor lightGrayColor];
  [view addSubview:line6];
  
  UIView *line7 = [[UIView alloc]initWithFrame:Frame(10, 300, ScreenWidth-10, 0.5)];
  line7.backgroundColor = [UIColor lightGrayColor];
  [view addSubview:line7];

  
  UIView *line8 = [[UIView alloc]initWithFrame:Frame(10, 350, ScreenWidth-10, 0.5)];
  line8.backgroundColor = [UIColor lightGrayColor];
  [view addSubview:line8];

  
  UIView *line9 = [[UIView alloc]initWithFrame:Frame(0, 404, ScreenWidth, 0.5)];
  line9.backgroundColor = [UIColor lightGrayColor];
  [view addSubview:line9];

  
  
  UILabel *lab_Name = [[UILabel alloc]init];
  lab_Name.text = @"姓名";
  lab_Name.textColor       = [YhbMethods colorWithHexString:@"#686868"];
  lab_Name.font=Font(AUTO(16));
  [view addSubview:lab_Name];
  lab_Name.sd_layout
  .topEqualToView(line)
  .bottomEqualToView(line2)
  .leftEqualToView(line2)
  .widthIs(AUTO(100));
  
  
  
  _text_Name = [[UITextField alloc]initWithFrame:CGRectMake(110, 1,200, 49)];
  _text_Name.font            = [UIFont systemFontOfSize:FONT_SIZE];
  _text_Name.textColor       = [YhbMethods colorWithHexString:@"#a4a4a4"];;
  _text_Name.placeholder     = @"请输入真实姓名";
  [_text_Name setValue:[YhbMethods colorWithHexString:@"#e2e1e1"] forKeyPath:@"_placeholderLabel.textColor"];
  //    _text_Name.backgroundColor = [UIColor whiteColor];
  _text_Name.clearButtonMode = UITextFieldViewModeWhileEditing;
    

  [view addSubview:_text_Name];
  _text_Name.sd_layout
  .topEqualToView(line)
  .bottomEqualToView(line2)
  .leftSpaceToView(lab_Name, 0)
  .rightSpaceToView(view, AUTO(10));
  
  
  UILabel *lab_IDNumber = [[UILabel alloc]initWithFrame:CGRectMake(12, 51, 100, 50)];
  lab_IDNumber.text = @"身份证号码";
  lab_IDNumber.textColor       = [YhbMethods colorWithHexString:@"#686868"];;
  lab_IDNumber.font=Font(AUTO(16));
  [view addSubview:lab_IDNumber];
  lab_IDNumber.sd_layout
  .topEqualToView(line2)
  .bottomEqualToView(line3)
  .leftEqualToView(line3)
  .widthIs(AUTO(100));
  
  
  _text_IDNumber = [[UITextField alloc]initWithFrame:CGRectMake(110, 51,200, 50)];
  _text_IDNumber.font            = [UIFont systemFontOfSize:FONT_SIZE];
  _text_IDNumber.textColor       = [YhbMethods colorWithHexString:@"#a4a4a4"];;
  _text_IDNumber.placeholder     = @"请注意身份证带X的请用#号代替";
  _text_IDNumber.keyboardType = UIKeyboardTypePhonePad;
  //    _text_IDNumber.backgroundColor = [UIColor whiteColor];
  [_text_IDNumber setValue:[YhbMethods colorWithHexString:@"#e2e1e1"] forKeyPath:@"_placeholderLabel.textColor"];
  _text_IDNumber.clearButtonMode = UITextFieldViewModeWhileEditing;
  [view addSubview:_text_IDNumber];
  _text_IDNumber.sd_layout
  .topEqualToView(line2)
  .bottomEqualToView(line3)
  .leftSpaceToView(lab_IDNumber, 0)
  .rightSpaceToView(view, AUTO(10));
  
  
  
  
  UILabel *lab_CardNumber = [[UILabel alloc]initWithFrame:CGRectMake(12, 102, 100, 50)];
  lab_CardNumber.text = @"银行卡号";
  lab_CardNumber.textColor       = [YhbMethods colorWithHexString:@"#686868"];;
  lab_CardNumber.font=Font(AUTO(16));
  [view addSubview:lab_CardNumber];
  lab_CardNumber.sd_layout
  .topEqualToView(line3)
  .bottomEqualToView(line4)
  .leftEqualToView(line4)
  .widthIs(AUTO(100));
  
  
 
  
  
  _text_CardNumber = [[UITextField alloc]initWithFrame:CGRectMake(110, 103,200, 48)];
  _text_CardNumber.font            = [UIFont systemFontOfSize:FONT_SIZE];
  _text_CardNumber.textColor       = [YhbMethods colorWithHexString:@"#a4a4a4"];;
  _text_CardNumber.placeholder     = @"请输入提款人卡号（储蓄卡）";
  [_text_CardNumber setValue:[YhbMethods colorWithHexString:@"#e2e1e1"] forKeyPath:@"_placeholderLabel.textColor"];
  _text_CardNumber.clearButtonMode = UITextFieldViewModeWhileEditing;
  _text_CardNumber.keyboardType    = UIKeyboardTypeNumberPad;
  [view addSubview:_text_CardNumber];
  _text_CardNumber.sd_layout
  .topEqualToView(line3)
  .bottomEqualToView(line4)
  .leftSpaceToView(lab_CardNumber, 0)
  .rightSpaceToView(view, AUTO(10));
  
  UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(12, 152, 100, 50)];
  lab.text = @"银行类型";
  lab.textColor       = [YhbMethods colorWithHexString:@"#686868"];;
  lab.font=Font(AUTO(16));
  [view addSubview:lab];
  lab.sd_layout
  .topEqualToView(line4)
  .bottomEqualToView(line5)
  .leftEqualToView(line5)
  .widthIs(AUTO(100));
  
  
  _text_bankName = [[UITextField alloc]initWithFrame:CGRectMake(110, 153,200, 48)];
  _text_bankName.font            = [UIFont systemFontOfSize:AUTO(16)];
  _text_bankName.textColor       = [YhbMethods colorWithHexString:@"#a4a4a4"];
  _text_bankName.text     = @"银行类型";
  //    _text_bankName.backgroundColor = [UIColor whiteColor];
  //icon_arrow
  UIButton *clearButton = [_text_bankName valueForKey:@"_clearButton"];
  [clearButton setImage:[UIImage imageNamed:@"icon_arrow"] forState:UIControlStateNormal];
  _text_bankName.clearButtonMode = UITextFieldViewModeAlways;
  _text_bankName.keyboardType    = UIKeyboardTypeNumberPad;
  
  
  [view addSubview:_text_bankName];
  _text_bankName.sd_layout
  .topEqualToView(line4)
  .bottomEqualToView(line5)
  .leftSpaceToView(lab, 0)
  .rightSpaceToView(view, AUTO(10));
  
  
  UILabel *lab_city = [[UILabel alloc]init];
  lab_city.text = @"开户城市";
  lab_city.textColor       = [YhbMethods colorWithHexString:@"#686868"];;
  lab_city.font=Font(AUTO(16));
  [view addSubview:lab_city];
  lab_city.sd_layout
  .topEqualToView(line5)
  .bottomEqualToView(line6)
  .leftEqualToView(line6)
  .widthIs(AUTO(100));
  
  self.text_city=[[UITextField alloc]init];
  _text_city.text = @"点击选择开户城市";
  _text_city.textColor = [YhbMethods colorWithHexString:@"#a4a4a4"];
  _text_city.font=Font(AUTO(16));
  _text_city.keyboardType = UIKeyboardTypeNumberPad;
  _text_city.clearButtonMode = UITextFieldViewModeAlways;
  UIButton *clearButton1 = [_text_city valueForKey:@"_clearButton"];
  [clearButton1 setImage:[UIImage imageNamed:@"icon_arrow"] forState:UIControlStateNormal];
  [view addSubview:_text_city];
  _text_city.sd_layout
  .topEqualToView(line5)
  .bottomEqualToView(line6)
  .leftSpaceToView(lab_city, 0)
  .rightSpaceToView(view, AUTO(10));
  
  UILabel *lab_fenhang = [[UILabel alloc]init];
  lab_fenhang.text = @"开户分行";
  lab_fenhang.textColor = [YhbMethods colorWithHexString:@"#686868"];;
  lab_fenhang.font=Font(AUTO(16));
  [view addSubview:lab_fenhang];
  lab_fenhang.sd_layout
  .topEqualToView(line6)
  .bottomEqualToView(line7)
  .leftEqualToView(line7)
  .widthIs(AUTO(100));
  
  self.text_subbranch=[[UILabel alloc]init];
  _text_subbranch.text = @"点击选择开户分行";
  _text_subbranch.textColor = [YhbMethods colorWithHexString:@"#a4a4a4"];;
  _text_subbranch.font=Font(AUTO(16));
  UIImageView *imagev=[[UIImageView alloc]init];
  imagev.image=Image(@"icon_arrow");
  [_text_subbranch addSubview:imagev];
  imagev.sd_layout
  .centerYEqualToView(_text_subbranch)
  .rightSpaceToView(_text_subbranch, AUTO(10))
  .heightIs(imagev.image.size.height)
  .widthIs(imagev.image.size.width);
  [view addSubview:_text_subbranch];
  _text_subbranch.sd_layout
  .topEqualToView(line6)
  .bottomEqualToView(line7)
  .leftSpaceToView(lab_fenhang, 0)
  .rightSpaceToView(view, AUTO(10));
  
  UILabel *lab_phoneNumber = [[UILabel alloc]initWithFrame:CGRectMake(12, 202, 100, 50)];
  lab_phoneNumber.text = @"手机号";
  lab_phoneNumber.textColor       = [YhbMethods colorWithHexString:@"#686868"];
  lab_phoneNumber.font=Font(AUTO(16));
  [view addSubview:lab_phoneNumber];
  lab_phoneNumber.sd_layout
  .topEqualToView(line7)
  .bottomEqualToView(line8)
  .leftEqualToView(line8)
  .widthIs(AUTO(100));
  
  
  _text_phoneNumber = [[UILabel alloc]initWithFrame:CGRectMake(110, 203,200, 48)];
  _text_phoneNumber.font            = [UIFont systemFontOfSize:AUTO(16)];
  _text_phoneNumber.textColor       = [YhbMethods colorWithHexString:@"#e2e1e1"];;
  [view addSubview:_text_phoneNumber];
  _text_phoneNumber.sd_layout
  .topEqualToView(line7)
  .bottomEqualToView(line8)
  .leftSpaceToView(lab, 0)
  .rightSpaceToView(view, AUTO(10));
  
  
  UILabel *lab_yzm = [[UILabel alloc]init];
  lab_yzm.text = @"验证码";
  lab_yzm.textColor       = [YhbMethods colorWithHexString:@"#686868"];;
  lab_yzm.font=Font(AUTO(16));
  [view addSubview:lab_yzm];
  lab_yzm.sd_layout
  .topEqualToView(line8)
  .bottomEqualToView(line9)
  .leftEqualToView(line8)
  .widthIs(AUTO(100));
  
  
  _btn_GetVerificationButton     = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  _btn_GetVerificationButton .frame = CGRectMake(190,256,120, 40);
  _btn_GetVerificationButton.backgroundColor=[UIColor whiteColor];
  _btn_GetVerificationButton.layer.masksToBounds=YES;
  _btn_GetVerificationButton.layer.cornerRadius=20;
  [ _btn_GetVerificationButton setTitle:@"立即发送" forState:UIControlStateNormal];
  _btn_GetVerificationButton.titleLabel.font = [UIFont boldSystemFontOfSize:AUTO(13)];
  [ _btn_GetVerificationButton setTintColor:[YhbMethods colorWithHexString:COLOR_MAIN]];
  [YhbMethods setViewBorder:_btn_GetVerificationButton BorderWidth:AUTO(1) BorderColor:[YhbMethods colorWithHexString:COLOR_MAIN]];
  [YhbMethods setView:_btn_GetVerificationButton CornerRadius:AUTO(15) AndMasks:YES];
  [view addSubview: _btn_GetVerificationButton];
  _btn_GetVerificationButton.sd_layout
  .topSpaceToView(line8, AUTO(10))
  .bottomSpaceToView(line9, AUTO(10))
  .rightSpaceToView(view, AUTO(10))
  .widthIs(AUTO(100));
  
  _text_Verification = [[UITextField alloc]initWithFrame:CGRectMake(110, 350,160, 50)];
  _text_Verification.font            = [UIFont systemFontOfSize:FONT_SIZE];
  _text_Verification.textColor       = [YhbMethods colorWithHexString:@"#a4a4a4"];;
  _text_Verification.placeholder     = @"请输入验证码";
  [_text_Verification setValue:[YhbMethods colorWithHexString:@"#e2e1e1"] forKeyPath:@"_placeholderLabel.textColor"];
  _text_Verification.clearButtonMode = UITextFieldViewModeWhileEditing;
  _text_Verification.keyboardType    = UIKeyboardTypeNumberPad;
  [view addSubview:_text_Verification];
    _text_Verification.sd_layout
    .topSpaceToView(line8, AUTO(10))
    .bottomSpaceToView(line9, AUTO(10))
    .rightSpaceToView(_btn_GetVerificationButton, AUTO(10))
    .leftSpaceToView(lab_yzm, 10);
   

  
  UILabel *lable = [[UILabel alloc]init];
  lable.text =  [NSString stringWithFormat:@"我们对此承诺此信息仅用于验证您的身份，我们将严格加密保管您的信息"];
  lable.font = [UIFont systemFontOfSize:AUTO(12)];
  lable.numberOfLines = 0;
  lable.textColor = [UIColor lightGrayColor];
  [_scrollView addSubview:lable];
  lable.sd_layout
  .topSpaceToView(view, AUTO(10))
  .leftSpaceToView(_scrollView, AUTO(10))
  .rightSpaceToView(_scrollView, AUTO(10))
  .autoHeightRatio(0);
  
  
  self.btn_Next = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  _btn_Next.titleLabel.font = [UIFont boldSystemFontOfSize:AUTO(18)];
  [_btn_Next setTitle:@"下一步" forState:UIControlStateNormal];
  _btn_Next.backgroundColor=[YhbMethods colorWithHexString:COLOR_MAIN];
  [_btn_Next setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//  [YhbMethods setRedButtonHighLight:_btn_Next];
  [_scrollView addSubview: _btn_Next];
  _btn_Next.sd_layout
  .topSpaceToView(lable, AUTO(20))
  .leftSpaceToView(_scrollView, AUTO(30))
  .rightSpaceToView(_scrollView, AUTO(30))
  .heightIs(AUTO(44));
  _btn_Next.sd_cornerRadius=@(AUTO(22));
}


@end
