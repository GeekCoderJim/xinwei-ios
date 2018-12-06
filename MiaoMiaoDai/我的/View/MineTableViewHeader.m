//
//  MineTableViewHeader.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/2/28.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "MineTableViewHeader.h"

@implementation MineTableViewHeader

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        UIView *topview=[[UIView alloc]initWithFrame:Frame(0, -200, ScreenWidth, frame.size.height-AUTO(90)+200)];
        topview.backgroundColor=[YhbMethods colorWithHexString:COLOR_MAIN];
        [self addSubview:topview];
        
        UIView *bottomview=[[UIView alloc]init];
//        bottomview.backgroundColor=[UIColor whiteColor];
        [self addSubview:bottomview];
        bottomview.sd_layout
        .bottomEqualToView(self)
        .leftEqualToView(self)
        .rightEqualToView(self)
        .heightIs(AUTO(90));
        
        UIView *sepview=[UIView new];
        sepview.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [bottomview addSubview:sepview];
        sepview.sd_layout
        .bottomEqualToView(bottomview)
        .rightEqualToView(bottomview)
        .leftEqualToView(bottomview)
        .heightIs(AUTO(10));
        
        self.returnMoneyButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _returnMoneyButton.backgroundColor=[UIColor whiteColor];
        [bottomview addSubview:_returnMoneyButton];
        _returnMoneyButton.sd_layout
        .topEqualToView(bottomview)
        .bottomSpaceToView(sepview, 0)
        .leftEqualToView(bottomview)
        .widthIs(ScreenWidth/2);
        if (isAppStore) {
            _returnMoneyButton.sd_layout
            .widthIs(0);
        }
        
        UILabel *daihuanjine=[UILabel new];
        daihuanjine.text=@"待还金额";
        daihuanjine.font=Font(AUTO(14));
        [_returnMoneyButton addSubview:daihuanjine];
        daihuanjine.sd_layout
        .centerXEqualToView(_returnMoneyButton)
        .topSpaceToView(_returnMoneyButton, AUTO(18))
        .autoHeightRatio(0);
        [daihuanjine setSingleLineAutoResizeWithMaxWidth:300];
        
        self.moneyLabel=[UILabel new];
        _moneyLabel.text=@"0.0元";
        _moneyLabel.adjustsFontSizeToFitWidth=YES;
        _moneyLabel.textColor=[YhbMethods colorWithHexString:COLOR_MAIN];
        _moneyLabel.textAlignment=NSTextAlignmentCenter;
        [_returnMoneyButton addSubview:_moneyLabel];
        _moneyLabel.sd_layout
        .topSpaceToView(daihuanjine, AUTO(10))
        .leftSpaceToView(_returnMoneyButton, AUTO(5))
        .rightSpaceToView(_returnMoneyButton, AUTO(5))
        .autoHeightRatio(0);
        

        UIView *verticalLine=[UIView new];
        verticalLine.backgroundColor=[UIColor lightGrayColor];
        [_returnMoneyButton addSubview:verticalLine];
        verticalLine.sd_layout
        .topSpaceToView(_returnMoneyButton, AUTO(10))
        .bottomSpaceToView(_returnMoneyButton, AUTO(10))
        .rightEqualToView(_returnMoneyButton)
        .widthIs(AUTO(0.5));
        
        self.bankCardButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _bankCardButton.backgroundColor=[UIColor whiteColor];
        [bottomview addSubview:_bankCardButton];
        _bankCardButton.sd_layout
        .topEqualToView(bottomview)
        .bottomSpaceToView(sepview, 0)
        .leftSpaceToView(_returnMoneyButton, 0)
        .rightEqualToView(bottomview);
        
        UILabel *yinhangka=[UILabel new];
        yinhangka.text=@"银行卡";
        yinhangka.font=Font(AUTO(14));
        [_bankCardButton addSubview:yinhangka];
        yinhangka.sd_layout
        .centerXEqualToView(_bankCardButton)
        .topSpaceToView(_bankCardButton, AUTO(18))
        .autoHeightRatio(0);
        [yinhangka setSingleLineAutoResizeWithMaxWidth:300];
        
        self.bankCardLabel=[UILabel new];
        _bankCardLabel.text=@"0张";
        _bankCardLabel.adjustsFontSizeToFitWidth=YES;
        _bankCardLabel.textColor=[YhbMethods colorWithHexString:COLOR_MAIN];
        _bankCardLabel.textAlignment=NSTextAlignmentCenter;
        [_bankCardButton addSubview:_bankCardLabel];
        _bankCardLabel.sd_layout
        .topSpaceToView(yinhangka, AUTO(10))
        .leftSpaceToView(_bankCardButton, AUTO(5))
        .rightSpaceToView(_bankCardButton, AUTO(5))
        .autoHeightRatio(0);
        
        self.headImageView=[[UIImageView alloc]initWithImage:Image(@"icon_default_head")];
        _headImageView.userInteractionEnabled=YES;
        [self addSubview:_headImageView];
        _headImageView.sd_layout
        .centerYIs((self.frame.size.height-AUTO(90))/2)
        .leftSpaceToView(self, AUTO(10))
        .widthIs(AUTO(60))
        .heightEqualToWidth();
        _headImageView.sd_cornerRadius=@(AUTO(30));
        
        self.nameLabel=[UILabel new];
        _nameLabel.text=@"登录/注册";
        _nameLabel.font=Font(AUTO(18));
        _nameLabel.textColor=[UIColor whiteColor];
        [self addSubview:_nameLabel];
        _nameLabel.sd_layout
        .centerYEqualToView(_headImageView)
        .leftSpaceToView(_headImageView, AUTO(15))
        .autoHeightRatio(0);
        [_nameLabel setSingleLineAutoResizeWithMaxWidth:300];
        
    }
    return self;
}
@end
