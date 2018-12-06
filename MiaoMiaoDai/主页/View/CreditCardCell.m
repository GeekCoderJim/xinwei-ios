//
//  CreditCardCell.m
//  SuXunTong
//
//  Created by 尤鸿斌 on 2017/6/30.
//  Copyright © 2017年 scan. All rights reserved.
//

#import "CreditCardCell.h"

#define BANKCARD_BG_RED @"#C55055"
#define BANKCARD_BG_ORANGE @"#D48F48"
#define BANKCARD_BG_BLUE @"#1A65A4"
#define BANKCARD_BG_GREEN @"#008D79"
#define BANKCARD_BG_PURPLE @"#92458D"
#import "YhbMethods.h"

@implementation CreditCardCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
        self.backgroundColor=[YhbMethods colorWithHexString:@"#2E3132"];
        self.selectionStyle=UITableViewCellSeparatorStyleNone;
    }
    return self;
}
-(void)setupViews{
    self.backgroundview=[[UIView alloc]init];
    [self.contentView addSubview:_backgroundview];
    _backgroundview.sd_layout
    .topSpaceToView(self.contentView, AUTO(5))
    .leftSpaceToView(self.contentView, AUTO(10))
    .rightSpaceToView(self.contentView, AUTO(10))
    .heightIs(AUTO(120));
    [YhbMethods setView:_backgroundview CornerRadius:5 AndMasks:YES];
    
    self.bankLogoImage_scale=[UIImageView new];
    _bankLogoImage_scale.alpha=0.1;
    [_backgroundview addSubview:_bankLogoImage_scale];
    _bankLogoImage_scale.sd_layout
    .topSpaceToView(_backgroundview, AUTO(-10))
    .bottomSpaceToView(_backgroundview, AUTO(-10))
    .rightSpaceToView(_backgroundview, AUTO(20))
    .widthEqualToHeight();
    _bankLogoImage_scale.contentMode=UIViewContentModeScaleToFill;
    
    
    UIImageView *bankLogoImage_bg=[UIImageView new];
    bankLogoImage_bg.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];
    [_backgroundview addSubview:bankLogoImage_bg];
    bankLogoImage_bg.sd_layout
    .topSpaceToView(_backgroundview, AUTO(15))
    .leftSpaceToView(_backgroundview, AUTO(15))
    .widthIs(AUTO(40))
    .heightEqualToWidth();
    [YhbMethods setView:bankLogoImage_bg CornerRadius:AUTO(20) AndMasks:NO];
    
    self.bankLogoImage=[UIImageView new];
    [bankLogoImage_bg addSubview:_bankLogoImage];
    _bankLogoImage.sd_layout
    .centerXEqualToView(bankLogoImage_bg)
    .centerYEqualToView(bankLogoImage_bg)
    .widthIs(AUTO(35))
    .heightIs(AUTO(35));
    
    self.bankNameLabel=[UILabel new];
    _bankNameLabel.textColor=[UIColor whiteColor];
    _bankNameLabel.font=[UIFont boldSystemFontOfSize:AUTO(16)];
    [_backgroundview addSubview:_bankNameLabel];
    _bankNameLabel.sd_layout
    .topEqualToView(bankLogoImage_bg)
    .leftSpaceToView(bankLogoImage_bg, AUTO(10))
    .autoHeightRatio(0);
    [_bankNameLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    self.bankCardTypeLabel = [UILabel new];
    _bankCardTypeLabel.text=@"银行卡";
    _bankCardTypeLabel.textColor=[UIColor whiteColor];
    _bankCardTypeLabel.font=Font(AUTO(14));
    [_backgroundview addSubview:_bankCardTypeLabel];
    _bankCardTypeLabel.sd_layout
    .bottomEqualToView(bankLogoImage_bg)
    .leftSpaceToView(bankLogoImage_bg, AUTO(10))
    .autoHeightRatio(0);
    [_bankCardTypeLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    self.lab_CardNum=[UILabel new];
    
    _lab_CardNum.textColor=[UIColor whiteColor];
    _lab_CardNum.font=Font(AUTO(30));
    _lab_CardNum.textAlignment=NSTextAlignmentCenter;
    [_backgroundview addSubview:_lab_CardNum];
    _lab_CardNum.sd_layout
    .bottomSpaceToView(_backgroundview, AUTO(15))
    .rightSpaceToView(_backgroundview, AUTO(15))
    .autoHeightRatio(0);
    [_lab_CardNum setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    
    
   
}
-(void)setModel:(BankCardModel *)model{
    _bankNameLabel.text=model.bankName;
    _lab_CardNum.text=[NSString stringWithFormat:@"**** **** **** %@",[model.cardNumber substringFromIndex:model.cardNumber.length-4]];

    NSString *bankName=model.bankName;
    if ([bankName  rangeOfString:@"工商"].location !=NSNotFound) {
        self.bankLogoImage.image=Image(@"gongshang");
        self.backgroundview.backgroundColor=[YhbMethods colorWithHexString:BANKCARD_BG_RED];
        self.bankLogoImage_scale.image=Image(@"工商银行");
    }else if ([bankName  rangeOfString:@"光大"].location !=NSNotFound) {
        self.bankLogoImage.image=Image(@"guangda");
        self.backgroundview.backgroundColor=[YhbMethods colorWithHexString:BANKCARD_BG_PURPLE];
        self.bankLogoImage_scale.image=Image(@"光大银行");
    }else if ([bankName  rangeOfString:@"建设"].location !=NSNotFound) {
        self.bankLogoImage.image=Image(@"jianshe");
        self.backgroundview.backgroundColor=[YhbMethods colorWithHexString:BANKCARD_BG_BLUE];
        self.bankLogoImage_scale.image=Image(@"建设银行");
    }else if ([bankName  rangeOfString:@"交通"].location !=NSNotFound) {
        self.bankLogoImage.image=Image(@"jiaotong");
        self.backgroundview.backgroundColor=[YhbMethods colorWithHexString:BANKCARD_BG_BLUE];
        self.bankLogoImage_scale.image=Image(@"交通银行");
    }else if ([bankName  rangeOfString:@"民生"].location !=NSNotFound) {
        self.bankLogoImage.image=Image(@"minsheng");
        self.backgroundview.backgroundColor=[YhbMethods colorWithHexString:BANKCARD_BG_GREEN];
        self.bankLogoImage_scale.image=Image(@"民生银行");
    }else if([bankName  rangeOfString:@"农村商业"].location !=NSNotFound||[bankName  rangeOfString:@"农商"].location !=NSNotFound||[bankName  rangeOfString:@"农村信用社"].location !=NSNotFound||[bankName  rangeOfString:@"农村合作银行"].location !=NSNotFound)
    {
        self.bankLogoImage.image=Image(@"nogncunxinyongshe");
        self.backgroundview.backgroundColor=[YhbMethods colorWithHexString:BANKCARD_BG_GREEN];
        self.bankLogoImage_scale.image=Image(@"农商银行");
    }else if ([bankName  rangeOfString:@"农业"].location !=NSNotFound) {
        self.bankLogoImage.image=Image(@"nongye");
        self.backgroundview.backgroundColor=[YhbMethods colorWithHexString:BANKCARD_BG_GREEN];
        self.bankLogoImage_scale.image=Image(@"农业银行");
    }else if ([bankName  rangeOfString:@"浦东发展银行"].location !=NSNotFound||[bankName  rangeOfString:@"浦发"].location !=NSNotFound) {
        self.bankLogoImage.image=Image(@"pufa");
        self.backgroundview.backgroundColor=[YhbMethods colorWithHexString:BANKCARD_BG_BLUE];
        self.bankLogoImage_scale.image=Image(@"浦发银行");
    }else if ([bankName  rangeOfString:@"兴业"].location !=NSNotFound) {
        self.bankLogoImage.image=Image(@"xingye");
        self.backgroundview.backgroundColor=[YhbMethods colorWithHexString:BANKCARD_BG_BLUE];
        self.bankLogoImage_scale.image=Image(@"兴业银行");
    }else if ([bankName  rangeOfString:@"邮政"].location !=NSNotFound||[bankName  rangeOfString:@"邮储"].location !=NSNotFound) {
        self.bankLogoImage.image=Image(@"youzheng");
        self.backgroundview.backgroundColor=[YhbMethods colorWithHexString:BANKCARD_BG_GREEN];
        self.bankLogoImage_scale.image=Image(@"邮政银行");
    }else if ([bankName  rangeOfString:@"招商"].location !=NSNotFound) {
        self.bankLogoImage.image=Image(@"zhaoshang");
        self.backgroundview.backgroundColor=[YhbMethods colorWithHexString:BANKCARD_BG_RED];
        self.bankLogoImage_scale.image=Image(@"招商银行");
    }else if ([bankName isEqualToString:@"中国银行"]) {
        self.bankLogoImage.image=Image(@"zhongguo");
        self.backgroundview.backgroundColor=[YhbMethods colorWithHexString:BANKCARD_BG_RED];
        self.bankLogoImage_scale.image=Image(@"中国银行");
    }else if ([bankName  rangeOfString:@"中信"].location !=NSNotFound) {
        self.bankLogoImage.image=Image(@"zhongxin");
        self.backgroundview.backgroundColor=[YhbMethods colorWithHexString:BANKCARD_BG_RED];
        self.bankLogoImage_scale.image=Image(@"中信银行");
    }else if ([bankName  rangeOfString:@"平安"].location !=NSNotFound) {
        self.bankLogoImage.image=Image(@"pingan");
        self.backgroundview.backgroundColor=[YhbMethods colorWithHexString:BANKCARD_BG_ORANGE];
        self.bankLogoImage_scale.image=Image(@"平安银行");
    }else if ([bankName  rangeOfString:@"华夏"].location !=NSNotFound) {
        self.bankLogoImage.image=Image(@"华夏银行");
        self.backgroundview.backgroundColor=[YhbMethods colorWithHexString:BANKCARD_BG_RED];
        self.bankLogoImage_scale.image=Image(@"华夏银行");
    }else if ([bankName  rangeOfString:@"广发"].location !=NSNotFound) {
        self.bankLogoImage.image=Image(@"guangfa");
        self.backgroundview.backgroundColor=[YhbMethods colorWithHexString:BANKCARD_BG_RED];
        self.bankLogoImage_scale.image=Image(@"广发银行");
    }else {
        self.bankLogoImage.image=Image(@"yinlian");
        self.bankLogoImage_scale.image=Image(@"银联");
        self.backgroundview.backgroundColor=[YhbMethods colorWithHexString:BANKCARD_BG_RED];
    }

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
