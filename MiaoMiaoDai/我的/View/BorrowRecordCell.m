//
//  BorrowRecordCell.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/4/4.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "BorrowRecordCell.h"


#define Status_0_Color @"#1298ff"
#define Status_1_Color @"#797979"
#define Status_2_Color @"#04c900"
#define Status_3_Color @"#fc8321"
#define Status_4_Color @"#f73232"
#define Status_5_Color @"#04c900"
#define Status_6_Color @"#797979"
#define Status_7_Color @"#e4c200" 
#define Status_8_Color @"#797979"

#define Status_0_Text @"审核中"
#define Status_1_Text @"不通过"
#define Status_2_Text @"审核中，待放款"
#define Status_3_Text @"审核中，待还款"
#define Status_4_Text @"已逾期，请尽快还款"
#define Status_5_Text @"已还款"
#define Status_6_Text @"已取消"
#define Status_7_Text @"已延期,待还款"
#define Status_8_Text @"申请被退回"


#define Status_0_Image @"icon_check_white"
#define Status_1_Image @"icon_cancel_white"
#define Status_2_8_Image @"icon_money_white"



@implementation BorrowRecordCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSeparatorStyleNone;
        self.contentView.backgroundColor=[UIColor whiteColor];
        [self setupviews];
    }
    return self;
}
-(void)setModel:(BorrowRecordModel *)model{
    int status=[model.status intValue];
    _amountLabel.text=[NSString stringWithFormat:@"金额：%@元",model.totalOwe];
    _limitDayLabel.text=[NSString stringWithFormat:@"期限：%@天",model.limitDays];
    _dateLabel.text=[NSString stringWithFormat:@"%@",model.applyDate];
    switch (status) {
        case 0:
        {
            _statusView.backgroundColor=[YhbMethods colorWithHexString:Status_0_Color];
            _statusImage.image=Image(Status_0_Image);
            _statusLabel.text=Status_0_Text;
        }
            break;
        case 1:
        {
            _statusView.backgroundColor=[YhbMethods colorWithHexString:Status_1_Color];
            _statusImage.image=Image(Status_1_Image);
            _statusLabel.text=Status_1_Text;
        }
            break;
        case 2:
        {
            _statusView.backgroundColor=[YhbMethods colorWithHexString:Status_2_Color];
            _statusImage.image=Image(Status_2_8_Image);
            _statusLabel.text=Status_2_Text;
        }
            break;
        case 3:
        {
            _statusView.backgroundColor=[YhbMethods colorWithHexString:Status_3_Color];
            _statusImage.image=Image(Status_2_8_Image);
            _statusLabel.text=Status_3_Text;
        }
            break;
        case 4:
        {
            _statusView.backgroundColor=[YhbMethods colorWithHexString:Status_4_Color];
            _statusImage.image=Image(Status_2_8_Image);
            _statusLabel.text=Status_4_Text;
        }
            break;
        case 5:
        {
            _statusView.backgroundColor=[YhbMethods colorWithHexString:Status_5_Color];
            _statusImage.image=Image(Status_2_8_Image);
            _statusLabel.text=Status_5_Text;
        }
            break;
        case 6:
        {
            _statusView.backgroundColor=[YhbMethods colorWithHexString:Status_6_Color];
            _statusImage.image=Image(Status_2_8_Image);
            _statusLabel.text=Status_6_Text;
        }
            break;
        case 7:
        {
            _statusView.backgroundColor=[YhbMethods colorWithHexString:Status_7_Color];
            _statusImage.image=Image(Status_2_8_Image);
            _statusLabel.text=Status_7_Text;
        }
            break;
        case 8:
        {
            _statusView.backgroundColor=[YhbMethods colorWithHexString:Status_8_Color];
            _statusImage.image=Image(Status_2_8_Image);
            _statusLabel.text=Status_8_Text;
        }
            break;
            
            
        default:
            break;
    }
}
-(void)setupviews{
    
    self.statusView=[UIView new];
    _statusView.backgroundColor=[YhbMethods colorWithHexString:Status_0_Color];
    [self.contentView addSubview:_statusView];
    _statusView.sd_layout
    .topEqualToView(self.contentView)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .heightIs(AUTO(40));
    
    self.statusImage=[[UIImageView alloc]initWithImage:Image(@"icon_check_white")];
    [_statusView addSubview:_statusImage];
    _statusImage.sd_layout
    .topSpaceToView(_statusView, AUTO(5))
    .leftSpaceToView(_statusView, AUTO(10))
    .bottomSpaceToView(_statusView, AUTO(5))
    .widthEqualToHeight();
    
    self.statusLabel=[UILabel new];
    _statusLabel.font=Font(AUTO(14));
    _statusLabel.textColor=[UIColor whiteColor];
    [_statusView addSubview:_statusLabel];
    _statusLabel.sd_layout
    .centerYEqualToView(_statusImage)
    .leftSpaceToView(_statusImage, AUTO(5))
    .autoHeightRatio(0);
    [_statusLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    self.amountLabel=[UILabel new];
    _amountLabel.font=_statusLabel.font;
    [self.contentView addSubview:_amountLabel];
    _amountLabel.sd_layout
    .topSpaceToView(_statusView, AUTO(10))
    .leftSpaceToView(self.contentView, AUTO(10))
    .autoHeightRatio(0);
    [_amountLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    self.limitDayLabel=[UILabel new];
    _limitDayLabel.font=_statusLabel.font;
    [self.contentView addSubview:_limitDayLabel];
    _limitDayLabel.sd_layout
    .topSpaceToView(_amountLabel, AUTO(5))
    .leftSpaceToView(self.contentView, AUTO(10))
    .autoHeightRatio(0);
    [_limitDayLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    self.dateLabel=[UILabel new];
    _dateLabel.font=_statusLabel.font;
    [self.contentView addSubview:_dateLabel];
    _dateLabel.sd_layout
    .topSpaceToView(_amountLabel, AUTO(10))
    .rightSpaceToView(self.contentView, AUTO(10))
    .autoHeightRatio(0);
    [_dateLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    UIView *sepview=[UIView new];
    sepview.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self.contentView addSubview:sepview];
    sepview.sd_layout
    .topSpaceToView(_dateLabel, AUTO(10))
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
