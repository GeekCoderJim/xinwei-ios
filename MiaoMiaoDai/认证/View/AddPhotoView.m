//
//  AddPhotoView.m
//  SuXunTong
//
//  Created by 尤鸿斌 on 2017/11/3.
//  Copyright © 2017年 scan. All rights reserved.
//

#import "AddPhotoView.h"

@implementation AddPhotoView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        [self setupViews];
        
    }
    return self;
}

-(void)setupViews{
    

    
    UILabel *photoLab=[[UILabel alloc]initWithFrame:Frame(AUTO(20), AUTO(20), AUTO(100), AUTO(20))];
    photoLab.backgroundColor=[YhbMethods colorWithHexString:@"#ca261e"];
    photoLab.text=@"拍照上传";
    photoLab.font=[UIFont boldSystemFontOfSize:AUTO(14)];
    photoLab.textColor=[UIColor whiteColor];
    photoLab.textAlignment=NSTextAlignmentCenter;
    [self addSubview:photoLab];
    
    self.FrontButton=[UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *front=Image(@"身份证正面");
    [_FrontButton setBackgroundImage:front forState:UIControlStateNormal];
    [self addSubview:_FrontButton];
    _FrontButton.sd_layout
    .topSpaceToView(photoLab, AUTO(30))
    .centerXIs(ScreenWidth/4)
    .widthIs(front.size.width)
    .heightIs(front.size.height);
    
    self.OppoSiteButton=[UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *OppoSite=Image(@"身份证反面");
    [_OppoSiteButton setBackgroundImage:OppoSite forState:UIControlStateNormal];
    [self addSubview:_OppoSiteButton];
    _OppoSiteButton.sd_layout
    .topSpaceToView(photoLab, AUTO(30))
    .centerXIs(ScreenWidth/4*3)
    .widthIs(OppoSite.size.width)
    .heightIs(OppoSite.size.height);
    
//    self.BankCardButton=[UIButton buttonWithType:UIButtonTypeCustom];
//    UIImage *bankcard=Image(@"银行卡正面");
//    [_BankCardButton setBackgroundImage:bankcard forState:UIControlStateNormal];
//    [self addSubview:_BankCardButton];
//    _BankCardButton.sd_layout
//    .topSpaceToView(_FrontButton, AUTO(30))
//    .centerXIs(ScreenWidth/4)
//    .widthIs(bankcard.size.width)
//    .heightIs(bankcard.size.height);
//
//    self.CardWithPeopleButton=[UIButton buttonWithType:UIButtonTypeCustom];
//    UIImage *cardAndPeople=Image(@"手持");
//    [_CardWithPeopleButton setBackgroundImage:cardAndPeople forState:UIControlStateNormal];
//    [self addSubview:_CardWithPeopleButton];
//    _CardWithPeopleButton.sd_layout
//    .topEqualToView(_BankCardButton)
//    .rightEqualToView(_OppoSiteButton)
//    .widthIs(cardAndPeople.size.width)
//    .heightIs(cardAndPeople.size.height);
    
    
    self.FinishButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_FinishButton setTitle:@"下一步" forState:UIControlStateNormal];
    [self setRedButtonHighLight:_FinishButton];
    [self addSubview:_FinishButton];
    _FinishButton.sd_layout
    .topSpaceToView(_OppoSiteButton, AUTO(40))
    .leftSpaceToView(self, AUTO(30))
    .widthIs(ScreenWidth-AUTO(60))
    .heightIs(AUTO(40));
    _FinishButton.sd_cornerRadius=@(AUTO(20));
    
    [self setupAutoContentSizeWithBottomView:_FinishButton bottomMargin:40];
    
}
-(void)setRedButtonHighLight:(UIButton *)btn{
  [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [btn setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5] forState:UIControlStateHighlighted];
  [btn setBackgroundColor:[YhbMethods colorWithHexString:@"#ca261e"]];
}

@end
