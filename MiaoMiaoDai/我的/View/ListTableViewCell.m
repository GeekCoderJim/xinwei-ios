//
//  ListTableViewCell.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/4/8.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "ListTableViewCell.h"

#define orange_Color @"#fc8321" //orange
#define red_Color @"#f73232" //red
#define gold_Color @"#e4c200" //gold

@implementation ListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSeparatorStyleNone;
        self.contentView.backgroundColor=[UIColor whiteColor];
        [self setupviews];
    }
    return self;
}
-(void)setModel:(ListModel *)model{
    int status=[model.status intValue];
    self.moneyLabel.text=[NSString stringWithFormat:@"金额：%@元",model.totalOwe];
    self.replyLabel.text=[NSString stringWithFormat:@"申请日期：%@",model.applyDate];
    self.backLabel.text=[NSString stringWithFormat:@"计划还款日期：%@",model.limitDate];
    switch (status) {
        case 4:
        {
            _statusView.backgroundColor=[YhbMethods colorWithHexString:red_Color];
        }
            break;
        case 7:
        {
            _statusView.backgroundColor=[YhbMethods colorWithHexString:gold_Color];
        }
            break;
        default:
        {
            _statusView.backgroundColor=[YhbMethods colorWithHexString:orange_Color];
        }
            break;
    }
}
-(void)setupviews{
    
    self.statusView=[UIView new];
    _statusView.backgroundColor=[YhbMethods colorWithHexString:gold_Color];
    [self.contentView addSubview:_statusView];
    _statusView.sd_layout
    .topEqualToView(self.contentView)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .heightIs(AUTO(40));
    
    self.statusImage=[[UIImageView alloc]initWithImage:Image(@"icon_money_white")];
    [_statusView addSubview:_statusImage];
    _statusImage.sd_layout
    .topSpaceToView(_statusView, AUTO(5))
    .leftSpaceToView(_statusView, AUTO(10))
    .bottomSpaceToView(_statusView, AUTO(5))
    .widthEqualToHeight();
    
    self.moneyLabel=[UILabel new];
    _moneyLabel.textColor=[UIColor whiteColor];
    _moneyLabel.font=Font(AUTO(14));
    _moneyLabel.text=@"金额：1000元";
    [_statusView addSubview:_moneyLabel];
    _moneyLabel.sd_layout
    .centerYEqualToView(_statusImage)
    .leftSpaceToView(_statusImage, AUTO(10))
    .autoHeightRatio(0);
    [_moneyLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    self.returnButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_returnButton setTitle:@"去还款>>" forState:UIControlStateNormal];
    [_returnButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _returnButton.titleLabel.font=Font(AUTO(AUTO(15)));
    [_statusView addSubview:_returnButton];
    _returnButton.sd_layout
    .centerYEqualToView(_statusImage)
    .rightSpaceToView(_statusView, AUTO(0));
    [_returnButton setupAutoSizeWithHorizontalPadding:AUTO(10) buttonHeight:AUTO(40)];
    
    self.replyLabel=[UILabel new];
    _replyLabel.font=_moneyLabel.font;
    _replyLabel.text=@"申请日期：2018年04月08日 14:27:19";
    [self.contentView addSubview:_replyLabel];
    _replyLabel.sd_layout
    .topSpaceToView(_statusView, AUTO(10))
    .leftSpaceToView(self.contentView, AUTO(10))
    .autoHeightRatio(0);
    [_replyLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    self.backLabel=[UILabel new];
    _backLabel.font=_replyLabel.font;
    _backLabel.text=@"计划还款日期：2018年04月08日 14:27:33";
    [self.contentView addSubview:_backLabel];
    _backLabel.sd_layout
    .topSpaceToView(_replyLabel, AUTO(5))
    .leftSpaceToView(self.contentView, AUTO(10))
    .autoHeightRatio(0);
    [_backLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    UIView *sepview=[UIView new];
    sepview.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self.contentView addSubview:sepview];
    sepview.sd_layout
    .topSpaceToView(_backLabel, AUTO(10))
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .heightIs(AUTO(10));
    
    [self setupAutoHeightWithBottomView:sepview bottomMargin:0];
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
