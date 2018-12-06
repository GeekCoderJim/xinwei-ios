//
//  MessageTableViewCell.m
//  ShangCheng
//
//  Created by 尤鸿斌 on 2017/11/21.
//  Copyright © 2017年 HongBin You. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
        self.selectionStyle=UITableViewCellSeparatorStyleNone;
    }
    return self;
}
-(void)setModel:(MessageModel *)model{
    _titleLab.text=model.title;
    _timeLab.text=model.createTime;
    _detailLab.text=model.msg;
}
-(void)setupViews{
    self.imageview = [UIImageView new];
    _imageview.image=Image(@"message_type_12");
    [self.contentView addSubview:_imageview];
    _imageview.sd_layout
    .topSpaceToView(self.contentView, AUTO(10))
    .leftSpaceToView(self.contentView, AUTO(10))
    .heightIs(AUTO(44))
    .widthEqualToHeight();
    _imageview.sd_cornerRadius=@(_imageview.height_sd/2);

    
    self.titleLab=[UILabel new];
    _titleLab.text=@"您的订单已送达";
    _titleLab.font=Font(AUTO(16));
    [self.contentView addSubview:_titleLab];
    _titleLab.sd_layout
    .topEqualToView(_imageview)
    .leftSpaceToView(_imageview, AUTO(10))
    .widthIs(AUTO(210))
    .heightIs(AUTO(20));
    
    self.timeLab=[UILabel new];
    _timeLab.text=@"8-19 20:33";
    _timeLab.font=Font(AUTO(13));
    _timeLab.textColor=[UIColor grayColor];
    [self.contentView addSubview:_timeLab];
    _timeLab.sd_layout
    .centerYEqualToView(_titleLab)
    .rightSpaceToView(self.contentView, AUTO(10))
    .autoHeightRatio(0);
    [_timeLab setSingleLineAutoResizeWithMaxWidth:300];
    
    self.detailLab=[UILabel new];
    _detailLab.text=@"订单描述订单描述订单描述订单描述订单描述订单描述订单描述订单描述";
    _detailLab.textColor=[UIColor grayColor];
    _detailLab.font=Font(AUTO(13));
    _detailLab.numberOfLines=1;
    [self.contentView addSubview:_detailLab];
    _detailLab.sd_layout
    .topSpaceToView(_titleLab, AUTO(7))
    .leftSpaceToView(_imageview, AUTO(10))
    .rightSpaceToView(self.contentView, AUTO(10))
    .autoHeightRatio(0);
    
    UIView *line=[[UIView alloc]init];
    line.backgroundColor=COLOR_SEP;
    [self.contentView addSubview:line];
    line.sd_layout
    .topSpaceToView(_detailLab, AUTO(10))
    .leftSpaceToView(self.contentView, AUTO(10))
    .rightEqualToView(self.contentView)
    .heightIs(AUTO(0.5));
    
    [self setupAutoHeightWithBottomView:line bottomMargin:0];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
